//
//  CommentsScrollView.swift
//  HackerNews
//
//  Created by Viktor Hundahl Strate on 25/04/2018.
//  Copyright © 2018 Viktor Hundahl Strate. All rights reserved.
//

import Cocoa

class CommentsScrollView: NSScrollView {

    override var isFlipped: Bool {
        return true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
