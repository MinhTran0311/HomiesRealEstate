using System.Collections.Generic;
using Homies.RealEstate.Authorization.Users.Importing.Dto;
using Abp.Dependency;

namespace Homies.RealEstate.Authorization.Users.Importing
{
    public interface IUserListExcelDataReader: ITransientDependency
    {
        List<ImportUserDto> GetUsersFromExcel(byte[] fileBytes);
    }
}
