//
//  DocumentCollectionViewItem.swift
//  InnocenzoLocherCSC4480
//
//  Created by Rolf Locher on 12/9/19.
//  Copyright © 2019 Innocenzo Locher. All rights reserved.
//

import Cocoa

class DocumentCollectionViewItem: NSCollectionViewItem {
    
    @IBOutlet var keyTextField: NSTextField!
    
    @IBOutlet var valueTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.cornerRadius = 5.0
        view.layer?.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
    }
    
}
