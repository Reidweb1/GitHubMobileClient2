//
//  UserViewController.swift
//  GitHub2Go
//
//  Created by Reid Weber on 10/22/14.
//  Copyright (c) 2014 Reid Weber. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var origin: CGRect?
    var users: [User]?
    var networkController: NetworkController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.searchBar.delegate = self
        
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController

        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(animated: Bool) {
        //self.navigationController?.delegate = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.users?.count == nil {
            return 0
        } else {
            return self.users!.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("USER_CELL", forIndexPath: indexPath) as UserCollectionViewCell
        cell.userNameLabel.text = self.users![indexPath.row].userName
        if self.users![indexPath.row].userImage == nil {
            self.networkController?.stringToImage(self.users![indexPath.row].userImageString!, completionHandler: { (image) -> Void in
                cell.imageView.image = image
                self.users![indexPath.row].userImage = image
            })
        } else {
            cell.imageView.image = self.users![indexPath.row].userImage
        }
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let user = self.users![indexPath.row]
        
        // Grab the attributes of the tapped upon cell
        let attributes = collectionView.layoutAttributesForItemAtIndexPath(indexPath)
        
        // Grab the onscreen rectangle of the tapped upon cell, relative to the collection view
        let origin = self.view.convertRect(attributes!.frame, fromView: collectionView)
        
        // Save our starting location as the tapped upon cells frame
        self.origin = origin
        
        var newImage: UIImage?
        
        // Find tapped image, initialize next view controller
        if self.users![indexPath.row].userImage == nil {
            self.networkController?.stringToImage(self.users![indexPath.row].userImageString!, completionHandler: { (image) -> Void in
                newImage! = image
            })
        } else {
            newImage = self.users![indexPath.row].userImage
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newDetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("USER_DETAIL_VIEW") as UserDetailViewController
        newDetailViewController.user = user
        newDetailViewController.newImage = newImage
        // Set image and reverseOrigin properties on next view controller
        
        newDetailViewController.reverseOrigin = self.origin!
        
        // Trigger a normal push animations; let navigation controller take over.
       // self.navigationController?.showDetailViewController(newDetailViewController, sender: self)
        self.navigationController?.pushViewController(newDetailViewController, animated: true)
    }
    
    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text.validate() {
            return true
        } else {
            return false
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if self.searchBar.text != nil {
            var searchText = self.searchBar.text!
            self.networkController?.userFetchRequest(searchText, completionHandler: { (errorDescription, users) -> Void in
                if errorDescription == nil {
                    self.users = users
                    println("Got Users from Network Controller")
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        self.collectionView.reloadData()
                    })
                } else {
                    println("Error on Collection View Load")
                }
            })
            self.searchBar.resignFirstResponder()
            
        }
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let mainViewController = fromVC as? UserViewController {
            var animator = ShowImageAnimator()
            animator.origin = mainViewController.origin
            return animator
        } else if let mainViewContorller = fromVC as? UserDetailViewController {
            var animator = FromImageAnimator()
            animator.origin = mainViewContorller.reverseOrigin
            return nil
        } else {
            return nil
        }
    }
}
