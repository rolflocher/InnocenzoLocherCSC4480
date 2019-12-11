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
var conferences =[  

    {
            "conference": "Eastern"
        },
        {
            "conference": "Western"
        },
]

conferences.forEach(function(obj) {
    db.collection("Conferences").doc(obj.conference).set({
    
    }).then(function() {
        console.log("Document written with ID: ", obj.conference);
    })
    .catch(function(error) {
        console.error("Error adding document: ", error);
    });
});
