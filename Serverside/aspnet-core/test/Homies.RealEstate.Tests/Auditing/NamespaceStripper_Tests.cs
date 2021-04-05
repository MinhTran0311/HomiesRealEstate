using Homies.RealEstate.Auditing;
using Homies.RealEstate.Test.Base;
using Shouldly;
using Xunit;

namespace Homies.RealEstate.Tests.Auditing
{
    // ReSharper disable once InconsistentNaming
    public class NamespaceStripper_Tests: AppTestBase
    {
        private readonly INamespaceStripper _namespaceStripper;

        public NamespaceStripper_Tests()
        {
            _namespaceStripper = Resolve<INamespaceStripper>();
        }

        [Fact]
        public void Should_Stripe_Namespace()
        {
            var controllerName = _namespaceStripper.StripNameSpace("Homies.RealEstate.Web.Controllers.HomeController");
            controllerName.ShouldBe("HomeController");
        }

        [Theory]
        [InlineData("Homies.RealEstate.Auditing.GenericEntityService`1[[Homies.RealEstate.Storage.BinaryObject, Homies.RealEstate.Core, Version=1.10.1.0, Culture=neutral, PublicKeyToken=null]]", "GenericEntityService<BinaryObject>")]
        [InlineData("CompanyName.ProductName.Services.Base.EntityService`6[[CompanyName.ProductName.Entity.Book, CompanyName.ProductName.Core, Version=1.10.1.0, Culture=neutral, PublicKeyToken=null],[CompanyName.ProductName.Services.Dto.Book.CreateInput, N...", "EntityService<Book, CreateInput>")]
        [InlineData("Homies.RealEstate.Auditing.XEntityService`1[Homies.RealEstate.Auditing.AService`5[[Homies.RealEstate.Storage.BinaryObject, Homies.RealEstate.Core, Version=1.10.1.0, Culture=neutral, PublicKeyToken=null],[Homies.RealEstate.Storage.TestObject, Homies.RealEstate.Core, Version=1.10.1.0, Culture=neutral, PublicKeyToken=null],]]", "XEntityService<AService<BinaryObject, TestObject>>")]
        public void Should_Stripe_Generic_Namespace(string serviceName, string result)
        {
            var genericServiceName = _namespaceStripper.StripNameSpace(serviceName);
            genericServiceName.ShouldBe(result);
        }
    }
}
