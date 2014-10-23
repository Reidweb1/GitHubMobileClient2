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
    var user: User?
    var reverseOrigin: CGRect?
    var newImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.image = self.newImage
        self.userNameLabel.text = self.user?.userName
        
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
