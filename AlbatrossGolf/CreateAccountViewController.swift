//
//  CreateAccountViewController.swift
//  AlbatrossGolf
//
//  Created by Jacob Sanchez on 3/20/15.
//  Copyright (c) 2015 jacobSanchez. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet var firstNameField:UITextField!
    @IBOutlet var lastNameField:UITextField!
    @IBOutlet var userNameField:UITextField!
    @IBOutlet var emailField:UITextField!
    @IBOutlet var passwordField:UITextField!
    @IBOutlet var confirmPasswordField:UITextField!
    
    @IBOutlet var createAccountButton:UIButton!
    
    @IBOutlet var errorLabel:UILabel!
    @IBOutlet var errorLabelTopSpace:NSLayoutConstraint!
    @IBOutlet var errorLabelHeight:NSLayoutConstraint!
    
    var textfields:NSArray?
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = "Create Account"
        self.collapseErrorLabel(false)
        
        textfields = [userNameField, firstNameField, lastNameField, emailField, passwordField, confirmPasswordField]
        
        for f in textfields!
        {
            f.layer.borderColor = UIColor.blackColor().CGColor
            f.layer.borderWidth = 1.5
            
            var field:UITextField = f as UITextField
            field.leftViewMode = UITextFieldViewMode.Always
            field.leftView = UIView(frame:CGRectMake(0,0,7,40))
        }
    }
    
    func collapseErrorLabel(animated: Bool)
    {
        errorLabelTopSpace.constant = 0
        errorLabelHeight.constant = 0
        UIView.animateWithDuration(animated ? 0.5 : 0, animations: { self.view.layoutIfNeeded() })
    }
    
    func displayErrorLabelWithText(text:String)
    {
        errorLabel.text = text
        errorLabelTopSpace.constant = 15
        errorLabelHeight.constant = 20
        UIView.animateWithDuration(0.5, animations: { self.view.layoutIfNeeded() })
    }
    
    @IBAction func createAccountTapped()
    {
        var anyEmpty:Bool = false
        for f in textfields!
        {
            var field:UITextField = f as UITextField
            if countElements(field.text) < 1
            {
                anyEmpty = true
            }
        }
        
        if anyEmpty
        {
            self.displayErrorLabelWithText("You must complete all fields")
        }
        else if passwordField.text != confirmPasswordField.text
        {
            self.displayErrorLabelWithText("Password fields do not match")
        }
        else if self.usernameExists()
        {
            self.displayErrorLabelWithText("An account exists with that username")
        }
        else if self.emailIsRegistered()
        {
            self.displayErrorLabelWithText("An account exists with that email")
        }
        else
        {
            self.collapseErrorLabel(true)
            var newUser:User = User()
            
            newUser.firstName = firstNameField.text
            newUser.lastName = lastNameField.text
            newUser.userName = userNameField.text;
            newUser.email = emailField.text
            newUser.password = passwordField.text
            
            var dao:UserDAO = UserDAO()
            newUser = dao.createUser(newUser)
            
            // login with new user
            dao.storeUserAsActiveUser(newUser)
            var storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            var controller : MenuViewController = storyboard.instantiateViewControllerWithIdentifier("MenuViewController") as MenuViewController
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
    }
    
    func usernameExists() -> Bool
    {
        return false
    }
    
    func emailIsRegistered() -> Bool
    {
        return false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}
