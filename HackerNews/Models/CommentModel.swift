//
//  CommentModel.swift
//  HackerNews
//
//  Created by Viktor Hundahl Strate on 27/04/2018.
//  Copyright © 2018 Viktor Hundahl Strate. All rights reserved.
//

import Foundation

class CommentModel {
    let body: String
    let author: String
    let id: NSNumber
    let children: [NSNumber]
    let requestedChildren: [CommentModel]
    let parent: NSNumber
    let time: NSDate
    let depth: Int
    
    init(body: String, author: String, id: NSNumber, children: [NSNumber], parent: NSNumber, time: NSNumber, depth: Int) {
        self.body = body
        self.author = author
        self.id = id
        self.children = children
        self.parent = parent
        self.time = NSDate(timeIntervalSince1970: TimeInterval(exactly: time)!)
        requestedChildren = []
        self.depth = depth
    }
}
