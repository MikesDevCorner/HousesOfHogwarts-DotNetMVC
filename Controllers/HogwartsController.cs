using HousesOfHogwarts.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace HousesOfHogwarts.Controllers
{
    public class HogwartsController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Frage()
        {
            Frage Frage = null;
            User User = null;
            if (Request["username"] != null) //wir kommen vom user formular
            {
                User newUser = FragenManager.GeneriereUser(Request["username"]);
                if (newUser.IsValidName() == false)
                {
                    TempData["shortMessage"] = "Name darf nicht leer sein. Bitte korrekten Namen ausfüllen.";
                    return RedirectToAction("Index", "Hogwarts");
                }
                Session["IdUser"] = newUser.Id;
                User = FragenManager.GetFullUserFromDb(newUser.Id);
                Frage = FragenManager.GetFrage(User, 1);
            }
            else //wir kommen vom fragen formular
            {
                User = FragenManager.GetFullUserFromDb(Convert.ToInt32(Session["IdUser"]));
                //antwort speichern
                foreach(Frage f in User.Fragebogen)
                {
                    if(f.Id == Convert.ToInt32(Request["id_frage"]))
                    {
                        foreach(Antwort a in f.Antworten)
                        {
                            if(Convert.ToInt32(Request["id_antwort"]) == a.Id)
                            {
                                a.Ausgewaehlt = true;
                                break;
                            }
                        }
                        f.SpeichereAntwortenInDb(User);
                        break;
                    }
                }

                //nächste frage bekommen
                Frage = FragenManager.GetFrage(User);
            }
            if(Frage == null) return RedirectToAction("Ergebnis", "Hogwarts");
            if (User.GetVorherigeFrage() != null) ViewBag.houseColor = User.GetVorherigeFrage().GetFarbe();
            else ViewBag.houseColor = "#efefef";
            return View(Frage);
        }

        public ActionResult Ergebnis()
        {
            User User = FragenManager.GetFullUserFromDb(Convert.ToInt32(Session["IdUser"]));
            ViewBag.Message = "Ergebnis kommt hier her";

            return View(User);
        }
    }
}