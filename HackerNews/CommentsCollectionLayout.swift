//
//  CommentsCollectionLayout.swift
//  HackerNews
//
//  Created by Viktor Hundahl Strate on 27/04/2018.
//  Copyright © 2018 Viktor Hundahl Strate. All rights reserved.
//

import Cocoa

class CommentsCollectionLayout: NSCollectionViewLayout {
    
    var commentHeight: Int = 100 // 29
    var commentWidth: Int = 100
    
    override init() {
        super.init()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    override var collectionViewContentSize: NSSize {
        return NSSize(width: commentWidth, height: commentHeight)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: NSRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> NSCollectionViewLayoutAttributes? {
        let attributes = NSCollectionViewLayoutAttributes(forItemWith: indexPath)
        attributes.frame = NSRect(x: 0, y: commentHeight * indexPath.item, width: commentWidth, height: commentHeight)
        
        return attributes
    }
    
    override func layoutAttributesForElements(in rect: NSRect) -> [NSCollectionViewLayoutAttributes] {
        var attributes = [NSCollectionViewLayoutAttributes]()
        
        
        for i in 0..<collectionView!.dataSource!.collectionView(collectionView!, numberOfItemsInSection: 0) {
            if let attribute = layoutAttributesForItem(at: IndexPath(item: i, section: 0)) {
                attributes.append(attribute)
            }
        }
        return attributes
    }

}
