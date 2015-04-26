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
        title     = dictionary["name"]    as? String
        location  = dictionary["location"] as? String
        about     = dictionary["about"] as? String
        major     = dictionary["major"] as? String
        
        date      = dictionary["date"]     as? String
        age       = dictionary["age"]      as? String
        GPA       = dictionary["GPA"]      as? String
        job       = dictionary["job"]      as? String
    }
    
    class func loadMembersFromFile(path:String) -> [Node]
    {
        var nodes:[Node] = []
        var error:NSError? = nil
        if let data = NSData(contentsOfFile: path, options:nil, error:&error),
            json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error:&error) as? NSDictionary,
            team = json["resume"] as? [NSDictionary] {
                for memberDictionary in team {
                    let item = Node(dictionary: memberDictionary)
                    nodes.append(item)
                }
        }
        return nodes
    }
}