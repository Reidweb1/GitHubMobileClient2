//
//  UserDetailViewController.swift
//  GitHub2Go
//
//  Created by Reid Weber on 10/23/14.
//  Copyright (c) 2014 Reid Weber. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var viewReposButton: UIButton!
    
    var user: User?
    var reverseOrigin: CGRect?
    var newImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = self.newImage
        self.userNameLabel.text = self.user?.userName
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        self.viewReposButton.hidden = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.viewReposButton.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func viewReposButtonClicked(sender: AnyObject) {
        let newDetailViewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("REPO_WEB_VIEW") as WebViewController
        newDetailViewcontroller.user = self.user
        self.navigationController?.pushViewController(newDetailViewcontroller, animated: true)
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
