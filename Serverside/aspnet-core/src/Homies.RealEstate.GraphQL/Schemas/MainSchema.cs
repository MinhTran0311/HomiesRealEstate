using Abp.Dependency;
using GraphQL.Types;
using GraphQL.Utilities;
using Homies.RealEstate.Queries.Container;
using System;

namespace Homies.RealEstate.Schemas
{
    public class MainSchema : Schema, ITransientDependency
    {
        public MainSchema(IServiceProvider provider) :
            base(provider)
        {
            Query = provider.GetRequiredService<QueryContainer>();
        }
    }
}