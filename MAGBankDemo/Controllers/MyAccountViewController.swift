//
//  MyAccountViewController.swift
//  MAGBankDemo
//
//  Created by Matthew Keller on 9/19/18.
//  Copyright © 2018 Matthew Keller. All rights reserved.
//

import UIKit
import MASFoundation
import SVProgressHUD
import SwiftyJSON


class MyAccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print ("My Account view controller did load")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        print ("Logout button pressed")

    }
    

}
