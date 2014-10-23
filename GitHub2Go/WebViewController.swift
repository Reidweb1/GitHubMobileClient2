//
//  WebViewController.swift
//  GitHub2Go
//
//  Created by Reid Weber on 10/23/14.
//  Copyright (c) 2014 Reid Weber. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var webView = WKWebView()
    
    override func loadView() {
        self.view = self.webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://espn.com")!))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
