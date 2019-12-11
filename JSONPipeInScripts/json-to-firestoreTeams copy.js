const firebase = require("firebase");
// Required for side-effects
require("firebase/firestore");

// Initialize Cloud Firestore through Firebase

firebase.initializeApp({
    apiKey: "",
    authDomain: "innocenzolochercsc4480.firebaseapp.com",
    projectId: "innocenzolochercsc4480"
  });

var db = firebase.firestore();
var teams =[  
    {
        "tcode": "ATL",
        "tname": "Hawks",
        "city": "Atlanta",
        "coach": "Lloyd Pierce",
        "payroll": "103572575",
        "division": "Southeast",
        "wins": "29"
    },
    {
        "tcode": "BOS",
        "tname": "Celtics",
        "city": "Boston",
        "coach": "Brad Stevens",
        "payroll": "125505053",
        "division": "Atlantic",
        "wins": "49"
    },
    {
        "tcode": "BRK",
        "tname": "Nets",
        "city": "Brooklyn",
        "coach": "Kenny Atkinson",
        "payroll": "117571620",
        "division": "Atlantic",
        "wins": "42"
    },
    {
        "tcode": "CHO",
        "tname": "Hornets",
        "city": "Charlotte",
        "coach": "James Borrego",
        "payroll": "121810182",
        "division": "Southeast",
        "wins": "39"
    },
    {
        "tcode": "CHI",
        "tname": "Bulls",
        "city": "Chicago",
        "coach": "Jim Boylen",
        "payroll": "112014084",
        "division": "Central",
        "wins": "22"
    },
    {
        "tcode": "CLE",
        "tname": "Cavaliers",
        "city": "Cleveland",
        "coach": "John Beilein",
        "payroll": "123699800",
        "division": "Central",
        "wins": "19"
    },
    {
        "tcode": "DAL",
        "tname": "Mavericks",
        "city": "Dallas",
        "coach": "Rick Carlisle",
        "payroll": "100818906",
        "division": "Southwest",
        "wins": "33"
    },
    {
        "tcode": "DEN",
        "tname": "Nuggets",
        "city": "Denver",
        "coach": "Mike Malone",
        "payroll": "117933609",
        "division": "Northwest",
        "wins": "54"
    },
    {
        "tcode": "DET",
        "tname": "Pistons",
        "city": "Detroit",
        "coach": "Dwayne Casey",
        "payroll": "123481463",
        "division": "Central",
        "wins": "41"
    },
    {
        "tcode": "GSW",
        "tname": "Warriors",
        "city": "Golden State",
        "coach": "Steve Kerr",
        "payroll": "145299879",
        "division": "Pacific",
        "wins": "57"
    },
    {
        "tcode": "HOU",
        "tname": "Rockets",
        "city": "Houston",
        "coach": "Mike D'Antoni",
        "payroll": "121935194",
        "division": "Southwest",
        "wins": "53"
    },
    {
        "tcode": "IND",
        "tname": "Pacers",
        "city": "Indiana",
        "coach": "Nate McMillan",
        "payroll": "110579462",
        "division": "Central",
        "wins": "48"
    },
    {
        "tcode": "LAC",
        "tname": "Clippers",
        "city": "Los Angeles",
        "coach": "Doc Rivers",
        "payroll": "118570700",
        "division": "Pacific",
        "wins": "48"
    },
    {
        "tcode": "LAL",
        "tname": "Lakers",
        "city": "Los Angeles",
        "coach": "Frank Vogel",
        "payroll": "105333698",
        "division": "Pacific",
        "wins": "37"
    },
    {
        "tcode": "MEM",
        "tname": "Grizzlies",
        "city": "Memphis",
        "coach": "Taylor Jenkins",
        "payroll": "124214557",
        "division": "Southwest",
        "wins": "33"
    },
    {
        "tcode": "MIA",
        "tname": "Heat",
        "city": "Miami",
        "coach": "Erik Spolestra",
        "payroll": "123116097",
        "division": "Southeast",
        "wins": "39"
    },
    {
        "tcode": "MIL",
        "tname": "Bucks",
        "city": "Milwaukee",
        "coach": "Mike Budenholzer",
        "payroll": "122368320",
        "division": "Central",
        "wins": "60"
    },
    {
        "tcode": "MIN",
        "tname": "Timberwolves",
        "city": "Minnesota",
        "coach": "Ryan Saunders",
        "payroll": "120348122",
        "division": "Northwestern",
        "wins": "36"
    },
    {
        "tcode": "NOP",
        "tname": "Pelicans",
        "city": "New Orleans",
        "coach": "Alvin Gentry",
        "payroll": "114813259",
        "division": "Southwest",
        "wins": "33"
    },
    {
        "tcode": "NYK",
        "tname": "Knicks",
        "city": "New York",
        "coach": "Mike Miller",
        "payroll": "123265800",
        "division": "Atlantic",
        "wins": "17"
    },
    {
        "tcode": "OKC",
        "tname": "Thunder",
        "city": "Oklahoma City",
        "coach": "Billy Donavan",
        "payroll": "142869264",
        "division": "Northwest",
        "wins": "49"
    },
    {
        "tcode": "ORL",
        "tname": "Magic",
        "city": "Orlando",
        "coach": "Steve Clifford",
        "payroll": "114671036",
        "division": "Southeast",
        "wins": "42"
    },
    {
        "tcode": "PHI",
        "tname": "Sixers",
        "city": "Philadelphia",
        "coach": "Brett Brown",
        "payroll": "111962081",
        "division": "Atlantic",
        "wins": "51"
    },
    {
        "tcode": "PHO",
        "tname": "Suns",
        "city": "Phoenix",
        "coach": "Monty Williams",
        "payroll": "108453793",
        "division": "Pacific",
        "wins": "19"
    },
    {
        "tcode": "POR",
        "tname": "Trailblazers",
        "city": "Portland",
        "coach": "Terry Stotts",
        "payroll": "133096018",
        "division": "Northwest",
        "wins": "53"
    },
    {
        "tcode": "SAC",
        "tname": "Kings",
        "city": "Sacremento",
        "coach": "Luke Walton",
        "payroll": "104038467",
        "division": "Pacific",
        "wins": "39"
    },
    {
        "tcode": "SAS",
        "tname": "Spurs",
        "city": "San Antonio",
        "coach": "Greg Popovivh",
        "payroll": "121745335",
        "division": "Southwest",
        "wins": "48"
    },
    {
        "tcode": "TOR",
        "tname": "Raptors",
        "city": "Toronto",
        "coach": "Nick Nurse",
        "payroll": "137431412",
        "division": "Atlantic",
        "wins": "58"
    },
    {
        "tcode": "UTA",
        "tname": "Jazz",
        "city": "Utah",
        "coach": "Quin Snyder",
        "payroll": "113394016",
        "division": "Northwestern",
        "wins": "50"
    },
    {
        "tcode": "WAS",
        "tname": "Wizards",
        "city": "Washington",
        "coach": "Scott Brooks",
        "payroll": "123501009",
        "division": "Southeast",
        "wins": "32"
    }
]

teams.forEach(function(obj) {
    db.collection("Teams").doc(obj.tcode).set({
        tname: obj.tname,
        city: obj.city,
        coach: obj.coach,
        payroll: obj.payroll,
        division: obj.division,
        wins: obj.wins
    }).then(function() {
        console.log("Document written with ID: ", obj.tcode);
    })
    .catch(function(error) {
        console.error("Error adding document: ", error);
    });
});
