//
//  MainViewController.swift
//  HackerNews
//
//  Created by Viktor Hundahl Strate on 24/04/2018.
//  Copyright © 2018 Viktor Hundahl Strate. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

    @IBOutlet weak var loading: NSProgressIndicator!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loading.startAnimation(self)
        
        HackerNewsCommunication.shared.loading = loading
    }
    
}
