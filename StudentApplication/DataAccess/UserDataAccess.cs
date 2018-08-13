using DataModel;

namespace DataAccess
{
    public class UserDataAccess
    {
        public bool IsUserAuthorize(string userName, string password)
        {
            demoEntities db = new demoEntities();
            var result = db.CheckUserLogin(userName, password);

            if (result[0] > 0)
            {
                return true;
            }
            return false;

            // temporary logic of login
            //if (userName == password)
            //{
            //    return true;
            //}
            //return false;
        }
    }
}
