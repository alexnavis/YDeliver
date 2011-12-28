using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;

namespace YDeliver.TestProject.Web.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /Home/

        public ActionResult Index()
        {
            ViewData.Add("environment", WebConfigurationManager.AppSettings["environment"]);
            return View();
        }

    }
}
