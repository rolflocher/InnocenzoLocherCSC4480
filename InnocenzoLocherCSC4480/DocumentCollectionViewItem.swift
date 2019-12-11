//
//  DocumentCollectionViewItem.swift
//  InnocenzoLocherCSC4480
//
//  Created by Rolf Locher on 12/9/19.
//  Copyright © 2019 Innocenzo Locher. All rights reserved.
//

import Cocoa

protocol DocumentItemDelegate: class {
    func postFieldUpdate(key: String, value: String, completion: @escaping ()->Void)
}

class DocumentCollectionViewItem: NSCollectionViewItem {
    
    @IBOutlet var keyTextField: NSTextField!
    
    @IBOutlet var valueTextField: NSTextField!
    
    weak var delegate: DocumentItemDelegate? = nil
    
    var test: String = "" //{
//        get {return self.representedObject as! String}
//        set {}
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.cornerRadius = 5.0
        view.layer?.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        valueTextField.isEditable = true
    }
    
    @IBAction func valueTextFieldEnterTapped(_ sender: Any) {
        //valueTextField.isEnabled = false
        delegate?.postFieldUpdate(key: keyTextField.stringValue, value: valueTextField.stringValue, completion: {
            //self.valueTextField.isEnabled = true
            //self.valueTextField.resignFirstResponder()
//            (sender as? NSTextField)?.resignFirstResponder()
            //self.valueTextField.resignFirstResponder()
            //self.view.window?.becomeFirstResponder()
            self.becomeFirstResponder()
        })
        
//        print(test)
//
//        print(super.collectionView ?? "no super collectionview")
//        print((collectionView as? DocumentCollectionView) ?? "could not cast")
//        (collectionView as? DocumentCollectionView)?.postFieldUpdate(key: keyTextField.stringValue, value: valueTextField.stringValue, completion: {
//            self.valueTextField.isEditable = true
//        })
    }
    
}
