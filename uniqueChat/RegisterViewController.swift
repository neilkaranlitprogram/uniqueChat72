//
//  RegisterViewController.swift
//  uniqueChat
//
//  Created by Neilkaran Rawal on 7/10/16.
//  Copyright © 2016 Neilkaran. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var backendless = Backendless.sharedInstance()
    
    var newUser: BackendlessUser?
    var email: String?
    var username: String?
    var password: String?
    var avatarImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newUser = BackendlessUser() //creates new user
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //Mark: IBActions
    
    @IBAction func registerButtonPressed(sender: UIButton) {
        
        if emailTextField.text != "" && usernameTextField.text != "" && passwordTextField.text != "" { // Checks if textboxs are empty
            
            email = emailTextField.text //user infomation if textboxs aren't empty
            username = usernameTextField.text
            password = passwordTextField.text
            
            register(self.email!, username: self.username!, password: self.password!, avatarImage: self.avatarImage) // function that uses the given information
            
        } else {
            //WARNING TO USER
            //ProgressHUD.showError("All Fields Are Required!")
        }
        
    }
    
    //Mark: Backendless User Registration
    
    func register(email: String, username: String, password: String, avatarImage: UIImage?) {
        if avatarImage == nil {
            newUser!.setProperty("Avatar", object: "")
        }
        
        newUser!.email = email
        newUser!.name = username
        newUser!.password = password
        
        backendless.userService.registering(newUser, response: { (registeredUser : BackendlessUser!) -> Void in
            
        // login new user 
        self.loginUser(email, username: username, password: password)
            
        self.emailTextField.text = "" // remove text that the user typed in
        self.usernameTextField.text = ""
        self.passwordTextField.text = ""
            
        }) { (fault: Fault!) -> Void in
                print("Server reported an ERROR, could not register new user: \(fault)")
                
        }

    }
    
    func loginUser(email: String, username: String, password: String) {
        backendless.userService.login(email, password: password, response: { (user: BackendlessUser!) -> Void in // newly loged in user
            
            //here segue to recent vc
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ChatVC") as! UITabBarController
            
            vc.selectedIndex = 0 // make recents default page when logged in 
            
            self.presentViewController(vc, animated: true, completion: nil)
            
            }) { (fault: Fault!) -> Void in
                print("Server reported an ERROR: \(fault)")
        }

    }

}




