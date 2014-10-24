//
//  Repo.swift
//  GitHub2Go
//
//  Created by Reid Weber on 10/20/14.
//  Copyright (c) 2014 Reid Weber. All rights reserved.
//

import Foundation

class Repo {
    var repoInformation: NSDictionary?
    var repoName: String?
    var starCount: Int?
    var followersCount: Int?
    var forkCount: Int?
    var repoURL: String?
    var repoUser: String?
    
    init(repoInfo: NSDictionary) {
        self.repoInformation = repoInfo
        self.repoName = self.repoInformation!.valueForKey("name") as? String
        self.starCount = self.repoInformation!.valueForKey("stargazers_count") as? Int
        self.followersCount = self.repoInformation!.valueForKey("watchers_count") as? Int
        self.forkCount = self.repoInformation!.valueForKey("forks_count") as? Int
        self.repoURL = self.repoInformation!.valueForKey("url") as? String
        let ownerDict = self.repoInformation!.valueForKey("owner") as? NSDictionary
        self.repoUser = ownerDict?.valueForKey("login") as? String
    }
    
    class func parseJOSNDataIntoRepos(rawJSONData: NSData ) -> [Repo]? {
        
        var error: NSError?
        if let JSONDictionary = NSJSONSerialization.JSONObjectWithData(rawJSONData, options: nil, error: &error) as? NSDictionary {
            
            var repos = [Repo]()
            
            if let searchitemsArray: NSArray = JSONDictionary["items"] as? NSArray {
                for JSONDict in searchitemsArray {
                    if let repoDictionary: NSDictionary = JSONDict as? NSDictionary {
                        var newRepo = Repo(repoInfo: repoDictionary)
                        repos.append(newRepo)
                    }
                }
            }
            return repos
        } else {
            return nil
        }
    }
}