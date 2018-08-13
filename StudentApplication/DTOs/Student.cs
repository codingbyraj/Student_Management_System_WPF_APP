using System;
using System.ComponentModel.DataAnnotations;

namespace Entity
{
    public class Student : NotifyProperyChangedBase
    {
        public Nullable<int> Id { get; set; }

        [Required]
        public string Name { get; set; }

        [Required]
        public string Mobile { get; set; }

        [Required]
        public string Address { get; set; }

        public Nullable<int> Stream { get; set; }

        public string StreamName { get; set; }
    }
}