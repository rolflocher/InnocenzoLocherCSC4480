//
//  DocumentCollectionView.swift
//  InnocenzoLocherCSC4480
//
//  Created by Rolf Locher on 12/9/19.
//  Copyright © 2019 Innocenzo Locher. All rights reserved.
//

import Cocoa

class DocumentCollectionView: NSCollectionView, NSCollectionViewDataSource {
    
    var data = [String:Any]() {
        didSet {
            doc = []
            for (key, value) in data {
                doc.append([
                    "key": key,
                    "value": value
                ])
            }
            let scrollSize = CGSize(width: Int(frame.width), height: 50*doc.count/3)
            enclosingScrollView?.setFrameSize(scrollSize)
        }
    }
    var doc = [[String:Any]]()
    
    var flow = NSCollectionViewFlowLayout()
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return doc.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        guard let item = makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "DocumentCollectionViewItem"), for: indexPath) as? DocumentCollectionViewItem else {
            return NSCollectionViewItem()
        }
        item.keyTextField.stringValue = String(describing: doc[indexPath.item]["key"]!) + ":"
        item.valueTextField.stringValue = String(describing: doc[indexPath.item]["value"]!)
        return item
    }
        
    func setup() {
        dataSource = self
        configureFlowLayout()
    }
    
    func configureFlowLayout() {
        let numItemsPerRow = 3
        flow.minimumInteritemSpacing = 10
        flow.minimumLineSpacing = 10
        flow.itemSize = NSSize(width: frame.width/CGFloat(numItemsPerRow) - flow.minimumInteritemSpacing * CGFloat(numItemsPerRow), height: 50)
        collectionViewLayout = flow
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
}
