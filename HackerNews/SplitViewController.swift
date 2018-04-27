//
//  ViewController.swift
//  HackerNews
//
//  Created by Viktor Hundahl Strate on 21/04/2018.
//  Copyright © 2018 Viktor Hundahl Strate. All rights reserved.
//

import Cocoa

class SplitViewController: NSSplitViewController, SplitViewControllerPostsDelegate {
    
    func cellWasSelected() {
        let row = postsViewController.tableView.selectedRow
        let item = HackerNewsCommunication.shared.posts[row]
        
        contentViewController.loadItem(item: item)
    }
    

    @IBOutlet weak var postsViewItem: NSSplitViewItem!
    
    var postsViewController: PostsViewController!
    var contentViewController: ContentViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitView.setPosition(250, ofDividerAt: 0)
        postsViewItem.minimumThickness = 200
        
        HackerNewsCommunication.shared.delegate = self
        
        self.postsViewController = self.childViewControllers[0] as! PostsViewController
        postsViewController.postsDelegate = self
        
        self.contentViewController = self.childViewControllers[1] as! ContentViewController

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    override func splitViewDidResizeSubviews(_ notification: Notification) {
        let postsWidth = splitView.arrangedSubviews[0].bounds.width
        let commentsWidth = splitView.arrangedSubviews[1].bounds.width
        print("Resizing \(postsWidth), \(commentsWidth)")

        let postsVC = self.splitViewItems[0].viewController as! PostsViewController
        postsVC.resizeColumn(size: postsWidth)
        
        let contentVC = self.splitViewItems[1].viewController as! ContentViewController
        
        /*let commentsLayout = contentVC.commentsViewController?.collectionView.collectionViewLayout as! CommentsCollectionLayout
        
        commentsLayout.commentWidth = Int(commentsWidth)
        commentsLayout.invalidateLayout()*/
        
    }

}

extension SplitViewController: NSTableViewDelegate {
    func tableViewSelectionDidChange(_ notification: Notification) {
        print("Selection did change")
    }
}

extension SplitViewController: HackerNewsCommunicationDelegate {
    func postsUpdated() {
        //print("Posts updated, reloading data")
        postsViewController.tableView.reloadData()
        contentViewController.commentsViewController?.collectionView.reloadData()
    }
}

protocol SplitViewControllerPostsDelegate {
    func cellWasSelected()
}
