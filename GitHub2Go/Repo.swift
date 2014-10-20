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
    
    init(repoInfo: NSDictionary) {
        self.repoInformation = repoInfo
        self.repoName = self.repoInformation!.valueForKey("name") as? String
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
        }
        return nil
    }
}