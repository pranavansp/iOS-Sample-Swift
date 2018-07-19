//
//  File.swift
//  AppAsign
//
//  Created by Pranavan on 7/14/18.
//  Copyright © 2018 Pranavan. All rights reserved.
//

import Foundation

//MARK:- Articles
class Article : NSObject{
    var author:String!
    var title:String!
    var desc:String!
    var url:String!
    var urlToImage:String!
    var publishedAt:String!
    var source:Source!
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "source"{
            self.source = Source()
            self.source?.setValuesForKeys(value as! [String:AnyObject])
        }else if key == "description"{
            if let desc = value as? String{
                self.desc = String()
                self.desc = desc
            }
        }else{
            super.setValue(value, forKey: key)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("The key \(key) was not found on the object")
    }
    
}

//MARK:- Source
class Source: NSObject {
    var id : String!
    var name : String!
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("The key \(key) was not found on the object")
    }
}


//MARK:- SafeJsonObject
class SafeJsonObject:NSObject{
    override func setValue(_ value: Any?, forKey key: String) {
        guard let first = key.uppercased().first else { return }
        let selectorString = "set\(first)\(String(key.dropFirst())):"
        
        let selector = Selector(selectorString)
        if responds(to: selector) {
            super.setValue(value, forKey: key)
        }
    }
    
}
