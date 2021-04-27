using System.Collections.Generic;
using Homies.RealEstate.Authorization.Users.Importing.Dto;
using Homies.RealEstate.Dto;

namespace Homies.RealEstate.Authorization.Users.Importing
{
    public interface IInvalidUserExporter
    {
        FileDto ExportToFile(List<ImportUserDto> userListDtos);
    }
}
