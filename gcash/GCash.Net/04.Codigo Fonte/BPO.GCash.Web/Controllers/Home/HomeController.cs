using BPO.Arquitetura.Web.Controller;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BPO.GCash.Web.Controllers
{
    public class HomeController : BPOControllerBase
    {
        public const string VIEWDATA_SUBTITLE = "SubTitle";
        public const string VIEWDATA_MESSAGE = "Message";

        [Authorize]
        public ActionResult Index()
        {
            ViewData[VIEWDATA_SUBTITLE] = "G-Ca$h";
            ViewData[VIEWDATA_MESSAGE] = "Bem vindo";
            return View();
        }
    }
}