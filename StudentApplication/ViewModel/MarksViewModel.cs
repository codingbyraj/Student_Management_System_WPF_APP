using DataAccess;
using Entity;
using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Input;

namespace ViewModel
{
    public class MarksViewModel: NotifyProperyChangedBase
    {
        #region Public Properties        

        private ObservableCollection<MarksResult> _MarksList;

        public ObservableCollection<MarksResult> MarksList
        {
            get
            {
                return _MarksList;
            }
            set
            {
                if (this.CheckPropertyChanged<ObservableCollection<MarksResult>>("MarksList", ref _MarksList, ref value))
                {
                    this.FirePropertyChanged("MarksList");
                }
            }
        }

        public int RollNumber { get; set; }
        public int RollNumberForUpdateMarks { get; set; }
        #endregion

        #region Public Commands     
        public ICommand OnGetMarksCommand { get; set; }

        public ICommand OnUpdateMarksCommand { get; set; }

        #endregion

        #region constructors
        public MarksViewModel()
        {
            OnGetMarksCommand = new DelegateCommand<object>(GetStudentMarksData);
            OnUpdateMarksCommand = new DelegateCommand<object>(UpdateStudentMarks);
            
        }
        #endregion

        #region Private Methods        
        private void GetStudentMarksData(object obj)
        {
            RollNumberForUpdateMarks = RollNumber;
            MarksDataAccess objMarksDataAccess = new MarksDataAccess();
            if(RollNumber <= 0)
            {
                MessageBox.Show("Enter a valid Roll Number");
            }
            else
            {
                MarksList = objMarksDataAccess.GetMarks(RollNumber);
                if(MarksList.Count == 0)
                {
                    MessageBox.Show("Roll Number doesn't exist!");
                }
            }            
        }        

        private void UpdateStudentMarks(object obj)
        {
            MarksDataAccess objMarksDataAccess = new MarksDataAccess();
            var UpdatedMarksList = objMarksDataAccess.UpdateMarks(MarksList, RollNumberForUpdateMarks);
            MarksList = new ObservableCollection<MarksResult>();
            MarksList = UpdatedMarksList;
            MessageBox.Show("Marks Updated!");
        }
        #endregion
    }
}
