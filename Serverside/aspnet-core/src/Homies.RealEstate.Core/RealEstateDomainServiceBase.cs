using Abp.Domain.Services;

namespace Homies.RealEstate
{
    public abstract class RealEstateDomainServiceBase : DomainService
    {
        /* Add your common members for all your domain services. */

        protected RealEstateDomainServiceBase()
        {
            LocalizationSourceName = RealEstateConsts.LocalizationSourceName;
        }
    }
}
