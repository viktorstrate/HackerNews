//
//  CommentsViewController.swift
//  HackerNews
//
//  Created by Viktor Hundahl Strate on 24/04/2018.
//  Copyright © 2018 Viktor Hundahl Strate. All rights reserved.
//

import Cocoa

class CommentsViewController: NSViewController {

    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet weak var itemText: NSTextField!
    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet weak var collectionHeightConstraint: NSLayoutConstraint!
    
    var currentPost: ItemModel? {
        didSet {
            itemText.stringValue = currentPost!.title
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.maxNumberOfColumns = 1
    }

}

extension CommentsViewController: NSCollectionViewDataSource, NSCollectionViewDelegate {
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionHeightConstraint.constant = CGFloat((currentPost?.requestedChildren.count ?? 1) * 110)
        return currentPost?.requestedChildren.count ?? 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier("CommentViewItem"), for: indexPath) as! CommentViewItem
        
        let post = currentPost!.requestedChildren[indexPath.item]
        
        item.setupComment(body: post.body, depth: post.depth)
        
        return item
    }
}
