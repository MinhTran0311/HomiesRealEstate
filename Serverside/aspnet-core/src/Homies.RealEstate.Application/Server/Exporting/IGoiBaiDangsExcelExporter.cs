using System.Collections.Generic;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;

namespace Homies.RealEstate.Server.Exporting
{
    public interface IGoiBaiDangsExcelExporter
    {
        FileDto ExportToFile(List<GetGoiBaiDangForViewDto> goiBaiDangs);
    }
}