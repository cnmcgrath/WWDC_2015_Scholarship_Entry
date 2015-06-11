//
//  Resume.swift
//  tableTest
//
//  Created by Chris McGrath on 4/23/15.
//  Copyright (c) 2015 Chris McGrath. All rights reserved.
//

import Foundation


class Node {
    let imageName: String?
    let title: String?
    let location: String?
    let about: String?
    
    let age: String?
    let GPA: String?
    let job: String?
    let date: String?
    let major: String?
    
    init(dictionary:NSDictionary) {
        imageName = dictionary["image"]    as? String
        title     = dictionary["name"]     as? String
        location  = dictionary["location"] as? String
        about     = dictionary["about"]    as? String
        major     = dictionary["major"]    as? String
        
        date      = dictionary["date"]     as? String
        age       = dictionary["age"]      as? String
        GPA       = dictionary["GPA"]      as? String
        job       = dictionary["job"]      as? String
    }
    
static func loadMembersFromFile(path:String) -> [Node]
    {
        var nodes : [Node] = []
        
        let data = NSData(contentsOfFile:path)
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            let resume = json["resume"] as! NSArray
            
            for itemDict in resume {
                let item = Node(dictionary: itemDict as! NSDictionary)
                nodes.append(item)
            }
            
            

        }catch{
            
        }
        
        return nodes
    }
}