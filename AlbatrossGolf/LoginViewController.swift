//
//  LoginViewController.swift
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 1/15/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.

import UIKit

class LoginViewController: UIViewController
{
    @IBOutlet var user_name:UITextField!
    @IBOutlet var password:UITextField!
    @IBOutlet var login_button:UIButton!
    
    var dao:UserDAO
    
    required init(coder aDecoder: NSCoder)
    {
        dao = UserDAO()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        var field_array:NSArray = [user_name, password]
        for f in field_array
        {
            f.layer.borderColor = UIColor.blackColor().CGColor
            f.layer.cornerRadius = 8
            f.layer.borderWidth = 1.5
            f.layer.masksToBounds = true
            
            var field:UITextField = f as UITextField
            field.leftViewMode = UITextFieldViewMode.Always
            field.leftView = UIView(frame:CGRectMake(0,0,7,40))
        }
        
        login_button.layer.cornerRadius = 8
        login_button.layer.masksToBounds = true
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
        }
        
        return success
    }
    
    @IBAction func forgotPasswordTapped()
    {
        print("You're bad, kid");
    }
    
    @IBAction func createAccountTapped()
    {
        var controller:CreateAccountViewController = CreateAccountViewController(nibName: "CreateAccountViewController", bundle: NSBundle.mainBundle())
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
