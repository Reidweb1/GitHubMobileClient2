//
//  User.swift
//  GitHub2Go
//
//  Created by Reid Weber on 10/22/14.
//  Copyright (c) 2014 Reid Weber. All rights reserved.
//

import Foundation
import UIKit

class User {
    var userName: String?
    var userImageString: String?
    var userInformation: NSDictionary?
    var userImage: UIImage?
    
    init(userInfo: NSDictionary) {
        self.userInformation = userInfo
        self.userName = userInformation!.valueForKey("login") as? String
        self.userImageString = userInformation!.valueForKey("avatar_url") as? String
    }
    
    class func parseJOSNDataIntoSingleUser(rawJSONData: NSData) -> User? {
        var error: NSError?
        if let JSONDictionary = NSJSONSerialization.JSONObjectWithData(rawJSONData, options: nil, error: &error) as? NSDictionary {
            
            var user: User?
            
            if let searchitemsArray: NSArray = JSONDictionary["items"] as? NSArray {
                for JSONDict in searchitemsArray {
                    if let userDictionary: NSDictionary = JSONDict as? NSDictionary {
                        var newUser = User(userInfo: userDictionary)
                        user = newUser
                        println(newUser.userName)
                    }
                }
            }
            return user!
        } else {
            return nil
        }
    }
    
    class func parseJOSNDataIntoUsers(rawJSONData: NSData ) -> [User]? {
        
        var error: NSError?
        if let JSONDictionary = NSJSONSerialization.JSONObjectWithData(rawJSONData, options: nil, error: &error) as? NSDictionary {
            
            var users = [User]()
            
            if let searchitemsArray: NSArray = JSONDictionary["items"] as? NSArray {
                for JSONDict in searchitemsArray {
                    if let userDictionary: NSDictionary = JSONDict as? NSDictionary {
                        var newUser = User(userInfo: userDictionary)
                        users.append(newUser)
                        println(newUser.userName)
                    }
                }
            }
            return users
        } else {
            return nil
        }
    }
}