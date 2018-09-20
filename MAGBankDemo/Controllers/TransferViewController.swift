//
//  TransferViewController.swift
//  MAGBankDemo
//
//  Created by Matthew Keller on 9/19/18.
//  Copyright © 2018 Matthew Keller. All rights reserved.
//

import UIKit
import MASFoundation
import SVProgressHUD
import SwiftyJSON

class TransferViewController: UIViewController {
    @IBOutlet weak var transferMessage: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print ("Transfer view controller did load")
        MAS.getFrom("/transfer", withParameters: nil, andHeaders: nil, completion: { (response, error) in
            
            if (error == nil) {
                
                //We have data!
                SVProgressHUD.dismiss()
                print("Response: \(response!["MASResponseInfoBodyInfoKey"]!) ")
                
                //Parse JSON
                print("Try to parse JSON...")
                let resultJSON : JSON = JSON(response!["MASResponseInfoBodyInfoKey"]!)
                let message = resultJSON["message"].stringValue
                
                /////// TODO Create and update label
                ///////self.messageLabel.text = message
                
                //self.resultTextView.text = response?.debugDescription
                
            } else {
                print ("Error \(error!)")
            }
        })
        
    }

    @IBAction func transferButton(_ sender: Any) {
        print ("tranferButton pressed")
        print ("Sent to: \(usernameField.text)")
    }
    
    

}
