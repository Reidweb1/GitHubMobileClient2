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
    var userBio: String?
    var hireable: Bool?
    
    init(userInfo: NSDictionary) {
        self.userInformation = userInfo
        self.userName = userInformation!.valueForKey("login") as? String
        self.userImageString = userInformation!.valueForKey("avatar_url") as? String
    }
    
    init(profileInfo: NSDictionary) {
        self.userName = profileInfo.valueForKey("login") as? String
        self.userImageString = profileInfo.valueForKey("avatar_url") as? String
        self.userBio = profileInfo.valueForKey("bio") as? String
        self.hireable = profileInfo.valueForKey("hireable") as? Bool
    }
    
    class func parseJOSNDataIntoSingleUser(rawJSONData: NSData) -> User? {
        var error: NSError?
        if let JSONDictionary = NSJSONSerialization.JSONObjectWithData(rawJSONData, options: nil, error: &error) as? NSDictionary {
            
            var newuser: User?
            var newUser = User(profileInfo: JSONDictionary)
            return newUser
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
                    }
                }
            }
            return users
        } else {
            return nil
        }
    }
}