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

class ViewController: NSViewController, DocumentItemDelegate {
    
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
    
    var selectedDocId = String()
    var selectedTable = DocLocation.Conferences

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
                for conf in conferences { self.conferencePopUpButton.addItem(withTitle: conf.key) }
                self.conferences = conferences
            }
        }
        documentCollectionView.setup()
        documentCollectionView.parentDelegate = self
    }
    
    @IBAction func conferenceSelected(_ sender: Any) {
        guard let item = conferencePopUpButton.selectedItem else {
            return
        }
        selectedTable = .Conferences
        selectedDocId = item.title
        clearDivisions()
        clearTeams()
        clearPlayers()
        if item.title == "Conference" {
            documentCollectionView.data = [:]
        }
        else {
            documentCollectionView.data = conferences[item.title] ?? [:]
            getDivisions(inConference: item.title) { (divisions) in
                for div in divisions { self.divisionPopUpButton.addItem(withTitle: div.key) }
                self.divisions = divisions
            }
        }
    }
    
    @IBAction func divisionSelected(_ sender: Any) {
        guard let item = divisionPopUpButton.selectedItem else {
            return
        }
        selectedTable = .Divisions
        selectedDocId = item.title
        clearTeams()
        clearPlayers()
        if item.title == "Division" {
            documentCollectionView.data = [:]
        }
        else {
            documentCollectionView.data = divisions[item.title] ?? [:]
            getTeams(inDivision: item.title) { (teams) in
                for team in teams { self.teamPopUpButton.addItem(withTitle: team.key) }
                self.teams = teams
            }
        }
    }
    
    @IBAction func teamSelected(_ sender: Any) {
        guard let item = teamPopUpButton.selectedItem else {
            return
        }
        selectedTable = .Teams
        selectedDocId = item.title
        clearPlayers()
        if item.title == "Team" {
            documentCollectionView.data = [:]
        }
        else {
            documentCollectionView.data = teams[item.title] ?? [:]
            getPlayers(inTeam: item.title) { (players) in
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
            selectedTable = .Players
            selectedDocId = players[item.title]!["uid"] as! String
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
                docDict[doc["Player"] as! String] = doc.data()
                docDict[doc["Player"] as! String]!["uid"] = doc.documentID
            }
            completion(docDict)
        })
    }
    
    func postFieldUpdate(key: String, value: String) {
        view.window?.makeFirstResponder(view)
        db?.collection("\(selectedTable)").document(selectedDocId).updateData([
            key: value
        ])
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

enum DocLocation {
    case Conferences
    case Divisions
    case Teams
    case Players
}

