using DataModel;
using System;
using System.Collections.ObjectModel;
using System.Linq;
using Entity;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;

namespace DataAccess
{
    public class StudentDataAccess
    {
        public StudentDataAccess()
        {

        }
        #region Public methods
        public ObservableCollection<Entity.Student> GetStudentsData()
        {
            ObservableCollection<Entity.Student> studentsList = new ObservableCollection<Entity.Student>();
            using (demoEntities db = new demoEntities())
            {
                var students = db.GetStudents();
                foreach (var student in students)
                {
                    Student stud = new Student()
                    {
                        Id = student.Id,
                        Name = student.Name,
                        Mobile = student.Mobile,
                        Address = student.Address,
                        Stream = student.Stream,
                        StreamName = student.StreamName  
                    };
                    studentsList.Add(stud);
                }
            }
            return studentsList;            
        }

        public int UpdateStudentData(Student student, bool isDelete)
        {
            List<int?> result = null; 
            try
            {
                using (demoEntities db = new demoEntities())
                {
                    result = db.UpdateStudent(student.Id, student.Name, student.Address, student.Mobile, student.Stream, isDelete);
                }
            }
            catch (Exception ex)
            {

            }                       
            return (int)result[0];
        }

        
        #endregion
    }
}