using System;
using System.Windows.Controls;
using ViewModel;
namespace StudentApplication
{
    /// <summary>
    /// Interaction logic for Subject.xaml
    /// </summary>
    public partial class Subject : Page
    {
        SubjectViewModel viewModel;
        public Subject()
        {
            InitializeComponent();
            viewModel = new SubjectViewModel();
            this.DataContext = viewModel;            
        }

        //private void dgSubject_SelectionChanged(object sender, SelectionChangedEventArgs e)
        //{
        //    var data = (SubjectViewModel)dgSubject.DataContext;
        //    Console.Write(data.subjectList);
        //    //var d = data._subjectList[0].Name;
        //    if(data.subjectList[data.subjectList.Count - 1].Name == null)
        //    {
        //        //data.subjectList.RemoveAt(data.subjectList.Count - 1);
        //        //data.subjectList.Clear();
        //    }            
        //}
    }
}