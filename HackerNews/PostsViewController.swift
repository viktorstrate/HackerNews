//
//  PostsViewController.swift
//  HackerNews
//
//  Created by Viktor Hundahl Strate on 21/04/2018.
//  Copyright © 2018 Viktor Hundahl Strate. All rights reserved.
//

import Cocoa

class PostsViewController: NSViewController {
    

    @IBOutlet var tableView: NSTableView!
    @IBOutlet weak var scrollView: NSScrollView!
    
    var postsDelegate: SplitViewControllerPostsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 60
        resizeColumn(size: 250)
        HackerNewsCommunication.shared.delegate = self
    }
    
    func resizeColumn(size: CGFloat) {
        let column = tableView.tableColumns[0]
        column.width = size - 5
    }
    
}

extension PostsViewController: NSTableViewDataSource, NSTableViewDelegate {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        print("Table count \(HackerNewsCommunication.shared.posts.count)")
        return HackerNewsCommunication.shared.posts.count;
        //return 10
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?{
        
        let cell: PostCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "defaultPostRow"), owner: self) as! PostCellView
        
        let item = HackerNewsCommunication.shared.posts[row]
        
        cell.txtTitle.stringValue = item.title
        cell.txtUrl.stringValue = item.url
        cell.txtPoints.stringValue = "Points \(item.score)"
        cell.txtUsername.stringValue = item.author
        
        return cell
        
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        self.postsDelegate?.cellWasSelected()
    }
    
}

extension PostsViewController: HackerNewsCommunicationDelegate {
    func postsUpdated() {
        print("Posts updated, reloading data")
        tableView.reloadData()
    }
}
