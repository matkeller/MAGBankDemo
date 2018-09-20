//
//  ProfileViewController.swift
//  MAGBankDemo
//
//  Created by Matthew Keller on 9/19/18.
//  Copyright © 2018 Matthew Keller. All rights reserved.
//

import UIKit
import MASFoundation
import SVProgressHUD
import SwiftyJSON

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       print ("Profile view controller did load")
        
        MAS.getFrom("/maglogin", withParameters: nil, andHeaders: nil, completion: { (response, error) in
            
            if (error == nil) {
                
                //We have data!
                SVProgressHUD.dismiss()
                
                var profile = "User profile: \n"
                profile += "Username: "
                profile += (MASUser.current()?.userName)!
                profile += "\nEmail: "
                profile += (MASUser.current()?.emailAddresses!["work"])!
                profile += "\nPhone: "
                profile += (MASUser.current()?.phoneNumbers!["work"])!
                
                print (MASUser.current().debugDescription)
                self.profileLabel.text = profile
                
            } else {
                print ("Error with login: \(error!)")
            }
        })
    }


}
