using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HousesOfHogwarts.Models
{
    public class Frage
    {
        public int Id { get; set; }
        public string Fragetext { get; set; }
        public List<Antwort> Antworten { get; set; }
        

        public Frage(int Id, string Fragentext)
        {
            this.Antworten = new List<Antwort>();
            this.Id = Id;
            this.Fragetext = Fragentext;
        }


        public void SpeichereAntwortenInDb(User User)
        {
            User.SpeichereVorigeFrageInDb(this);
            foreach(Antwort antw in Antworten)
            {
                antw.SpeichereAntwortInDb(User);
            }
        }

        public bool IstBeantwortet()
        {
            bool returnValue = false;
            foreach (Antwort antw in Antworten)
            {
                if (antw.Ausgewaehlt == true)
                {
                    returnValue = true;
                    break;
                }
            }
            return returnValue;
        }

        public string GetFarbe()
        {
            Antwort a = this.Antworten.Where(x => x.Ausgewaehlt == true).FirstOrDefault();
            if (a != null) return a.Farbe;
            else return "#efefef";
        }
    }
}