using DataModel;
using Entity;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace DataAccess
{
    public class MarksDataAccess
    {
        public ObservableCollection<MarksResult> GetMarks(int studentId)
        {
            ObservableCollection<MarksResult> MarksDetails = new ObservableCollection<MarksResult>();
            try
            {
                using (demoEntities db = new demoEntities())
                {
                    var result = db.GetStudentMarks(studentId);
                    foreach (var data in result)
                    {
                        MarksResult marks = new MarksResult()
                        {
                            SubjectId = data.SubjectId,
                            SubjectName = data.SubjectName,
                            Marks = (int)data.StudentMarks
                        };
                        MarksDetails.Add(marks);
                    }
                }
            }
            catch (Exception ex)
            {

            }
            return MarksDetails;
        }

        public ObservableCollection<MarksResult> UpdateMarks(ObservableCollection<MarksResult> MarksList, int RollNumberForUpdateMarks)
        {
            ObservableCollection<MarksResult> UpdatedMarksList = new ObservableCollection<MarksResult>();

            try
            {
                // call to sp
                using (demoEntities db = new demoEntities())
                {
                    foreach (var marks in MarksList)
                    {
                        db.UpdateMarks(RollNumberForUpdateMarks, marks.SubjectId, marks.Marks);
                    }                    
                    var result = db.GetStudentMarks(RollNumberForUpdateMarks);
                    foreach (var data in result)
                    {
                        MarksResult marks = new MarksResult()
                        {
                            SubjectId = data.SubjectId,
                            SubjectName = data.SubjectName,
                            Marks = (int)data.StudentMarks
                        };
                        UpdatedMarksList.Add(marks);
                    }
                }
            }
            catch (Exception ex)
            {

            }

            return UpdatedMarksList;
        }

    }
}
