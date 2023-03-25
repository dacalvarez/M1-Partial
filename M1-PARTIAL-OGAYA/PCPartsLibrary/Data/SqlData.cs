using Microsoft.Extensions.Configuration;
using PCPartsDataLibrary.Models;
using PCPartsLibrary.Database;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCPartsLibrary.Data
{
    public class SqlData : ISqlData
    {
        private ISqlDataAccess _db;
        private const string connectionStringName = "SqlDb";

        public SqlData(ISqlDataAccess db)
        {
            _db = db;
        }
        public UserModel Authenticate(string username, string password)
        {
            UserModel result = _db.LoadData<UserModel, dynamic>("dbo.spUsers_Authenticate", new { username, password }, connectionStringName, true).FirstOrDefault();
            return result;
        }

        public void Register(string username, string firstName, string lastName, string password)
        {
            _db.SaveData<dynamic>(
                    "dbo.spUsers_Register",
                    new { username, firstName, lastName, password },
                    connectionStringName,
                    true);
        }

        public List<T> LoadAllData<T>(string tableName)
        {
            List<T> result = _db.LoadData<T, dynamic>(
                "dbo.spParts_AllData",
                new { tableName },
                connectionStringName,
                true
            );

            return result;
        }
        public void InsertData(string tableName, string name, string code, string brand, decimal unitPrice)
        {
            _db.SaveData<dynamic>(
                "dbo.spParts_InsertData",
                new { tableName, name, code, brand, unitPrice },
                connectionStringName,
                true);
        }
        public void DeleteData(string tableName, int id)
        {
            _db.SaveData(
                "dbo.spParts_DeleteData",
                new { tableName, id },
                connectionStringName,
                true);
        }

        public void UpdateData(string tableName, int id, string name, string code, string brand, decimal unitPrice)
        {
            _db.SaveData(
                "dbo.spParts_UpdateData",
                new { tableName, id, name, code, brand, unitPrice },
                connectionStringName,
                true);
        }

        public void Build(string tableName)
        {
            _db.SaveData<dynamic>(
                "dbo.spParts_Build",
                new { tableName },
                connectionStringName,
                true);
        }


    }
}
