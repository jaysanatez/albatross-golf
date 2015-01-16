//
//  MenuViewController.swift
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/15/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet var tableView:UITableView!
    var menuOptions:NSArray

    required init(coder aDecoder: NSCoder)
    {
        menuOptions = ["New Round","Past Rounds","Multi-Round Statistics","Comparative Statistics","About Albatross Golf"]
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Menu"
        
        tableView.rowHeight = UIScreen.mainScreen().bounds.size.height == 568 ? 70 : 55
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        if tableView.indexPathForSelectedRow() != nil
        {
            tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow()!, animated:true)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return menuOptions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cellIdentifier:String
        
        switch indexPath.row
        {
        case 0:
            cellIdentifier = "goToChooseCourse"
            break
        case 1:
            cellIdentifier = "goToPastRounds"
            break
        case 2:
            cellIdentifier = "goToMultiStats"
            break
        case 3:
            cellIdentifier = "goToCompStats"
            break
        default:
            cellIdentifier = "goToAbout"
            break
        }
        
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath:indexPath) as UITableViewCell
        
        cell.textLabel?.text = menuOptions.objectAtIndex(indexPath.row) as? String
        cell.textLabel?.font = UIFont(name:"Apple SD Gothic Neo", size:18)
        
        return cell
    }
    
    @IBAction func logout()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
