//
//  DocumentCollectionViewItem.swift
//  InnocenzoLocherCSC4480
//
//  Created by Rolf Locher on 12/9/19.
//  Copyright © 2019 Innocenzo Locher. All rights reserved.
//

import Cocoa

protocol DocumentItemDelegate: class {
    func postFieldUpdate(key: String, value: String)
}

class DocumentCollectionViewItem: NSCollectionViewItem {
    
    @IBOutlet var keyTextField: NSTextField!
    
    @IBOutlet var valueTextField: NSTextField!
    
    weak var delegate: DocumentItemDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.cornerRadius = 5.0
        view.layer?.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        valueTextField.isEditable = true
    }
    
    @IBAction func valueTextFieldEnterTapped(_ sender: Any) {
        delegate?.postFieldUpdate(key: keyTextField.stringValue, value: valueTextField.stringValue)
    }
    
}
