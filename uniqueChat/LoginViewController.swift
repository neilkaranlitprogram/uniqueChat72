//
//  LoginViewController.swift
//  uniqueChat
//
//  Created by Neilkaran Rawal on 7/10/16.
//  Copyright © 2016 Neilkaran. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let backendless = Backendless.sharedInstance()
    
    var email: String?
    var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: IBActions 
    
    @IBAction func loginBarButtonItemPressed(sender: UIBarButtonItem) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            self.email = emailTextField.text
            self.password = passwordTextField.text
            
            //login user 
            loginUser(email!, password: password!)
            
            
        } else {
            //show an error to user
        }
        
    }
    
    func loginUser(email: String, password: String) {
        
        backendless.userService.login(email, password: password, response: { (user: BackendlessUser!) -> Void in
            
            self.emailTextField.text = "" // clears textbox
            self.passwordTextField.text = ""
            
            //segue to recents view
            //here segue to recent vc
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ChatVC") as! UITabBarController
            
            vc.selectedIndex = 0 // make recents default page when logged in 
            
            self.presentViewController(vc, animated: true, completion: nil)

            
            }) {  (fault: Fault!) -> Void in
                print("Failed to Login User \(fault)")
        
        }

    }
}
