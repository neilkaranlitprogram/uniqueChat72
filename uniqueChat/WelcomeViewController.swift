//
//  WelcomeViewController.swift
//  uniqueChat
//
//  Created by Neilkaran Rawal on 7/10/16.
//  Copyright © 2016 Neilkaran. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let backendless = Backendless.sharedInstance()
    var currentUser: BackendlessUser?
    
    override func viewDidAppear(animated: Bool) {
        backendless .userService.setStayLoggedIn(true)
        
        currentUser = backendless.userService.currentUser // user that is currently logged in 
        
        if currentUser != nil { // already logged in 
            /*
            dispatch_async(dispatch_get_main_queue()) { // making sure your on main queue due to change in user interface 
            
            //here segue to recent vc
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ChatVC") as! UITabBarController
            
            vc.selectedIndex = 0 // make recents default page when logged in
            
            self.presentViewController(vc, animated: true, completion: nil)
            }*/
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
