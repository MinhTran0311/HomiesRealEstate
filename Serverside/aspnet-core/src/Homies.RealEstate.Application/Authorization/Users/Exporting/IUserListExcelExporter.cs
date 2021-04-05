using System.Collections.Generic;
using Homies.RealEstate.Authorization.Users.Dto;
using Homies.RealEstate.Dto;

namespace Homies.RealEstate.Authorization.Users.Exporting
{
    public interface IUserListExcelExporter
    {
        FileDto ExportToFile(List<UserListDto> userListDtos);
    }
}