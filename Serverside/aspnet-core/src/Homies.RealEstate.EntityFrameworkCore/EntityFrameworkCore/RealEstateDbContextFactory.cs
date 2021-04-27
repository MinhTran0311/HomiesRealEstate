using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.Extensions.Configuration;
using Homies.RealEstate.Configuration;
using Homies.RealEstate.Web;

namespace Homies.RealEstate.EntityFrameworkCore
{
    /* This class is needed to run "dotnet ef ..." commands from command line on development. Not used anywhere else */
    public class RealEstateDbContextFactory : IDesignTimeDbContextFactory<RealEstateDbContext>
    {
        public RealEstateDbContext CreateDbContext(string[] args)
        {
            var builder = new DbContextOptionsBuilder<RealEstateDbContext>();
            var configuration = AppConfigurations.Get(
                WebContentDirectoryFinder.CalculateContentRootFolder(),
                addUserSecrets: true
            );

            RealEstateDbContextConfigurer.Configure(builder, configuration.GetConnectionString(RealEstateConsts.ConnectionStringName));

            return new RealEstateDbContext(builder.Options);
        }
    }
}