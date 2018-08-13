using System.Windows.Controls;
using ViewModel;
namespace StudentApplication
{
    /// <summary>
    /// Interaction logic for Marks.xaml
    /// </summary>
    public partial class Marks : Page
    {
        MarksViewModel viewModel;
        public Marks()
        {
            InitializeComponent();
            viewModel = new MarksViewModel();
            this.DataContext = viewModel;
        }
    }
}
