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
        return 25
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("USER_CELL", forIndexPath: indexPath) as UserCollectionViewCell
        cell.backgroundColor = UIColor.redColor()
        return cell
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        println(self.searchBar.text)
//        if self.searchBar.text != nil {
//            var searchText = self.searchBar.text
//            println(searchText)
//            self.networkController?.repoFetchRequest(searchText, completionHandler: { (errorDescription, repos) -> Void in
//                if errorDescription == nil {
//                    self.users = user
//                    println("Success")
//                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//                        self.tableView.reloadData()
//                    })
//                } else {
//                    println("Error on Tableview Load")
//                }
//            })
//            self.searchBar.resignFirstResponder()
//        }
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
