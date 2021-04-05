using System.Threading.Tasks;
using Abp.Dependency;

namespace Homies.RealEstate.MultiTenancy.Accounting
{
    public interface IInvoiceNumberGenerator : ITransientDependency
    {
        Task<string> GetNewInvoiceNumber();
    }
}