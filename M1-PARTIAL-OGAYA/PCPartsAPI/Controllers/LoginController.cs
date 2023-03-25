
using PCPartsDataLibrary.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using PCPartsLibrary.Data;
using PCPartsLibrary.Models;

namespace PCPartsAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        private IConfiguration _config;
        private ISqlData _db;
        public LoginController(IConfiguration config, ISqlData db)
        {
            _config = config;
            _db = db;
        }
        [AllowAnonymous]
        [HttpPost]
        [Route("/api/[controller]/login")]

        public ActionResult Login([FromBody] UserLogin login)
        {
            
            if (login == null)
            {
                return BadRequest();
            }

            UserModel user = _db.Authenticate(login.UserName, login.Password);

            if (user != null)
            {
                var token = GenerateToken(user);
                return Ok(new
                {
                    Message = "Login Success!"
                });
            }
            else
            return NotFound(new
            {
                Message = "User not found!"
            });
        }

        private string GenerateToken(UserModel user)
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Jwt:Key"]));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);
            string userIdStr = user.Id.ToString();
            var claims = new[]
            {
                new Claim(ClaimTypes.NameIdentifier, userIdStr),
            };
            var token = new JwtSecurityToken(_config["Jwt:Issuer"],
                _config["Jwt:Audience"],
                claims,
                expires: DateTime.Now.AddMinutes(15),
                signingCredentials: credentials);

            return new JwtSecurityTokenHandler().WriteToken(token);

        }

        [AllowAnonymous]
        [HttpPost]
        [Route("/api/[controller]/register")]
        public ActionResult Register([FromBody] UserModel user)
        {

            if (user == null)
            {
                return BadRequest();
            }

            _db.Register(user.UserName, user.FirstName, user.LastName, user.Password);
            return Ok(new
            {
                Message = "User registered!"
            });
        }
    }
}
