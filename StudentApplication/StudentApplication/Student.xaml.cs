using System.Windows;
using System.Windows.Media;
using ViewModel;


namespace StudentApplication
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        StudentViewModel viewModel;
        public MainWindow()
        {
           InitializeComponent();
            viewModel = new StudentViewModel();
            this.DataContext = viewModel;
            ChangeColorDynamically();
        }


        public void ChangeColorDynamically()
        {            

        }
    }
}
