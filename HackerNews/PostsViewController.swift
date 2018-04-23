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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 42
        resizeColumn(size: 250)
    }
    
    func resizeColumn(size: CGFloat) {
        print("Resizing from posts")
        let column = tableView.tableColumns[0]
        column.width = size
    }
    
}

extension PostsViewController: NSTableViewDataSource, NSTableViewDelegate {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return HackerNewsCommunication.shared.posts.count;
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?{
        
        let cell: PostCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "defaultPostRow"), owner: self) as! PostCellView
        
        cell.txtTitle.stringValue = HackerNewsCommunication.shared.posts[row]
        
        return cell
        
    }
    
}
