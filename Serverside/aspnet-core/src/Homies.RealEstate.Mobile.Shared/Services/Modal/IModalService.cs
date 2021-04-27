using System.Threading.Tasks;
using Homies.RealEstate.Views;
using Xamarin.Forms;

namespace Homies.RealEstate.Services.Modal
{
    public interface IModalService
    {
        Task ShowModalAsync(Page page);

        Task ShowModalAsync<TView>(object navigationParameter) where TView : IXamarinView;

        Task<Page> CloseModalAsync();
    }
}
