using System;
using System.Windows;

namespace StudentApplication
{
    /// <summary>
    /// Interaction logic for SocialSiteLogin.xaml
    /// </summary>
    public partial class SocialSiteLogin : Window
    {
        // public string AppID { get; set; }
        public string AccessToken { get; set; }
        public SocialSiteLogin()
        {
            InitializeComponent();
            string AppID = "526993964420180";
            //WBrowser.Navigate(new Uri("https://graph.facebook.com/oauth/authorize?client_id=526993964420180&redirect_uri=http://www.facebook.com/connect/login_success.html&type=user_agent&display=popup", UriKind.Absolute));
            //const string AppId = "224928161551097";



            WBrowser.Navigate(new Uri("https://graph.facebook.com/v2.6/device/login?access_token=526993964420180&scope=public_profile&redirect_uri=http://www.facebook.com/connect/login_success.html", UriKind.Absolute));        

        }

        private void WBrowser_Navigated(object sender, System.Windows.Navigation.NavigationEventArgs e)
        {
            if (e.Uri.ToString().StartsWith("http://www.facebook.com/connect/login_success.html"))
            {
                MessageBox.Show(e.Uri.Fragment);
            }

            var url = e.Uri.ToString();
            if (url.Contains("access_token") && url.Contains("#"))
            {
                url = (new System.Text.RegularExpressions.Regex("#")).Replace(url, "?", 1);
                AccessToken = "";
                //AccessToken = 
                DialogResult = true;
                this.Close();
            }



        }
    }
}
