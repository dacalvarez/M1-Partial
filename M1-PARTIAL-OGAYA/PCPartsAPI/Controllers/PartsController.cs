using Microsoft.AspNetCore.Mvc;
using PCPartsLibrary.Data;
using PCPartsLibrary.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using System.Data;
using System.Data.SqlClient;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace PCPartsWebApp.Controllers
{
    public class PartsController : Controller
    {
        private ISqlData _sql;
        private readonly IConfiguration _configuration;

        public PartsController(ISqlData sql, IConfiguration configuration)
        {
            _sql = sql;
            _configuration = configuration;
        }

        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [Route("/api/[controller]/CreateData")]
        public JsonResult Post(string tableName, string name, string code, string brand, decimal unitPrice)
        {
            string sqlDataSource = _configuration.GetConnectionString("SqlDb");
            using (SqlConnection mycon = new SqlConnection(sqlDataSource))
            {
                mycon.Open();
                using (SqlCommand myCommand = new SqlCommand($"INSERT INTO {tableName} (Name, Code, Brand, UnitPrice) VALUES (@name, @code, @brand, @unitPrice)", mycon))
                {
                    myCommand.Parameters.AddWithValue("@name", name);
                    myCommand.Parameters.AddWithValue("@code", code);
                    myCommand.Parameters.AddWithValue("@brand", brand);
                    myCommand.Parameters.AddWithValue("@unitPrice", unitPrice);
                    int rowsAffected = myCommand.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        return new JsonResult("Data Added Successfully");
                    }
                    else
                    {
                        return new JsonResult("Failed to Add Data");
                    }
                }
            }
        }

        [HttpGet]
        [Route("/api/[controller]/ReadData")]
        public JsonResult SearchParts(string search = null, string category = null, string brand = null, decimal? minPrice = null, decimal? maxPrice = null)
        {
            string sqlDataSource = _configuration.GetConnectionString("SqlDb");
            using (SqlConnection conn = new SqlConnection(sqlDataSource))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("dbo.spParts_SearchFilter", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@SearchString", string.IsNullOrEmpty(search) ? (object)DBNull.Value : search.ToLower());
                cmd.Parameters.AddWithValue("@Category", string.IsNullOrEmpty(category) ? (object)DBNull.Value : category.ToLower());
                cmd.Parameters.AddWithValue("@Brand", string.IsNullOrEmpty(brand) ? (object)DBNull.Value : brand.ToLower());
                cmd.Parameters.AddWithValue("@MinPrice", minPrice.HasValue ? minPrice.Value : (object)DBNull.Value);
                cmd.Parameters.AddWithValue("@MaxPrice", maxPrice.HasValue ? maxPrice.Value : (object)DBNull.Value);
                SqlDataReader reader = cmd.ExecuteReader();
                DataTable dataTable = new DataTable();
                dataTable.Load(reader);
                return new JsonResult(dataTable);
            }
        }

        [HttpPut]
        [Route("/api/[controller]/UpdateData")]
        public JsonResult Update(string tableName, int id, string name, string code, string brand, decimal unitPrice)
        {
            string sqlDataSource = _configuration.GetConnectionString("SqlDb");

            using (SqlConnection connection = new SqlConnection(sqlDataSource))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand("dbo.spParts_UpdateData", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@tableName", tableName);
                    command.Parameters.AddWithValue("@id", id);
                    command.Parameters.AddWithValue("@name", name);
                    command.Parameters.AddWithValue("@code", code);
                    command.Parameters.AddWithValue("@brand", brand);
                    command.Parameters.AddWithValue("@unitPrice", unitPrice);

                    command.ExecuteNonQuery();
                }
            }

            return new JsonResult("Data Updated Successfully");
        }

        [HttpDelete]
        [Route("/api/[controller]/DeleteData")]
        public JsonResult Delete(string tableName, int id)
        {
            string sqlDataSource = _configuration.GetConnectionString("SqlDb");

            using (SqlConnection connection = new SqlConnection(sqlDataSource))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand("dbo.spParts_DeleteData", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@tableName", tableName);
                    command.Parameters.AddWithValue("@id", id);

                    command.ExecuteNonQuery();
                }
            }

            return new JsonResult("Data Deleted Successfully");
        }

        [HttpGet]
        [Route("/api/[controller]/BuildPrice")]
        public JsonResult Build(int? caseId, int? fanId, int? cpuId, int? gpuId, int? ramId, int? moboId, int? psuId, int? ssdId)
        {
            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("SqlDb");
            string[] tableNames = { "CASES", "FANS", "CPU", "GPU", "RAM", "MOBO", "PSU", "SSD" };
            using (SqlConnection mycon = new SqlConnection(sqlDataSource))
            {
                mycon.Open();
                using (SqlCommand myCommand = new SqlCommand("dbo.spParts_Build", mycon))
                {
                    myCommand.CommandType = CommandType.StoredProcedure;
                    myCommand.Parameters.AddWithValue("@CaseId", caseId);
                    myCommand.Parameters.AddWithValue("@FanId", fanId);
                    myCommand.Parameters.AddWithValue("@CpuId", cpuId);
                    myCommand.Parameters.AddWithValue("@GpuId", gpuId);
                    myCommand.Parameters.AddWithValue("@RamId", ramId);
                    myCommand.Parameters.AddWithValue("@MoboId", moboId);
                    myCommand.Parameters.AddWithValue("@PsuId", psuId);
                    myCommand.Parameters.AddWithValue("@SsdId", ssdId);

                    SqlParameter totalParam = new SqlParameter("@TotalPrice", SqlDbType.Decimal);
                    totalParam.Direction = ParameterDirection.Output;
                    totalParam.Precision = 10;
                    totalParam.Scale = 2;
                    myCommand.Parameters.Add(totalParam);

                    SqlDataReader myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();

                    decimal totalPrice = (decimal)totalParam.Value;

                    using (SqlCommand saveCommand = new SqlCommand("INSERT INTO PC ([PC Part], [Name], [UnitPrice]) VALUES (@PCPart, @Name, @UnitPrice)", mycon))
                    {
                        for (int i = 0; i < table.Rows.Count; i++)
                        {
                            DataRow row = table.Rows[i];
                            string tableName = tableNames[i];
                            saveCommand.Parameters.AddWithValue("@PCPart", $"{tableName}");
                            saveCommand.Parameters.AddWithValue("@Name", row["Name"].ToString());
                            saveCommand.Parameters.AddWithValue("@UnitPrice", row["UnitPrice"].ToString());
                            saveCommand.ExecuteNonQuery();
                            saveCommand.Parameters.Clear();
                        }

                        saveCommand.Parameters.AddWithValue("@PCPart", "COMPLETE BUILD");
                        saveCommand.Parameters.AddWithValue("@Name", "Total Price");
                        saveCommand.Parameters.AddWithValue("@UnitPrice", totalPrice.ToString());
                        saveCommand.ExecuteNonQuery();
                    }

                    mycon.Close();

                    return Json(new { Parts = table, TotalPrice = totalPrice });
                }
            }
        }

    }
}