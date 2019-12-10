//
//  ViewController.swift
//  InnocenzoLocherCSC4480
//
//  Created by Rolf Locher on 12/9/19.
//  Copyright © 2019 Innocenzo Locher. All rights reserved.
//

import Cocoa
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class ViewController: NSViewController {
    
    @IBOutlet var documentCollectionView: DocumentCollectionView!
    
    @IBOutlet var conferencePopUpButton: NSPopUpButton!
    
    @IBOutlet var divisionPopUpButton: NSPopUpButton!
    
    @IBOutlet var teamPopUpButton: NSPopUpButton!
    
    @IBOutlet var playerPopUpButton: NSPopUpButton!
    
    var db: Firestore? = nil
    
    var conferences = [String:[String:Any]]()
    var divisions = [String:[String:Any]]()
    var teams = [String:[String:Any]]()
    var players = [String:[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        FirebaseApp.configure()
        Auth.auth().signInAnonymously { (authResult, error) in
            if let error = error {
                print(error)
                return
            }
            
            self.db = Firestore.firestore()
            self.getConferences { (conferences) in
                self.conferencePopUpButton.removeAllItems()
                self.conferencePopUpButton.addItem(withTitle: "Conference")
                for conf in conferences { self.conferencePopUpButton.addItem(withTitle: conf.key) }
                self.conferences = conferences
            }
        }
        documentCollectionView.setup()
    }
    
    @IBAction func conferenceSelected(_ sender: Any) {
        guard let item = conferencePopUpButton.selectedItem else {
            return
        }
        if item.title == "Conference" {
            documentCollectionView.data = [:]
            clearDivisions()
            clearTeams()
            clearPlayers()
            // clear popupbuttons to the right
        }
        else {
            documentCollectionView.data = conferences[item.title] ?? [:]
            getDivisions(inConference: item.title) { (divisions) in
                self.divisionPopUpButton.removeAllItems()
                self.divisionPopUpButton.addItem(withTitle: "Division")
                for div in divisions { self.divisionPopUpButton.addItem(withTitle: div.key) }
                self.divisions = divisions
            }
        }
    }
    
    @IBAction func divisionSelected(_ sender: Any) {
        guard let item = divisionPopUpButton.selectedItem else {
            return
        }
        if item.title == "Division" {
            documentCollectionView.data = [:]
            clearTeams()
            clearPlayers()
            // clear popupbuttons to the right
        }
        else {
            documentCollectionView.data = divisions[item.title] ?? [:]
            getTeams(inDivision: item.title) { (teams) in
                self.teamPopUpButton.removeAllItems()
                self.teamPopUpButton.addItem(withTitle: "Teams")
                for team in teams { self.teamPopUpButton.addItem(withTitle: team.key) }
                self.teams = teams
            }// get teams with item.title as division name
        }
    }
    
    @IBAction func teamSelected(_ sender: Any) {
        guard let item = teamPopUpButton.selectedItem else {
            return
        }
        if item.title == "Team" {
            documentCollectionView.data = [:]
            clearPlayers()
            // clear popupbuttons to the right
        }
        else {
            documentCollectionView.data = teams[item.title] ?? [:]
            getPlayers(inTeam: item.title) { (players) in
                self.playerPopUpButton.removeAllItems()
                self.playerPopUpButton.addItem(withTitle: "Players")
                for player in players { self.playerPopUpButton.addItem(withTitle: player.value["Player"] as! String)}
                self.players = players
            }
        }
    }
    
    @IBAction func playerSelected(_ sender: Any) {
        guard let item = playerPopUpButton.selectedItem else {
            return
        }
        if item.title == "Player" {
            documentCollectionView.data = [:]
        }
        else {
            documentCollectionView.data = players[item.title] ?? [:]
            //getPlayers(inTeam: item.title) { (players) in
              //  self.playerPopUpButton.removeAllItems()
                //self.playerPopUpButton.addItem(withTitle: "Players")
               // for player in players { self.playerPopUpButton.addItem(withTitle: player.key) }
                //self.players = players
           // }
        }

    }
    
    func getConferences(completion: @escaping ([String:[String:Any]]) -> Void) {
        db?.collection("Conferences").getDocuments(completion: { (snapshot, error) in
            guard let snap = snapshot else {
                print(error!)
                return
            }
            var docDict = [String:[String:Any]]()
            for doc in snap.documents {
                docDict[doc.documentID] = doc.data()
            }
            completion(docDict)
        })
    }
    
    func getDivisions(inConference conf: String, completion: @escaping ([String:[String:Any]]) -> Void) {
        db?.collection("Divisions").whereField("conference", isEqualTo: conf).getDocuments(completion: { (snapshot, error) in
            guard let snap = snapshot else {
                print(error!)
                return
            }
            var docDict = [String:[String:Any]]()
            for doc in snap.documents {
                docDict[doc.documentID] = doc.data()
            }
            completion(docDict)
        })
    }
    
    func getTeams(inDivision div: String, completion: @escaping ([String:[String:Any]]) -> Void) {
        db?.collection("Teams").whereField("division", isEqualTo: div).getDocuments(completion: { (snapshot, error) in
            guard let snap = snapshot else {
                print(error!)
                return
            }
            var docDict = [String:[String:Any]]()
            for doc in snap.documents {
                docDict[doc.documentID] = doc.data()
            }
            completion(docDict)
        })
    }
    
    func getPlayers(inTeam team: String, completion: @escaping ([String:[String:Any]]) -> Void) {
        db?.collection("Players").whereField("Team", isEqualTo: team).getDocuments(completion: { (snapshot, error) in
            guard let snap = snapshot else {
                print(error!)
                return
            }
            var docDict = [String:[String:Any]]()
            for doc in snap.documents {
                docDict[doc.documentID] = doc.data()
            }
            print(docDict)
            completion(docDict)
        })
    }
    
    func clearDivisions() {
        divisionPopUpButton.removeAllItems()
        divisionPopUpButton.addItem(withTitle: "Division")
    }
    
    func clearTeams() {
        teamPopUpButton.removeAllItems()
        teamPopUpButton.addItem(withTitle: "Team")
    }
    
    func clearPlayers() {
        playerPopUpButton.removeAllItems()
        playerPopUpButton.addItem(withTitle: "Player")
    }

    override var representedObject: Any? {
        didSet {
            
        }
    }


}

