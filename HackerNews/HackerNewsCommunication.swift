//
//  HackerNewsCommunication.swift
//  HackerNews
//
//  Created by Viktor Hundahl Strate on 23/04/2018.
//  Copyright © 2018 Viktor Hundahl Strate. All rights reserved.
//

import Foundation

class HackerNewsCommunication {
    static let shared = HackerNewsCommunication();
    
    let user: String?
    var posts: [String]
    
    init() {
        self.user = nil;
        self.posts = [];
        
        posts.append("Some new thing!")
    }
    
    func refreshPosts() {
        print("Getting new posts from Hacker News...")
    }
}
