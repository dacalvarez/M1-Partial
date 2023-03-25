using PCPartsDataLibrary.Models;

namespace PCPartsLibrary.Data
{
    public interface ISqlData
    {
        UserModel Authenticate(string username, string password);
        void DeleteData(string tableName, int id);
        void InsertData(string tableName, string name, string code, string brand, decimal unitPrice);
        List<T> LoadAllData<T>(string tableName);
        void Register(string username, string firstName, string lastName, string password);
        void UpdateData(string tableName, int id, string name, string code, string brand, decimal unitPrice);
    }
}