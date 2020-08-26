using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace HousesOfHogwarts.Models
{
    public class Antwort
    {
        public int Id { get; set; }
        public string Antworttext { get; set; }
        public bool Ausgewaehlt { get; set; }

        public string Farbe { get; set; }

        public Frage Frage { get; set; }

        public Antwort(Frage Frage, int Id, string Antworttext)
        {
            this.Frage = Frage;
            this.Id = Id;
            this.Antworttext = Antworttext;
        }

        public void SpeichereAntwortInDb(User User)
        {
            if(this.Ausgewaehlt == true)
            {
                string connStr = ConfigurationManager.ConnectionStrings["HogwartsDatabase"].ConnectionString;
                using (MySqlConnection conn = new MySqlConnection(connStr))
                {
                    using (MySqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandText = string.Format("INSERT INTO users_antworten (id_user, id_antwort) VALUES ({0}, {1})", User.Id, this.Id);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                    }
                }
            }
        }
    }
}