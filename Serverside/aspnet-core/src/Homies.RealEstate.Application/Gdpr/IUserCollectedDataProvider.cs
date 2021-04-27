using System.Collections.Generic;
using System.Threading.Tasks;
using Abp;
using Homies.RealEstate.Dto;

namespace Homies.RealEstate.Gdpr
{
    public interface IUserCollectedDataProvider
    {
        Task<List<FileDto>> GetFiles(UserIdentifier user);
    }
}
