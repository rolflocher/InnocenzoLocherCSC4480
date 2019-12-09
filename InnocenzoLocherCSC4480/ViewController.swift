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
    
    var db: Firestore? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        FirebaseApp.configure()
        Auth.auth().signInAnonymously { (authResult, error) in
            if let error = error {
                print(error)
                return
            }
            
            self.db = Firestore.firestore()
            self.db?.collection("firstCollection").addDocument(data: [
                "field0": "in"
            ])
        }
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

