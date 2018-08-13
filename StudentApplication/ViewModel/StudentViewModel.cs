using DataAccess;
using System.Collections.ObjectModel;
using Entity;
using System.Windows.Input;
using System.Windows;
using System.Collections.Generic;
using System;

namespace ViewModel
{
    public class StudentViewModel : NotifyProperyChangedBase
    {
        #region Public Properties

        private bool IsDelete { get; set; }

        private ObservableCollection<Student> _studentList;
        public ObservableCollection<Student> studentList
        {
            get
            {
                return _studentList;
            }
            set
            {
                if (this.CheckPropertyChanged<ObservableCollection<Student>>("studentList", ref _studentList, ref value))
                {
                    this.FirePropertyChanged("studentList");
                }
            }
        }

        public ObservableCollection<Student> studentListCopyData { get; set; }

        private Student _student;
        public Student student
        {
            get
            {
                return _student;
            }
            set
            {
                if (this.CheckPropertyChanged<Student>("student", ref _student, ref value))
                {
                    this.FirePropertyChanged("student");
                }
            }
        }

        private string _NameFilter = String.Empty;
        public string NameFilter
        {
            get
            {
                return _NameFilter;
            }
            set
            {
                if (this.CheckPropertyChanged<string>("NameFilter", ref _NameFilter, ref value))
                {
                    this.FirePropertyChanged("NameFilter");
                }
            }
        }

        private string _RollNumberFilter = String.Empty;
        public string RollNumberFilter
        {
            get
            {
                return _RollNumberFilter;
            }
            set
            {
                if (this.CheckPropertyChanged<string>("RollNumberFilter", ref _RollNumberFilter, ref value))
                {
                    this.FirePropertyChanged("RollNumberFilter");
                }
            }
        }

        private string _StreamFilter = String.Empty;
        public string StreamFilter
        {
            get
            {
                return _StreamFilter;
            }
            set
            {
                if (this.CheckPropertyChanged<string>("StreamFilter ", ref _StreamFilter, ref value))
                {
                    this.FirePropertyChanged("StreamFilter");
                }
            }
        }

        private int PageSize = 8;

        public int Start = 0;

        public int End;

        private bool _LeftCornerPaggingButtonOn = true;
        public bool LeftCornerPaggingButtonOn
        {
            get
            {
                return _LeftCornerPaggingButtonOn;
            }

            set
            {
                if (this.CheckPropertyChanged<bool>("LeftCornerPaggingButtonOn", ref _LeftCornerPaggingButtonOn, ref value))
                {
                    this.FirePropertyChanged("LeftCornerPaggingButtonOn");
                }
            }
        }

        public bool RightCornerPaggingButtonOn { get; set; }

        public IList<SubjectCategory> SubjectNameAndId { get; set; }

        public Student SelectedStudent { get; set; }

        #region Public Commands     
        public ICommand OnSaveDetailsCommand { get; set; }
        public ICommand OnLoadStudentsCommand { get; set; }
        public ICommand MouseDoubleClickCommand { get; set; }
        public ICommand DeleteRecordCommand { get; set; }
        public ICommand UpdateMarksCommand { get; set; }
        public ICommand OnNameFilterCommand { get; set; }
        public ICommand OnRollNumberFilterCommand { get; set; }
        public ICommand OnStreamFilterCommand { get; set; }
        public ICommand OnFirstPageCommand { get; set; }
        public ICommand OnPreviousPageCommand { get; set; }
        public ICommand OnNextPageCommand { get; set; }
        public ICommand OnLastPageCommand { get; set; }
        public ICommand OnMultiFilterCommand { get; set; }

        #endregion

        #endregion

        #region Constructors
        public StudentViewModel()
        {
            student = new Student();
            studentListCopyData = new ObservableCollection<Student>();
            GetSubjectNameAndId();
            GetStudentData();
            OnSaveDetailsCommand = new DelegateCommand<object>(SaveStudentData);
            OnLoadStudentsCommand = new DelegateCommand<object>(LoadStudentData);
            MouseDoubleClickCommand = new DelegateCommand<object>(EditStudentData);
            DeleteRecordCommand = new DelegateCommand<object>(DeleteStudentData);
            UpdateMarksCommand = new DelegateCommand<object>(UpdateMarks);
            OnNameFilterCommand = new DelegateCommand<object>(FilterByName);
            OnRollNumberFilterCommand = new DelegateCommand<object>(FilterByRollNumber);
            OnStreamFilterCommand = new DelegateCommand<object>(FilterByStream);
            OnMultiFilterCommand = new DelegateCommand<object>(MultiFilter);

            OnFirstPageCommand = new DelegateCommand<object>(FirstPageData);
            OnPreviousPageCommand = new DelegateCommand<object>(PreviousPageData);
            OnNextPageCommand = new DelegateCommand<object>(NextPageData);
            OnLastPageCommand = new DelegateCommand<object>(LastPageData);

            IsDelete = false;
        }
        #endregion

        #region Private Methods
        private void GetStudentData()
        {
            StudentDataAccess objStudentDataAccess = new StudentDataAccess();
            studentList = new ObservableCollection<Student>();
            studentList = objStudentDataAccess.GetStudentsData();
            studentListCopyData = studentList;
            RefreshDataGrid();
        }


        private void UpdateList(int id)
        {
            // update the row having Id = result on the list studentList
            bool found = false;

            for (int index = 0; index < studentList.Count; ++index)
            {
                student.Id = id;
                if (studentList[index].Id == id)
                {
                    studentList.RemoveAt(index);
                    studentList.Insert(index, student);
                    found = true;
                    break;
                }
            }
            if (!found)
            {
                foreach (var subject in SubjectNameAndId)
                {
                    if (subject.Id == student.Stream)
                    {
                        student.StreamName = subject.Name;
                    }
                }
                studentList.Add(student);
            }
        }
        private void SaveStudentData(object obj)
        {
            StudentDataAccess objStudentDataAccess = new StudentDataAccess();
            if (student.Name != null && student.Address != null && student.Mobile != null && student.Stream != null) // add student.Stream
            {
                student.Id = student.Id == null ? 0 : student.Id; // if null then 0
                int result = objStudentDataAccess.UpdateStudentData(student, IsDelete);
                UpdateList(result);     // update the row having Id = result on the list studentList
                student = new Student(); // clear the controls data after save
                MessageBox.Show("Data Updated Successfully.");
            }
            else
            {
                MessageBox.Show("Data Entered by you is not valid!");
            }
        }

        private void EditStudentData(object obj)
        {
            // put student's data on controls to edit
            student = SelectedStudent;
        }
        private void LoadStudentData(object obj)
        {
            GetStudentData();
            MessageBox.Show("Records Updated!");
        }

        private void DeleteFromList(int id)
        {
            for (int index = 0; index < studentList.Count; ++index)
            {
                if (studentList[index].Id == id)
                {
                    studentList.RemoveAt(index);
                }
            }
        }
        private void DeleteStudentData(object obj)
        {
            IsDelete = true;
            StudentDataAccess objStudentDataAccess = new StudentDataAccess();
            int deletedId = objStudentDataAccess.UpdateStudentData(SelectedStudent, IsDelete);
            // remove the row having Id = result from studentList
            DeleteFromList(deletedId);
            student = new Student(); // clear the controls data after save 
            MessageBox.Show("Successfully Deleted!");
        }

        private void GetSubjectNameAndId()
        {
            SubjectDataAccess objSubjectDataAccess = new SubjectDataAccess();
            SubjectNameAndId = objSubjectDataAccess.GetSubjectNameAndId();
        }

        private void UpdateMarks(object obj)
        {

        }
        private void FilterByName()
        {                        
            if (NameFilter == "")
            {
                studentList = studentListCopyData;
            }
            else
            {
                foreach (var data in studentList)
                {
                    if (data.Name.ToLower().Contains(NameFilter.ToLower()))
                    {
                        studentList.Add(data);
                    }
                }
            }
        }

        private void FilterByName(object obj)
        {
            //Filter(studentListCopyData, NameFilter);
            studentList = new ObservableCollection<Student>();
            if (NameFilter == "")
            {
                studentList = studentListCopyData;
            }
            else
            {
                foreach (var data in studentListCopyData)
                {
                    if (data.Name.ToLower().Contains(NameFilter.ToLower()))
                    {
                        studentList.Add(data);
                    }
                }
            }
        }
        private void Filter(ObservableCollection<Student> List, string search)
        {
            studentList = new ObservableCollection<Student>();
            if (search == "")
            {
                studentList = studentListCopyData;
            }
            else
            {
                foreach (var data in List)
                {
                    if (data.Name.ToLower().Contains(search.ToLower()))
                    {
                        studentList.Add(data);
                    }
                }
            }
        }


        private void FilterByRollNumber()
        {
            if (RollNumberFilter == "") // if roll number is empty 
            {
                studentList = new ObservableCollection<Student>();
                studentList = studentListCopyData;
            }
            else   // if roll number is entered 
            {
                int Roll;
                bool RollNumberValidation = int.TryParse(RollNumberFilter, out Roll);
                if (RollNumberValidation) // if roll number is valid
                {
                    studentList = new ObservableCollection<Student>();
                    foreach (var data in studentListCopyData)
                    {
                        if (data.Id == Roll)
                        {
                            studentList.Add(data);
                        }
                    }
                }
                else // if roll number is not valid
                {
                    MessageBox.Show("Roll Number must be Numeric!");
                }
            }
        }
        private void FilterByRollNumber(object obj)
        {
            if (RollNumberFilter == "") // if roll number is empty 
            {
                studentList = new ObservableCollection<Student>();
                studentList = studentListCopyData;
            }
            else   // if roll number is entered 
            {
                int Roll;
                bool RollNumberValidation = int.TryParse(RollNumberFilter, out Roll);
                if (RollNumberValidation) // if roll number is valid
                {
                    studentList = new ObservableCollection<Student>();
                    foreach (var data in studentListCopyData)
                    {
                        if (data.Id == Roll)
                        {
                            studentList.Add(data);
                        }
                    }
                }
                else // if roll number is not valid
                {
                    MessageBox.Show("Roll Number must be Numeric!");
                }
            }
        }

        private void FilterByStream()
        {
            if (StreamFilter == "")
            {
                studentList = studentListCopyData;
            }
            else
            {
                foreach (var data in studentListCopyData)
                {
                    if (data.StreamName.ToLower().Contains(StreamFilter))
                    {
                        studentList.Add(data);
                    }
                }
            }
        }
        private void FilterByStream(object obj)
        {
            studentList = new ObservableCollection<Student>();
            if (StreamFilter == "")
            {
                studentList = studentListCopyData;
            }
            else
            {
                foreach (var data in studentListCopyData)
                {
                    if (data.StreamName.ToLower().Contains(StreamFilter))
                    {
                        studentList.Add(data);
                    }
                }
            }
        }

        private void MultiFilter(object obj)
        {

            Console.Write(RollNumberFilter);
            if (RollNumberFilter != "")
            {
                FilterByRollNumber();
            }
            if (NameFilter != "")
            {
                FilterByName();
            }
            if (StreamFilter != "")
            {
                FilterByStream();
            }


        }
        public void RefreshDataGrid()
        {
            if (Start == 0)
            {
                LeftCornerPaggingButtonOn = true;
            }
            else
            {
                LeftCornerPaggingButtonOn = false;
            }
            End = (Start + PageSize) - 1;
            studentList = new ObservableCollection<Student>();
            for (int i = Start; (i <= End && i < studentListCopyData.Count); ++i)
            {
                studentList.Add(studentListCopyData[i]);
            }
        }
        private void FirstPageData(object obj)
        {
            if (Start == 0)
            {
                MessageBox.Show("You are already on the first page!");
            }
            else
            {
                Start = 0;
                LeftCornerPaggingButtonOn = true;
                RefreshDataGrid();
            }
        }
        private void PreviousPageData(object obj)
        {
            if (Start != 0)
            {
                Start -= PageSize;
                RefreshDataGrid();
            }
            else
            {
                MessageBox.Show("You are on the first page! Can't go to previous.");
            }
        }
        private void NextPageData(object obj)
        {
            if ((Start + PageSize - 1) < studentListCopyData.Count) // if next page available
            {
                Start += PageSize;
                RefreshDataGrid();
            }
            else
            {
                MessageBox.Show("You are on the last page! Can't go to next page.");
            }
        }
        private void LastPageData(object obj)
        {
            if ((Start + PageSize) >= studentListCopyData.Count) // if next page available
            {
                MessageBox.Show("You are already on the last page!");
            }
            else
            {
                int count = studentListCopyData.Count;
                int pages = (count % PageSize) == 0 ? (count / PageSize) : (count / PageSize + 1); // calculate number of pages
                Start = PageSize * (pages - 1);
                RefreshDataGrid();
            }
        }
        #endregion
    }
}