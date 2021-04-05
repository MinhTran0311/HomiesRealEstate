using Abp.Zero.Ldap.Authentication;
using Abp.Zero.Ldap.Configuration;
using Homies.RealEstate.Authorization.Users;
using Homies.RealEstate.MultiTenancy;

namespace Homies.RealEstate.Authorization.Ldap
{
    public class AppLdapAuthenticationSource : LdapAuthenticationSource<Tenant, User>
    {
        public AppLdapAuthenticationSource(ILdapSettings settings, IAbpZeroLdapModuleConfig ldapModuleConfig)
            : base(settings, ldapModuleConfig)
        {
        }
    }
}