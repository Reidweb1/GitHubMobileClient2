//
//  NetworkController.swift
//  GitHub2Go
//
//  Created by Reid Weber on 10/20/14.
//  Copyright (c) 2014 Reid Weber. All rights reserved.
//

import Foundation

class NetworkController {
    
    func repoFetchRequest (completionHandler: (errorDescription: String?, repos: [Repo]) -> Void) {
        let url = NSURL(string: "http://127.0.0.1:3000")
        
        let repoTask = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                println(httpResponse.statusCode)
                switch httpResponse.statusCode {
                case 200...204:
                    println("SUCCESS")
                    let repos = Repo.parseJOSNDataIntoRepos(data)
                    completionHandler(errorDescription: nil, repos: repos!)
                default:
                    println("ERROR")
                }
            }
        })
        repoTask.resume()
    }
}