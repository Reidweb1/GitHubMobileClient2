//
//  ProfileDetailViewController.swift
//  GitHub2Go
//
//  Created by Reid Weber on 10/24/14.
//  Copyright (c) 2014 Reid Weber. All rights reserved.
//

import UIKit

class ProfileDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var profileLabel: UILabel!
    var networkController: NetworkController?
    var authUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController
        self.networkController?.fetchAuthenticatedUser({ (errorDescription, user) -> Void in
            if errorDescription == nil {
                self.authUser = user
                self.profileLabel.text = self.authUser!.userName
                
                self.networkController?.stringToImage(self.authUser!.userImageString!, completionHandler: { (image) -> Void in
                    self.imageView.image = image
                })
            }
        })
        

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
