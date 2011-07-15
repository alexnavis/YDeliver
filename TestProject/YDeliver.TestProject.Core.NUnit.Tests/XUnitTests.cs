using Xunit;
using YDeliver.TestProject.Core.Domain;

namespace YDeliver.TestProject.Core.NUnit.Tests
{
    public class XUnitTests
    {
        [Fact]
        public void yes_I_am_testing_assert()
        {
            Assert.Equal(1, 1);
        }

        [Fact]
        public void Person_FullName_should_return_FirstName_and_LastName_concatenated_with_a_space_between_them()
        {
            var person = new Person("John", "Doe");
            Assert.Equal("John Doe", person.FullName);
        }
    }
}