//
//  CommentViewItem.swift
//  HackerNews
//
//  Created by Viktor Hundahl Strate on 25/04/2018.
//  Copyright © 2018 Viktor Hundahl Strate. All rights reserved.
//

import Cocoa

class CommentViewItem: NSCollectionViewItem {

    @IBOutlet weak var txtComment: NSTextField!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var coloredBox: NSBox!
    
    let depthColors = [
        NSColor(red: 0.93, green: 0.38, blue: 0.34, alpha: 1),
        NSColor(red: 0.8, green: 0.98, blue: 0.29, alpha: 1),
        NSColor(red: 0.29, green: 0.17, blue: 0.98, alpha: 1)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    public func setupComment(body: String, depth: Int) {
        self.txtComment.stringValue = body
        widthConstraint.constant = CGFloat(depth * 3 + 5)
        coloredBox.fillColor = depthColors[depth % depthColors.count]
    }
    
}
