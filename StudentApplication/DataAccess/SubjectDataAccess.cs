using DataModel;
using Entity;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace DataAccess
{
    public class SubjectDataAccess
    {
        public List<Subject> GetSubjects()
        {
            List<Subject> result = new List<Subject>();
            try
            {
                using (demoEntities db = new demoEntities())
                {
                    var subjectDetails = db.GetSubjects();
                    foreach (var subject in subjectDetails)
                    {
                        Subject sub = new Subject()
                        {
                            Id = subject.Id,
                            Name = subject.SubjectName,
                            Status = subject.Status,
                            SubjectCategoryName = subject.SubjectCategoryName,
                            SubjectCategoryId = subject.SubjectCategoryId
                        };
                        result.Add(sub);
                    }
                }
            }
            catch (Exception ex)
            {

            }
            return result;
        }
        public IList<SubjectCategory> GetSubjectNameAndId()
        {
            IList<SubjectCategory> subjects = new List<SubjectCategory>();
            try
            {
                using (demoEntities db = new demoEntities())
                {                    
                    var subjectsWithId = db.GetSubjectMaster();
                    foreach (var subjectAndId in subjectsWithId)
                    {
                        SubjectCategory objSubjectCategory = new SubjectCategory()
                        {
                            Id = subjectAndId.Id,
                            Name = subjectAndId.Name
                        };
                        subjects.Add(objSubjectCategory);
                    }
                }
            }
            catch (Exception ex)
            {

            }
            return subjects;
        }

        // get IID
        private string GetIID()
        {
            string result = "";
            try
            {
                using (demoEntities db = new demoEntities())
                {
                    string query = "select dbo.fncIID()";
                    var data = db.Database.SqlQuery<string>(query);
                    foreach (var d in data)
                    {
                        result = d.ToString();
                        break;
                    }
                }
            }
            catch (Exception ex)
            {

            }
            return result;
        }

        // store current data present on datagrid into inter table
        public void SaveDataToInterTable(ObservableCollection<Subject> gridData)
        {            
            string IID = GetIID();  // get IID
            List<SubjectInterTable> updatedSubjects = new List<SubjectInterTable>();
            // Construct data to store into Inter Table
            foreach (var data in gridData)
            {
                SubjectInterTable subject = new SubjectInterTable()
                {
                    IID = IID,
                    Id = data.Id,
                    Name = data.Name,
                    SubjectCategoryId = (int)data.SubjectCategoryId,
                    Status = (bool)data.Status
                };
                updatedSubjects.Add(subject);
            }
            try
            {
                using (demoEntities db = new demoEntities())
                {
                    // Finally, Store the data into Inter Table
                    foreach(var subjectData in updatedSubjects)
                    {
                        int success = db.SaveDataToInterTable(subjectData.IID, subjectData.Id, subjectData.Name, subjectData.SubjectCategoryId, subjectData.Status);                        
                    }
                    // Call Store Procedure to sync data between Inter_Table and Subject_Master Table
                    var result = db.Merge_SubjectMaster_SubjectInterTable(IID);                    
                }
            }
            catch (Exception ex)
            {

            }
        }
    }
}