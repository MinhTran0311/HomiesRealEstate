﻿using Xamarin.Forms;

namespace Homies.RealEstate.Views
{
    public partial class MainView : FlyoutPage, IXamarinView
    {
        public MainView()
        {
            InitializeComponent();
            NavigationPage.SetHasNavigationBar(this, false);
        }
    }
}
