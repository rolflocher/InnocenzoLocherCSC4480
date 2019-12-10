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
//            self.db?.collection("firstCollection").addDocument(data: [
//                "field0": "in"
//            ])
        }
        
        documentCollectionView.setup()
        documentCollectionView.data = ["Key":"Value", "Key0":"Value", "Key1":"Value", "Key2":"Value"]
    }

    override var representedObject: Any? {
        didSet {
            
        }
    }


}

