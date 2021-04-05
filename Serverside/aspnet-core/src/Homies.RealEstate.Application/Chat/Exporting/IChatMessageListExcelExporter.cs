using System.Collections.Generic;
using Abp;
using Homies.RealEstate.Chat.Dto;
using Homies.RealEstate.Dto;

namespace Homies.RealEstate.Chat.Exporting
{
    public interface IChatMessageListExcelExporter
    {
        FileDto ExportToFile(UserIdentifier user, List<ChatMessageExportDto> messages);
    }
}
