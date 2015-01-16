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
}
