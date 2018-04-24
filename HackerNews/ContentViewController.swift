//
//  ContentViewController.swift
//  HackerNews
//
//  Created by Viktor Hundahl Strate on 24/04/2018.
//  Copyright © 2018 Viktor Hundahl Strate. All rights reserved.
//

import Cocoa
import WebKit

var webContext = 0

class ContentViewController: NSViewController, WKNavigationDelegate {
    @IBOutlet weak var btnComments: TabButton!
    @IBOutlet weak var btnAtricle: TabButton!
    @IBOutlet weak var tabView: NSTabView!
    @IBOutlet weak var topTabView: NSTabView!
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var webProgress: NSProgressIndicator!
    
    var shownView: Int {
        get {
            return tabView.indexOfTabViewItem(tabView.selectedTabViewItem!)
        }
        
        set {
            self._setTabView(view: newValue)
        }
    }
    
    private var _shownView: Int = 0
    var currentItem: ItemModel?
    var commentsViewController: CommentsViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.shownView = 0
        webView.allowsBackForwardNavigationGestures = true
        webView.allowsLinkPreview = true
        webView.allowsMagnification = true
        
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: &webContext)
        
        webView.load(URLRequest(url: URL(string: "https://google.com/")!))
        
    }
    
    func loadItem (item: ItemModel) {
        currentItem = item
        webView.load(URLRequest(url: URL(string: item.url)!))
        commentsViewController?.itemText.stringValue = item.title
    }
    
    private func _setTabView(view: Int) {
        _shownView = view
        tabView.selectTabViewItem(at: _shownView)
        topTabView.selectTabViewItem(at: _shownView)
        
        if view == 0 {
            btnComments.state = .on
            btnAtricle.state = .off
        } else {
            btnComments.state = .off
            btnAtricle.state = .on
        }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let commentsVC = segue.destinationController as? CommentsViewController {
            commentsViewController = commentsVC
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let change = change else { return }
        if context != &webContext {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }

        if keyPath == "estimatedProgress" {
            if let progress = (change[NSKeyValueChangeKey.newKey] as AnyObject).doubleValue {
                webProgress.doubleValue = progress * 100
            }
            return
        }
    }
    
    
    @IBAction func btnCommentsAction(_ sender: Any) {
        self.shownView = 0
    }
    
    @IBAction func btnArticleAction(_ sender: Any) {
        self.shownView = 1
    }
}
