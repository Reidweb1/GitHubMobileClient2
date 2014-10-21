//
//  NetworkController.swift
//  GitHub2Go
//
//  Created by Reid Weber on 10/20/14.
//  Copyright (c) 2014 Reid Weber. All rights reserved.
//

import Foundation
import UIKit

class NetworkController {
    
    let clientID = "client_id=43f2b80066d677ac25ae"
    let clientSecretCode = "client_secret=cf98ac06ce4813026b0961a198b97255eb580f5f"
    let githubOAuthURL = "https://github.com/login/oauth/authorize?"
    let githubScope = "scope=user,repo"
    let redirectURL = "redirect_uri=placeholdername://test"
    let githubPostURL = "https://github.com/login/oauth/access_token"
    
    func requestOAuthAccess() {
        let url = githubOAuthURL + clientID + "&" + redirectURL + "&" + githubScope
        UIApplication.sharedApplication().openURL(NSURL(string: url))
        
    }
    
    func handleOAUTHURL(callbackURL: NSURL) {
        let query = callbackURL.query
        let componants = query?.componentsSeparatedByString("code=")
        let code = componants?.last
        
        let urlQuery = clientID + "&" + clientSecretCode + "&" + "code=\(code!)"
        
        var request = NSMutableURLRequest(URL: NSURL(string: githubPostURL))
        request.HTTPMethod = "POST"
        
        var postData = urlQuery.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
        let length = postData!.length
        request.setValue("\(length)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = postData
        
        var dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                println("ERROR")
            } else {
                if let httpResponse = response as? NSHTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200...204:
                        println("Success")
                        var tokenResponse = NSString(data: data, encoding: NSASCIIStringEncoding)
                        
                        var configuration = NSURLSessionConfiguration()
                        configuration.setValue("", forKey: "Authorization:")
                        var mySession = NSURLSession(configuration: configuration)
                    default:
                        println("ERROR")
                    }
                }
            }
        }).resume()
    }
    
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