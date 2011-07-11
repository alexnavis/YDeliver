using NUnit.Framework;

namespace YDeliver.TestProject.Core.NUnit.Tests
{
    [TestFixture]
    public class SimpleTest
    {
        [Test]
        public void Really_simple_test()
        {
            Assert.AreEqual(1, 1);
        }
    }
}