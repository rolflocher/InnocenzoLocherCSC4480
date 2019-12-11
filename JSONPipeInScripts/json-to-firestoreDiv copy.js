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
var divisions =[  

    {
            "division": "Atlantic",
            "conference": "Eastern"
        },
        {
            "division": "Central",
            "conference": "Eastern"
        },
        {
            "division": "Southeast",
            "conference": "Eastern"
        },
        {
            "division": "Northwest",
            "conference": "Western"
        },
        {
            "division": "Pacific",
            "conference": "Western"
        },
        {
            "division": "Southwest",
            "conference": "Western"
        }
]

divisions.forEach(function(obj) {
    db.collection("Divisions").doc(obj.division).set({
        conference: obj.conference
    }).then(function() {
        console.log("Document written with ID: ", obj.division);
    })
    .catch(function(error) {
        console.error("Error adding document: ", error);
    });
});
