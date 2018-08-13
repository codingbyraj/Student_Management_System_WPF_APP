using DataAccess;
using Entity;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Input;

namespace ViewModel
{
    public class SubjectViewModel : NotifyProperyChangedBase
    {

        #region Public Properties
        public ObservableCollection<Subject> _subjectList;
        public ObservableCollection<Subject> subjectList
        {
            get
            {
                return _subjectList;
            }
            set
            {
                if (this.CheckPropertyChanged<ObservableCollection<Subject>>("subjectList ", ref _subjectList, ref value))
                {
                    this.FirePropertyChanged("subjectList");
                }
            }
        }
        private List<bool> _statusList { get; set; }
        public List<bool> statusList
        {
            get
            {
                return new List<bool>() { true, false };
            }
            set
            {
                _statusList = value;
            }
        }

        private Subject _subject;

        public Subject subject
        {
            get
            {
                return _subject;
            }
            set
            {
                if (this.CheckPropertyChanged<Subject>("subject", ref _subject, ref value))
                {
                    this.FirePropertyChanged("subject");
                }
            }
        }

        public IList<SubjectCategory> SubjectNameAndId { get; set; }

        public String selectedDemo { get; set; }

        private Subject _SelectedSubject;
        public Subject SelectedSubject
        {
            get
            {
                return _SelectedSubject;
            }
            set
            {                
                if (this.CheckPropertyChanged<Subject>("SelectedSubject", ref _SelectedSubject, ref value))
                {
                    this.FirePropertyChanged("SelectedSubject ");
                }
                //object obj = null;
                //DeleteBlankRow(obj);
            }
        }



        #region Public Commands
        public ICommand OnSubjectSaveCommand { get; set; }
        public ICommand OnSubjectDeleteCommand { get; set; }
        public ICommand OnDeleteBlankRowCommand { get; set; }
        
        #endregion

        #endregion

        #region Constructor
        public SubjectViewModel()
        {
            // subject = new Subject(); 
            subjectList = new ObservableCollection<Subject>();
            GetSubjects();
            statusList = new List<bool>();
            GetSubjectNameAndId();
            OnSubjectSaveCommand = new DelegateCommand<object>(SaveSubject);
            OnSubjectDeleteCommand = new DelegateCommand<object>(DeleteSubject);
            OnDeleteBlankRowCommand = new DelegateCommand<object>(DeleteBlankRow);
        }
        #endregion

        #region Private Methods

        private void GetSubjects()
        {
            SubjectDataAccess objSubjectDataAccess = new SubjectDataAccess();
            var subjects = objSubjectDataAccess.GetSubjects();
            AddToSubjectList(subjects);
        }

        private void AddToSubjectList(List<Subject> subjects)
        {
            foreach (var subject in subjects)
            {
                subjectList.Add(subject);
            }
        }
        
        private void GetSubjectNameAndId()
        {
            SubjectDataAccess objSubjectDataAccess = new SubjectDataAccess();
            SubjectNameAndId = objSubjectDataAccess.GetSubjectNameAndId();            
        }
        
        private void SaveSubject(object obj)
        {
            // Call function to get IID
            SubjectDataAccess objSubjectDataAccess = new SubjectDataAccess();

            while(subjectList[subjectList.Count - 1].Name == null)
            {
                subjectList.RemoveAt(subjectList.Count - 1);
            }
            objSubjectDataAccess.SaveDataToInterTable(subjectList);
            subjectList = new ObservableCollection<Subject>();
            GetSubjects();
            MessageBox.Show("Data Updated Successfully.");
        }

        private void DeleteSubject(object obj)
        {
            if (SelectedSubject != null)
            {
                for (int index = 0; index < subjectList.Count; ++index)
                {
                    if (SelectedSubject.Id == subjectList[index].Id)
                    {
                        subjectList.RemoveAt(index);
                        break;
                    }
                }
            }
            else
            {
                MessageBox.Show("Select atleast one row to delete.");
            }
        }

        public void DeleteBlankRow(object obj)
         {
            while(subjectList[subjectList.Count-1].Name == null)
            {
                subjectList.RemoveAt(subjectList.Count - 1);
            }
        }
        #endregion
    }



    
}