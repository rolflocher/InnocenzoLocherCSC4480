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
    
    var db: Firestore? = nil
    
    var conferences = [String:[String:Any]]()

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
            // clear popupbuttons to the right
        }
        else {
            documentCollectionView.data = conferences[item.title] ?? [:]
            // get divisions with item.title as conference name
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

    override var representedObject: Any? {
        didSet {
            
        }
    }


}

