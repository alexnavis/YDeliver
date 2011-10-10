using NUnit.Framework;
using YDeliver.TestProject.Core.Domain;

namespace YDeliver.TestProject.Core.NUnit.Tests
{
    [TestFixture]
    public class NUnitTests
    {
        [Test]
        public void yes_I_am_testing_assert()
        {
            Assert.AreEqual(1, 1);
        }

        [Test]
        public void Person_FullName_should_return_FirstName_and_LastName_concatenated_with_a_space_between_them()
        {
            var person = new Person("John", "Doe");
            Assert.AreEqual("John Doe", person.FullName);
        }
    }
}