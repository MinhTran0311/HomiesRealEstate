using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using Homies.RealEstate.EntityFrameworkCore;

namespace Homies.RealEstate.HealthChecks
{
    public class RealEstateDbContextHealthCheck : IHealthCheck
    {
        private readonly DatabaseCheckHelper _checkHelper;

        public RealEstateDbContextHealthCheck(DatabaseCheckHelper checkHelper)
        {
            _checkHelper = checkHelper;
        }

        public Task<HealthCheckResult> CheckHealthAsync(HealthCheckContext context, CancellationToken cancellationToken = new CancellationToken())
        {
            if (_checkHelper.Exist("db"))
            {
                return Task.FromResult(HealthCheckResult.Healthy("RealEstateDbContext connected to database."));
            }

            return Task.FromResult(HealthCheckResult.Unhealthy("RealEstateDbContext could not connect to database"));
        }
    }
}
