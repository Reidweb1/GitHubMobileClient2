//
//  RepoViewController.swift
//  GitHub2Go
//
//  Created by Reid Weber on 10/20/14.
//  Copyright (c) 2014 Reid Weber. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var repos: [Repo]?
    var networkController: NetworkController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("REPO_CELL") as RepoTableViewCell
        let repo = self.repos![indexPath.row] as Repo
        cell.repoNameLabel.text = repo.repoName
        cell.stargazersLabel.text = "Stargazers: " + String(repo.starCount!)
        cell.watchersLabel.text = "Watchers: " + String(repo.followersCount!)
        cell.forksLabel.text = "Forks: " + String(repo.forkCount!)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.repos == nil {
            return 0
        } else {
            return self.repos!.count
        }
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        let repo = self.repos![indexPath.row]
        let newDetailViewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier("REPO_WEB_VIEW") as WebViewController
        newDetailViewcontroller.repo = repo
        self.navigationController?.pushViewController(newDetailViewcontroller, animated: true)
        
    }
    
    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        println(text)
        return true
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if self.searchBar.text != nil {
            var searchText = self.searchBar.text
            println(searchText)
            self.networkController?.repoFetchRequest(searchText, completionHandler: { (errorDescription, repos) -> Void in
                if errorDescription == nil {
                    self.repos = repos
                    println("Success")
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        self.tableView.reloadData()
                    })
                } else {
                    println("Error on Tableview Load")
                }
            })
            self.searchBar.resignFirstResponder()
        }
    }

}
