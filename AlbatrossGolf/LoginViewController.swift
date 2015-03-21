//
//  LoginViewController.swift
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/15/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

import UIKit
import CoreData

class LoginViewController: UIViewController
{
    @IBOutlet var user_name:UITextField!
    @IBOutlet var password:UITextField!
    @IBOutlet var login_button:UIButton!
    @IBOutlet var login_message:UILabel!
    
    var dao:UserDAO
    
    required init(coder aDecoder: NSCoder)
    {
        dao = UserDAO()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        login_message.text = ""
        
        var delegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var ctx:NSManagedObjectContext = delegate.managedObjectContext!
        var request:NSFetchRequest = NSFetchRequest(entityName: "User")
        var error: NSError?
        
        let results = ctx.executeFetchRequest(request, error: &error) as [NSManagedObject]!
        
        if results.count > 0
        {
            let activeUserObject = results[0] as NSManagedObject
            var activeUser:User = User.instanceFromManagedObject(activeUserObject)
            delegate.activeUser = activeUser
            self.routeToMenu()
        }
        
        var field_array:NSArray = [user_name, password]
        for f in field_array
        {
            f.layer.borderColor = UIColor.blackColor().CGColor
            f.layer.borderWidth = 1.5
            
            var field:UITextField = f as UITextField
            field.leftViewMode = UITextFieldViewMode.Always
            field.leftView = UIView(frame:CGRectMake(0,0,7,40))
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool
    {
        var username_given:String = user_name.text
        var password_given:String = password.text
        var success:Bool = dao.attemptLoginWithUsername(username_given, andPassword:password_given)
        
        if success
        {
            dao.fetchAndStoreUserAsActiveUser(username_given)
        }
        else
        {
            // rejection animation
            login_message.text = "Invalid login credentials. Try again."
            password.text = ""
            user_name.backgroundColor = UIColor(red:1.0, green:0.5, blue:0.5, alpha:1.0)
            password.backgroundColor = UIColor(red:1.0, green:0.5, blue:0.5, alpha:1.0)
            
            UIView.animateWithDuration(0.75, animations: {
                self.user_name.backgroundColor = UIColor.whiteColor()
                self.password.backgroundColor = UIColor.whiteColor()
            })
        }
        
        return success
    }
    
    func routeToMenu()
    {
        var storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        var controller : MenuViewController = storyboard.instantiateViewControllerWithIdentifier("MenuViewController") as MenuViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func forgotPasswordTapped()
    {
        print("Forgot Password Tapped");
    }
    
    @IBAction func createAccountTapped()
    {
        var controller:CreateAccountViewController = CreateAccountViewController(nibName: "CreateAccountViewController", bundle: NSBundle.mainBundle())
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
