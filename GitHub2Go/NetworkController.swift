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
    var accessToken = ""
    let imageQueue = NSOperationQueue()
    
    var URLSession: NSURLSession = NSURLSession()
    
    func requestOAuthAccess() {
        let url = githubOAuthURL + clientID + "&" + redirectURL + "&" + githubScope
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        
    }
    
    func stringToImage(urlString: String, completionHandler: (image: UIImage) -> Void) {
        var url = NSURL(string: urlString)
        var photoData = NSData(contentsOfURL: url!)
        var userPhoto = UIImage(data: photoData!)
        completionHandler(image: userPhoto!)
    }
    
    func handleOAUTHURL(callbackURL: NSURL) {
        let query = callbackURL.query
        let componants = query?.componentsSeparatedByString("code=")
        let code = componants?.last
        
        let urlQuery = clientID + "&" + clientSecretCode + "&" + "code=\(code!)"
        
        var request = NSMutableURLRequest(URL: NSURL(string: githubPostURL)!)
        request.HTTPMethod = "POST"
        
        var postData = urlQuery.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
        let length = postData!.length
        request.setValue("\(length)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = postData
        
        var dataTask: Void = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                println("ERROR")
            } else {
                if let httpResponse = response as? NSHTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200...204:
                        println("Success")
                        var tokenResponse = NSString(data: data, encoding: NSASCIIStringEncoding)
                        println(tokenResponse)
                        
                        let componants = tokenResponse!.componentsSeparatedByString("&")
                        for componant in componants {
                            let items = componant.componentsSeparatedByString("=")
                            var isToken = false
                            for item in items {
                                if isToken == true {
                                    self.accessToken = item as String
                                    NSUserDefaults.standardUserDefaults().setObject(item, forKey: "Token")
                                    NSUserDefaults.standardUserDefaults().synchronize()
                                    println("Token: \(item)")
                                }
                                if item as NSString == "access_token" {
                                    isToken = true
                                }
                            }
                        }
                        var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
                        configuration.HTTPAdditionalHeaders = ["Authoriziation" : "token \(self.accessToken)"]
                        var mySession = NSURLSession(configuration: configuration)
                        self.URLSession = mySession
                    default:
                        println("ERROR")
                    }
                }
            }
        }).resume()
    }
    
    func repoFetchRequest (searchTerm: String, completionHandler: (errorDescription: String?, repos: [Repo]) -> Void) {
        
        let url = NSURL(string: "https://api.github.com/search/repositories?q=\(searchTerm)+language:assembly&sort=stars&order=desc")
        println(url)
        let customSession = self.URLSession
        let repoTask = customSession.dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                println(httpResponse.statusCode)
                switch httpResponse.statusCode {
                case 200...204:
                    println("SUCCESS")
                    println(httpResponse)
                    if data == nil {
                        println("data returned was nil")
                    }
                    let repos = Repo.parseJOSNDataIntoRepos(data)
                    completionHandler(errorDescription: nil, repos: repos!)
                default:
                    println("ERROR")
                }
            }
        })
        repoTask.resume()
    }
    
    func userFetchRequest (searchTerm: String, completionHandler: (errorDescription: String?, users: [User]) -> Void) {
        let url = NSURL(string: "https://api.github.com/search/users?q=\(searchTerm)")
        println(url!)
        let customSession = self.URLSession
        let userTask = customSession.dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
            if let httpResponse = response as? NSHTTPURLResponse {
                println(httpResponse.statusCode)
                switch httpResponse.statusCode {
                case 200...204:
                    println("SUCCESS")
                    if data == nil {
                        println("Data was nil for users")
                    }
                    let users = User.parseJOSNDataIntoUsers(data)
                    completionHandler(errorDescription: nil, users: users!)
                default:
                    println("Error returning users")
                }
            }
        })
        userTask.resume()
    }
    
    func fetchAuthenticatedUser(completionHandler: (errorDescription: String?, user: User) -> Void) {
        let url = NSURL(string: "https://api.github.com/search/user")
        let customSession = self.URLSession
        let userTask = customSession.dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
            if let httpResponse = response as? NSHTTPURLResponse {
                switch httpResponse.statusCode {
                case 200...204:
                    println("SUCCESS")
                    let authUser = User.parseJOSNDataIntoSingleUser(data)
                    completionHandler(errorDescription: nil, user: authUser!)
                default:
                    println("Error returning user")
                }
            }
        })
    }
    
}