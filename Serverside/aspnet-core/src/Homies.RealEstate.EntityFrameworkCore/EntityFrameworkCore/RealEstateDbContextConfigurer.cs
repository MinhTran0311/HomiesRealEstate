using System.Data.Common;
using Microsoft.EntityFrameworkCore;

namespace Homies.RealEstate.EntityFrameworkCore
{
    public static class RealEstateDbContextConfigurer
    {
        public static void Configure(DbContextOptionsBuilder<RealEstateDbContext> builder, string connectionString)
        {
            
            builder.UseMySql(connectionString,ServerVersion.AutoDetect(connectionString));
        }

        public static void Configure(DbContextOptionsBuilder<RealEstateDbContext> builder, DbConnection connection)
        {
            builder.UseMySql(connection.ConnectionString, ServerVersion.AutoDetect(connection.ConnectionString)); 
        }
    }
}