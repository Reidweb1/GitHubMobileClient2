//
//  UserViewController.swift
//  GitHub2Go
//
//  Created by Reid Weber on 10/22/14.
//  Copyright (c) 2014 Reid Weber. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var users: [User]?
    var networkController: NetworkController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.searchBar.delegate = self
        
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController

        // Do any additional setup after loading the view.
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
        self.networkController?.stringToImage(self.users![indexPath.row].userImageString!, completionHandler: { (image) -> Void in
            cell.imageView.image = image
        })
        return cell
        
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
}
