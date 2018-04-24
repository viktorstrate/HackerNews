//
//  ItemModel.swift
//  HackerNews
//
//  Created by Viktor Hundahl Strate on 24/04/2018.
//  Copyright © 2018 Viktor Hundahl Strate. All rights reserved.
//

import Foundation

class ItemModel {
    let title: String
    let score: NSNumber
    let id: NSNumber
    let author: String
    let kids: [NSNumber]
    let timestamp: Date
    let url: String
    
    init(title: String, score: NSNumber, id: NSNumber, author: String, kids: [NSNumber], timestamp: NSNumber, url: String) {
        self.title = title
        self.score = score
        self.id = id
        self.author = author
        self.kids = kids
        self.timestamp = Date(timeIntervalSince1970: TimeInterval(exactly: timestamp)!)
        self.url = url
    }
}
