//
//  HackerNewsCommunication.swift
//  HackerNews
//
//  Created by Viktor Hundahl Strate on 23/04/2018.
//  Copyright © 2018 Viktor Hundahl Strate. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HackerNewsCommunication {
    static let shared = HackerNewsCommunication();
    
    let user: String?
    var posts: [ItemModel]
    var loading: NSProgressIndicator?
    
    private var loadingResources: Int
    private var maxLoadingResources: Int
    
    var delegate: HackerNewsCommunicationDelegate?
    
    init() {
        self.user = nil
        self.posts = []
        self.delegate = nil
        
        self.loadingResources = 0
        self.maxLoadingResources = 0
        
        self.loading = nil
        
        refreshPosts()
    }
    
    func refreshPosts() {
        print("Getting new posts from Hacker News...")
        
        addLoadingResources(amount: 51)
        
        Alamofire.request("https://hacker-news.firebaseio.com/v0/topstories.json").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            //print("Result: \(response.result)")                         // response serialization result
            
            self.loadingResourceComplete()
            
            if let json = response.result.value as? [Int32] {
                
                for i in 0...49 {
                    print("Value \(i) = \(json[i])")
                    Alamofire.request("https://hacker-news.firebaseio.com/v0/item/\(json[i]).json")
                        .responseJSON { response in
                        
                            if response.data != nil {
                                do {
                                    let data = try JSON(data: response.data!)
                                    let itemModel = ItemModel(title: data["title"].stringValue, score: data["score"].numberValue, id: data["id"].numberValue, author: data["by"].stringValue, kids: data["kids"].arrayValue.map({$0.numberValue}), timestamp: data["time"].numberValue, url: data["url"].stringValue, textVal: data["text"].stringValue)

                                    self.posts.append(itemModel)
                                    //if self.delegate != nil {
                                    //    self.delegate?.postsUpdated()
                                    //}
                                } catch {
                                    print("Somthing went wrong")
                                }
                            }
                            
                            self.loadingResourceComplete()
                    }
                }
            }
            
            if self.delegate != nil {
                self.delegate?.postsUpdated()
            }
        }
    }
    
    private func addLoadingResources(amount: Int) {
        if (self.loadingResources == 0 && amount > 0) {
            self.loading?.startAnimation(self)
            if self.loading == nil {
                print("Loader is nil")
            }
        }
        
        self.loadingResources += amount
        
        if (maxLoadingResources < loadingResources) {
            maxLoadingResources = loadingResources
        }
        
    }
    
    private func loadingResourceComplete() {
        self.loadingResources -= 1
        
        if loadingResources <= 0 {
            print("All resources has been loaded")
            delegate?.postsUpdated()
            loadingResources = 0
            self.loading?.doubleValue = 100
            self.loading?.stopAnimation(self)
            maxLoadingResources = 0
        } else {
            self.loading?.doubleValue = Double((maxLoadingResources - loadingResources) * 100 / maxLoadingResources)
            print("Progress \(Double((maxLoadingResources - loadingResources) * 100 / maxLoadingResources))")
        }
    }
}

protocol HackerNewsCommunicationDelegate {
    func postsUpdated()
}
