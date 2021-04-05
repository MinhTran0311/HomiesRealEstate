using System;
using Homies.RealEstate.Core;
using Homies.RealEstate.Core.Dependency;
using Homies.RealEstate.Services.Permission;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace Homies.RealEstate.Extensions.MarkupExtensions
{
    [ContentProperty("Text")]
    public class HasPermissionExtension : IMarkupExtension
    {
        public string Text { get; set; }
        
        public object ProvideValue(IServiceProvider serviceProvider)
        {
            if (ApplicationBootstrapper.AbpBootstrapper == null || Text == null)
            {
                return false;
            }

            var permissionService = DependencyResolver.Resolve<IPermissionService>();
            return permissionService.HasPermission(Text);
        }
    }
}