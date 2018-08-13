using System.Windows;
using ViewModel;

namespace StudentApplication
{
    /// <summary>
    /// Interaction logic for Subject1.xaml
    /// </summary>
    public partial class Subject1 : Window
    {
        SubjectViewModel viewModel;
        public Subject1()
        {

        }
        public Subject1(string rollNumber)
        {
            InitializeComponent();
            viewModel = new SubjectViewModel();
            this.DataContext = viewModel;
        }
    }
}
