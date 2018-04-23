//
//  PostsViewController.swift
//  HackerNews
//
//  Created by Viktor Hundahl Strate on 21/04/2018.
//  Copyright © 2018 Viktor Hundahl Strate. All rights reserved.
//

import Cocoa

class PostsViewController: NSViewController {

    @IBOutlet var tableView: NSTableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.rowHeight = 42
        
    }
    
}

extension PostsViewController: NSTableViewDataSource, NSTableViewDelegate {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 10;
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?{
        
        let cell: PostCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "defaultPostRow"), owner: self) as! PostCellView
        
        cell.txtTitle.stringValue = "Hello #\(row)"
         
        print("Returning view for \(row)")
        
        return cell
        
    }
    
}
