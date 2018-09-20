//
//  BalanceViewController.swift
//  MAGBankDemo
//
//  Created by Matthew Keller on 9/19/18.
//  Copyright © 2018 Matthew Keller. All rights reserved.
//

import UIKit
import MASFoundation
import SVProgressHUD
import SwiftyJSON

class BalanceViewController: UIViewController {

    @IBOutlet weak var balanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print ("Balance view controller did load")
        
        SVProgressHUD.show(withStatus: "Retrieving Balance")
        MAS.getFrom("/balance", withParameters: nil, andHeaders: nil, completion: { (response, error) in
            
            if (error == nil) {
                
                //We have data!
                SVProgressHUD.dismiss()
                print("Response: \(response!["MASResponseInfoBodyInfoKey"]!) ")
                
                //Parse JSON
                print("Try to parse JSON...")
                let resultJSON : JSON = JSON(response!["MASResponseInfoBodyInfoKey"]!)
                let balance = resultJSON["balance"].stringValue
                
                let data = ("$\(balance)")
                print (data)
                self.balanceLabel.text = data
                
                //self.resultTextView.text = response?.debugDescription
                
            } else {
                print ("Error \(error!)")
            }
        })
        
    }

}
