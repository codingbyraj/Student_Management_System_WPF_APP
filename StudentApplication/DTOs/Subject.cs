using System;

namespace Entity
{
    public class Subject
    {
        public int Id { get; set; }
        public string Name { get; set; }                
        public Nullable<int> SubjectCategoryId { get; set; }
        public string SubjectCategoryName { get; set; }
        public Nullable<bool> Status { get; set; }
        
    }
}