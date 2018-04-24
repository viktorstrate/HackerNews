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
        let width = splitView.arrangedSubviews[0].bounds.width
        print("Resizing \(width)")

        let vc = self.splitViewItems[0].viewController as! PostsViewController
        vc.resizeColumn(size: width)
        
    }

}

extension SplitViewController: NSTableViewDelegate {
    func tableViewSelectionDidChange(_ notification: Notification) {
        print("Selection did change")
    }
}

protocol SplitViewControllerPostsDelegate {
    func cellWasSelected()
}
