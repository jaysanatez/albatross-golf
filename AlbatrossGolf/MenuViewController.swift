//
//  MenuViewController.swift
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/15/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

import UIKit

class MenuViewController: UIViewController
{
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
    }
    
    @IBAction func playRoundTapped()
    {
    
    }
    
    @IBAction func pastRoundsTapped()
    {
        var controller:PastRoundsVC = PastRoundsVC(nibName: "PastRoundsVC", bundle: NSBundle.mainBundle())
        navigationController?.pushViewController(controller, animated:true)
    }
    
    @IBAction func multiRoundStatsTapped()
    {
    
    }
    
    @IBAction func comparativeStatsTapped()
    {
        
    }
    
    @IBAction func logoutTapped()
    {
        var error:NSError?
        var delegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        var user:User = delegate.getActiveUser()
        var ctx:NSManagedObjectContext = delegate.managedObjectContext
        
        ctx.deleteObject(user.cdObject)
        ctx.save(&error)
        
        delegate.removeActiveUser()
        
        self.navigationController?.popViewControllerAnimated(true)
    }
}
