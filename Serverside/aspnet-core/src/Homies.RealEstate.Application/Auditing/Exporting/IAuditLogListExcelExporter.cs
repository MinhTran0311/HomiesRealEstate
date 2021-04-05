using System.Collections.Generic;
using Homies.RealEstate.Auditing.Dto;
using Homies.RealEstate.Dto;

namespace Homies.RealEstate.Auditing.Exporting
{
    public interface IAuditLogListExcelExporter
    {
        FileDto ExportToFile(List<AuditLogListDto> auditLogListDtos);

        FileDto ExportToFile(List<EntityChangeListDto> entityChangeListDtos);
    }
}
