//
//  RepoViewController.swift
//  GitHub2Go
//
//  Created by Reid Weber on 10/20/14.
//  Copyright (c) 2014 Reid Weber. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var repos: [Repo]?
    var networkController: NetworkController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.networkController?.repoFetchRequest({ (errorDescription, repos) -> Void in
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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("REPO_CELL") as RepoTableViewCell
        let repo = self.repos![indexPath.row] as Repo
        cell.repoNameLabel.text = repo.repoName
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.repos == nil {
            return 0
        } else {
            return self.repos!.count
        }
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
