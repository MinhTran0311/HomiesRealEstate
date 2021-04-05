using System.Threading.Tasks;
using Abp.Application.Services.Dto;
using Homies.RealEstate.MultiTenancy.Accounting.Dto;

namespace Homies.RealEstate.MultiTenancy.Accounting
{
    public interface IInvoiceAppService
    {
        Task<InvoiceDto> GetInvoiceInfo(EntityDto<long> input);

        Task CreateInvoice(CreateInvoiceDto input);
    }
}
