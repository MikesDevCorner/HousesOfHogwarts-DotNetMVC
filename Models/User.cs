using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace HousesOfHogwarts.Models
{
    public class User
    {

        public int Id { get; set; }
        public string Name { get; set; }
        public List<Frage> Fragebogen { get; set; }

        private int _IdVorherigeFrage { get; set; }

        public bool IsValidName()
        {
            return this.Name != "";
        }

        public User()
        {
            this.Fragebogen = new List<Frage>();
        }


        public Frage GetVorherigeFrage()
        {
            Frage returnFrage = null;
            foreach(Frage fra in Fragebogen)
            {
                if(fra.Id == this._IdVorherigeFrage)
                {
                    returnFrage = fra;
                    break;
                }
            }
            return returnFrage;
        }

        public void SetVorherigeFrage(int Id)
        {
            this._IdVorherigeFrage = Id;
        }

        public void SpeichereVorigeFrageInDb(Frage Frage)
        {
            this.SetVorherigeFrage(Frage.Id);
            string connStr = ConfigurationManager.ConnectionStrings["HogwartsDatabase"].ConnectionString;
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                using (MySqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = string.Format("UPDATE users SET id_letzte_frage = {0} WHERE id = {1}", Frage.Id, this.Id);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }
        }

    }
}