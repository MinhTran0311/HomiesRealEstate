using Xamarin.Forms.Internals;

namespace Homies.RealEstate.Behaviors
{
    [Preserve(AllMembers = true)]
    public interface IAction
    {
        bool Execute(object sender, object parameter);
    }
}