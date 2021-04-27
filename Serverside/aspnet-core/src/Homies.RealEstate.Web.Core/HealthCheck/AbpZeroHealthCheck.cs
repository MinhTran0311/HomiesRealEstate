using Microsoft.Extensions.DependencyInjection;
using Homies.RealEstate.HealthChecks;

namespace Homies.RealEstate.Web.HealthCheck
{
    public static class AbpZeroHealthCheck
    {
        public static IHealthChecksBuilder AddAbpZeroHealthCheck(this IServiceCollection services)
        {
            var builder = services.AddHealthChecks();
            builder.AddCheck<RealEstateDbContextHealthCheck>("Database Connection");
            builder.AddCheck<RealEstateDbContextUsersHealthCheck>("Database Connection with user check");
            builder.AddCheck<CacheHealthCheck>("Cache");

            // add your custom health checks here
            // builder.AddCheck<MyCustomHealthCheck>("my health check");

            return builder;
        }
    }
}
