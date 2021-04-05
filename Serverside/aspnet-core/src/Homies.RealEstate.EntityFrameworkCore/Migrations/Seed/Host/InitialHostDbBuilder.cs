using Homies.RealEstate.EntityFrameworkCore;

namespace Homies.RealEstate.Migrations.Seed.Host
{
    public class InitialHostDbBuilder
    {
        private readonly RealEstateDbContext _context;

        public InitialHostDbBuilder(RealEstateDbContext context)
        {
            _context = context;
        }

        public void Create()
        {
            new DefaultEditionCreator(_context).Create();
            new DefaultLanguagesCreator(_context).Create();
            new HostRoleAndUserCreator(_context).Create();
            new DefaultSettingsCreator(_context).Create();

            _context.SaveChanges();
        }
    }
}
