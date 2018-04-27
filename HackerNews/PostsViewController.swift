//
//  PostsViewController.swift
//  HackerNews
//
//  Created by Viktor Hundahl Strate on 21/04/2018.
//  Copyright © 2018 Viktor Hundahl Strate. All rights reserved.
//

import Cocoa

var postsContext = 0

class PostsViewController: NSViewController {
    

    @IBOutlet var tableView: NSTableView!
    @IBOutlet weak var scrollView: NSScrollView!
    
    var postsDelegate: SplitViewControllerPostsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 60
        resizeColumn(size: 250)
        
        let enclosingView = tableView.enclosingScrollView!
        
        enclosingView.postsBoundsChangedNotifications = true
        NotificationCenter.default.addObserver(self, selector: #selector(scrollEvent(notification:)), name: NSView.boundsDidChangeNotification, object: nil)
        
    }
    
    @objc func scrollEvent(notification: NSNotification) {
        if let sv = tableView.enclosingScrollView {
            let scrollLength = sv.documentVisibleRect.maxY
            let scrollSize = tableView.frame.size.height
            
            if (scrollSize - scrollLength < 500) {
                HackerNewsCommunication.shared.loadMore()
            }
        }
    }
    
    func resizeColumn(size: CGFloat) {
        let column = tableView.tableColumns[0]
        column.width = size - 5
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        print("Observing")
        
        if keyPath == "verticalScroller" {
            print("You scrolled")
        }
        
    }
    
}

extension PostsViewController: NSTableViewDataSource, NSTableViewDelegate {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        //print("Table count \(HackerNewsCommunication.shared.posts.count)")
        return HackerNewsCommunication.shared.posts.count;
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?{
        
        let cell: PostCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "defaultPostRow"), owner: self) as! PostCellView
        
        let item = HackerNewsCommunication.shared.posts[row]
        
        cell.txtTitle.stringValue = item.title
        cell.txtUrl.stringValue = item.url.absoluteString
        cell.txtDetails.stringValue = "\(item.score) points by \(item.author)"
        
        return cell
        
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        self.postsDelegate?.cellWasSelected()
    }
    
}
