using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace HousesOfHogwarts.Models
{
    public static class FragenManager
    {
        public static User GeneriereUser(string Username)
        {
            User newGeneratedUser = new User();
            newGeneratedUser.Name = Username;

            string connStr = ConfigurationManager.ConnectionStrings["HogwartsDatabase"].ConnectionString;
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                using (MySqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = string.Format("INSERT INTO Users (username) VALUES ('{0}')", Username);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    newGeneratedUser.Id = (int) cmd.LastInsertedId;
                }
            }
            return newGeneratedUser;
        }

        public static User GetFullUserFromDb(int UserId)
        {
            User UserFromDb = new User();
            UserFromDb.Id = UserId;
            
            string connStr = ConfigurationManager.ConnectionStrings["HogwartsDatabase"].ConnectionString;
            using (MySqlConnection conn = new MySqlConnection(connStr))
            {
                using (MySqlCommand cmd = conn.CreateCommand())
                {
                    cmd.CommandText = "SELECT antworten.id as id_antwort, id_frage, antworttext, fragentext, hintergrundfarbe FROM antworten INNER JOIN fragen ON antworten.id_frage = fragen.id INNER JOIN hausinfos ON antworten.id_haus = hausinfos.id;";
                    conn.Open();
                    MySqlDataReader reader = cmd.ExecuteReader();
                    
                    while(reader.Read())
                    {
                        Frage fra = UserFromDb.Fragebogen.Where(x => x.Id == reader.GetInt32("id_frage")).FirstOrDefault();
                        if (fra == null)
                        {
                            fra = new Frage(reader.GetInt32("id_frage"), reader.GetString("fragentext"));
                            UserFromDb.Fragebogen.Add(fra);
                        }
                        Antwort aw = new Antwort(fra, reader.GetInt32("id_antwort"), reader.GetString("antworttext"));
                        aw.Farbe = reader.GetString("hintergrundfarbe");
                        fra.Antworten.Add(aw);
                    }
                    reader.Close();

                    cmd.CommandText = string.Format("SELECT id_antwort, id_letzte_frage, username FROM users INNER JOIN users_antworten ON users.id = users_antworten.id_user WHERE users.id = {0};", UserId);
                    reader = cmd.ExecuteReader();
                    bool letzteFrageErledigt = false;
                    while (reader.Read())
                    {
                        if(letzteFrageErledigt == false)
                        {
                            UserFromDb.SetVorherigeFrage(reader.GetInt32("id_letzte_frage"));
                            UserFromDb.Name = reader.GetString("username");
                            letzteFrageErledigt = true;
                        }
                        foreach(Frage fra in UserFromDb.Fragebogen)
                        {
                            foreach(Antwort aw in fra.Antworten)
                            {
                                if(aw.Id == reader.GetInt32("id_antwort"))
                                {
                                    aw.Ausgewaehlt = true;
                                }
                            }
                        }
                    }
                    reader.Close();
                    conn.Close();
                }
            }
            return UserFromDb;
        }

        public static List<Teilergebnis> GetBenutzerErgebnis(User User)
        {
            return null;
        }

        public static Frage GetFrage(User User, int IdFrage)
        {
            List<Frage> UnbeantworteteFragen = new List<Frage>();
            foreach(Frage fra in User.Fragebogen)
            {
                if(IdFrage != -1)
                {
                    if(fra.Id == IdFrage)
                    {
                        return fra;
                    }
                }
                else
                {
                    if(fra.IstBeantwortet() == false)
                    {
                        UnbeantworteteFragen.Add(fra);
                    }
                }
            }
            if (UnbeantworteteFragen.Count > 0)
            {
                Random rand = new Random();
                return UnbeantworteteFragen[rand.Next(UnbeantworteteFragen.Count)];
            }
            else return null;

        }

        public static Frage GetFrage(User User)
        {
            return GetFrage(User, -1);
        }

    }
}