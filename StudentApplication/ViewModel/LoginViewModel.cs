using DataAccess;

namespace ViewModel
{
    public class LoginViewModel
    {
        public bool iAsuthorize(string userName, string password)
        {
            bool result = false;
            UserDataAccess objUserDataAccess = new UserDataAccess();
            if(objUserDataAccess.IsUserAuthorize(userName, password))
            {
                result = true;
            }
            return result;

        }
    }
}
