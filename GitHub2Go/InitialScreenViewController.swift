//
//  InitialScreenViewController.swift
//  GitHub2Go
//
//  Created by Reid Weber on 10/20/14.
//  Copyright (c) 2014 Reid Weber. All rights reserved.
//

import UIKit

class InitialScreenViewController: UIViewController {

    var firstLoad: Bool = true
    var networkController: NetworkController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController

        let key = "Token"
        if let value = NSUserDefaults.standardUserDefaults().valueForKey(key) as? String {
            self.networkController!.accessToken = value
            var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            configuration.HTTPAdditionalHeaders = ["Authorization" : "token \(self.networkController!.accessToken)"]
            var mySession = NSURLSession(configuration: configuration)
            self.networkController!.URLSession = mySession
        } else {
            self.networkController?.requestOAuthAccess()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
