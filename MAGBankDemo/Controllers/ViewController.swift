//
//  ViewController.swift
//  MAGBankDemo
//
//  Created by Matthew Keller on 9/19/18.
//  Copyright © 2018 Matthew Keller. All rights reserved.
//

import UIKit
import MASFoundation
import SVProgressHUD
import SwiftyJSON


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Logout any old session if it exists
        if (MASUser.current() != nil) {
            if (MASUser.current()!.isAuthenticated) {
                MASUser.current()?.logout(false, completion: { (completed, error) in
                    
                    if (error != nil) {
                        print("Error trying to logout the user")
                        //Present an Alert showing the results
                        let alertController = UIAlertController(title: "Error", message: "The user could not be logged out", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(defaultAction)
                        
                    } else {
                        print("User logout was successful")
                        //Present an Alert showing the results
                        let alertController = UIAlertController(title: "User Logout", message: "The user has been logged out!", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
            
                    }
                })
            } else {
                print ("Trying to logout but user was not authenticated")
            }
        }
        
        //Start MAS
        MAS.setGrantFlow(MASGrantFlow.password)
        MAS.start(withDefaultConfiguration: true) { (completed, error) in
            print ("...Starting MAS!")
            if (completed == true) {
                print ("MAS start completed!")
            } else {
                print ("MAS   NOT   STARTED.  Errors: ")
                print (error!)
            }
        }
    }

    
    
    @IBAction func myAccountButton(_ sender: Any) {
        
        print ("My Account button pressed")
        
        SVProgressHUD.show(withStatus: "Performing Login")
        MAS.getFrom("/maglogin", withParameters: nil, andHeaders: nil, completion: { (response, error) in
            
            if (error == nil) {
                
                //We have data!
                SVProgressHUD.dismiss()
                print("Products response: \(response!["MASResponseInfoBodyInfoKey"]!) ")
                
                //Parse JSON
                print("Try to parse JSON...")
                let resultJSON : JSON = JSON(response!["MASResponseInfoBodyInfoKey"]!)
                let message = resultJSON["message"].stringValue
                let data = ("Message: \(message)")
                print (data)
                
                //We are logged in, segue to My Account
                self.performSegue(withIdentifier: "showMyAccount", sender: self)
            } else {
                print ("Error with login: \(error!)")
            }
        })
    }

    
    
}

