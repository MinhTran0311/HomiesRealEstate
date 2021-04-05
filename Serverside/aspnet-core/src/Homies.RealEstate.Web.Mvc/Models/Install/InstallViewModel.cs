using System.Collections.Generic;
using Abp.Localization;
using Homies.RealEstate.Install.Dto;

namespace Homies.RealEstate.Web.Models.Install
{
    public class InstallViewModel
    {
        public List<ApplicationLanguage> Languages { get; set; }

        public AppSettingsJsonDto AppSettingsJson { get; set; }
    }
}
