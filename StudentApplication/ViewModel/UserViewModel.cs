using Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;

namespace ViewModel
{
    class UserViewModel: NotifyProperyChangedBase
    {
        #region Properties
        public ICommand OnSaveUserCommand { get; set; }
        #endregion
        #region Constructor
        public UserViewModel()
        {
            OnSaveUserCommand = new DelegateCommand<object>(SaveUser);
        }
        #endregion
        #region Private Methods
        public void SaveUser(object obj)
        {

        }
        #endregion
    }
}
