namespace Homies.RealEstate.Services.Permission
{
    public interface IPermissionService
    {
        bool HasPermission(string key);
    }
}