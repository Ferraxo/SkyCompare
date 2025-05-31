package main

import (
	"crypto/md5"
	"database/sql" // Interactuación con la base de datos
	"encoding/json"
	"strconv"
	"strings"

	"fmt" // Imprimir en consola
	"io"

	"math/rand" //aleatorios
	// Ayuda a escribir en la respuesta
	"net/http" // El paquete HTTP

	_ "github.com/go-sql-driver/mysql" // La librería para mySQL
)

type User struct {
	nickname, full_name, email, pass, fav_airport string
	id                                            int
}

type Airport struct {
	Id       int    `json:"id"`
	Name     string `json:"name"`
	Location string `json:"location"`
	IATA     string `json:"IATA"`
}

type Route struct {
	Id          int     `json:"id"`
	Departure   string  `json:"departure"`
	Destination string  `json:"arrival"`
	Duration    int     `json:"duration"`
	Avg_price   float32 `json:"price"`
}

type Company struct {
	Id       int     `json:"id"`
	Name     string  `json:"name"`
	Multiply float32 `json:"multiply"`
}

type Fly struct {
	Airway Route   `json:"route"`
	Corpor Company `json:"company"`
	Price  float32 `json:"price"`
}

func databaseConection() (db *sql.DB, e error) {
	user := "root"
	pass := "aaaa"
	host := "tcp(127.0.0.1:3306)"
	databaseName := "skycompare"

	db, err := sql.Open("mysql", fmt.Sprintf("%s:%s@%s/%s", user, pass, host, databaseName))
	if err != nil {
		return nil, err
	}
	return db, nil
}

func login(w http.ResponseWriter, r *http.Request) {
	if r.Method != "GET" {
		return
	}
	r.ParseForm()
	fmt.Print(r)

	fmt.Print("\nPetition of login " + r.Form.Get("nickname") + "\n")
	db, err := databaseConection()
	if err != nil {
		fmt.Printf("Error getting database: %v", err)
		return
	}

	rows, err := db.Query("SELECT * FROM users WHERE nickname=? AND pass=?", r.Form.Get("nickname"), r.Form.Get("password"))
	var u User
	users := []User{}
	fmt.Printf("\nSearching user in db\n")
	fmt.Print(err)
	for rows.Next() {
		rows.Scan(&u.id, &u.nickname, &u.full_name, &u.email, &u.pass, &u.fav_airport)
		users = append(users, u)
		fmt.Printf("%v\n", u)
	}

	if len(users) == 0 {
		io.WriteString(w, "User or password are incorrect")
	} else {
		io.WriteString(w, "ok")
	}

}

func register(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()
	fmt.Print(r)
	fmt.Print(r.Form.Get("nickname"))

	db, err := databaseConection()
	if err != nil {
		fmt.Printf("Error getting database: %v", err)
		return
	}

	data := []byte(r.Form.Get("password"))
	fmt.Printf("%x", md5.Sum(data))

	rows, err := db.Query("SELECT * FROM users WHERE nickname=?", r.Form.Get("nickname"))

	defer db.Close()

	var u User
	users := []User{}
	fmt.Printf("\nTesting if new user is in db\n")
	for rows.Next() {
		rows.Scan(&u.id, &u.nickname, &u.full_name, &u.email, &u.pass, &u.fav_airport)
		users = append(users, u)
		fmt.Printf("%v\n", u)
	}

	if len(users) != 0 {
		io.WriteString(w, "User is in db")
	} else {
		id := 0
		row, err := db.Query("SELECT MAX(id) FROM users")
		row.Next()
		row.Scan(&id)
		if err == nil {
			sentence, err := db.Prepare("INSERT INTO users (id, nickname, full_name, email, pass, fav_airport) VALUES(?,?,?,?,?,?)")
			if err == nil {
				_, err := sentence.Exec((id + 1), r.Form.Get("nickname"), r.Form.Get("full_name"), r.Form.Get("email") /*md5.Sum(data)*/, r.Form.Get("password"), nil)
				if err != nil {
					fmt.Printf("\nError in Exec: %v", err)
				}
				io.WriteString(w, "User registration confirmed")
			} else {
				fmt.Printf("\nError in query for id: %v\n", err)
			}
		} else {
			fmt.Printf("\nError in query: %v\n", err)
		}
	}
}

func airports(w http.ResponseWriter, r *http.Request) {
	fmt.Printf("\nCharging airports")
	db, err := databaseConection()
	if err != nil {
		fmt.Printf("Error getting database: %v", err)
		return
	}

	rows, err := db.Query("SELECT id, name, location, IATA FROM airports")

	defer rows.Close()

	if err == nil {
		airports := []Airport{}

		for rows.Next() {
			var a Airport
			rows.Scan(&a.Id, &a.Name, &a.Location, &a.IATA)
			airports = append(airports, a)
			fmt.Printf("%v\n", a)
		}

		fmt.Print(airports)

		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(airports)
	} else {
		fmt.Printf("\n%v", err)
	}
}

func airportsWithoutOne(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()
	var noAirport = r.Form.Get("IATA")
	fmt.Printf("\nCharging airports minus %s", noAirport)

	db, err := databaseConection()
	if err != nil {
		fmt.Printf("Error getting database: %v", err)
		return
	}

	rows, err := db.Query("SELECT id, name, location, IATA FROM airports")

	defer rows.Close()

	if err == nil {
		airports := []Airport{}

		for rows.Next() {
			var a Airport
			rows.Scan(&a.Id, &a.Name, &a.Location, &a.IATA)
			if a.IATA != noAirport {
				airports = append(airports, a)
				fmt.Printf("%v\n", a)
			}
		}

		fmt.Print(airports)

		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(airports)
	} else {
		fmt.Printf("\n%v", err)
	}
}

func getRoutes(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()
	var dep = r.Form.Get("dep")
	var arr = r.Form.Get("arr")
	fmt.Printf("\nSearching routes for %s-%s", dep, arr)

	db, err := databaseConection()
	if err != nil {
		fmt.Printf("Error getting database: %v", err)
		return
	}

	rows, err := db.Query("SELECT * FROM routes WHERE departure=? && destination=?", dep, arr)
	corporations, err2 := db.Query("SELECT * FROM company")

	defer rows.Close()
	defer corporations.Close()

	if err == nil && err2 == nil {
		airways := []Fly{}
		companies := []Company{}

		for corporations.Next() {
			var c Company
			corporations.Scan(&c.Id, &c.Name, &c.Multiply)
			companies = append(companies, c)
		}

		var r Route
		for rows.Next() {
			rows.Scan(&r.Id, &r.Departure, &r.Destination, &r.Duration, &r.Avg_price)
			fmt.Printf("\n%v", r)
		}

		var rnd = rand.Intn(4)

		fmt.Printf("\n%d companies on route\n", rnd)
		comps := "    "
		for count := 0; count <= rnd; count++ {
			num := rand.Intn(len(companies))
			if !strings.Contains(comps, strconv.Itoa(num)) {
				comps = comps + strconv.Itoa(num) + "    "
				ranComponent := rand.Float32()*(1.35-0.65) + 0.65
				price := r.Avg_price * companies[num].Multiply * ranComponent
				f := Fly{r, companies[num], price}
				airways = append(airways, f)
			} else {
				count = count - 1
			}
		}
		fmt.Print(airways)

		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(airways)
	} else {
		fmt.Printf("\n%v", err)
	}
}

func middlewareCors(next http.Handler) http.Handler {
	return http.HandlerFunc(
		func(w http.ResponseWriter, r *http.Request) {
			// Just put some headers to allow CORS...
			w.Header().Set("Access-Control-Allow-Origin", "*")
			w.Header().Set("Access-Control-Allow-Credentials", "true")
			w.Header().Set("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE")
			w.Header().Set("Access-Control-Allow-Headers", "Accept, Content-Type, Content-Length, Accept-Encoding, X-CSRF-Token, Authorization")

			if r.Method == "OPTIONS" {
				return
			}

			// and call next handler!
			next.ServeHTTP(w, r)
		})
}

func main() {
	app := http.NewServeMux()

	db, err := databaseConection()
	if err != nil {
		fmt.Printf("Error getting database: %v", err)
		return
	}

	// Test connection
	err = db.Ping()
	if err != nil {
		fmt.Printf("Error in connection: %v", err)
		return
	} else {
		fmt.Printf("Connection right")
	}

	app.HandleFunc("/register", register)
	app.HandleFunc("/login", login)
	app.HandleFunc("/airports", airports)
	app.HandleFunc("/airports/selected", airportsWithoutOne)
	app.HandleFunc("/routes", getRoutes)

	http.ListenAndServe(":5152", middlewareCors(app))

	// close connection at the end of fucntion
	defer db.Close()
}
