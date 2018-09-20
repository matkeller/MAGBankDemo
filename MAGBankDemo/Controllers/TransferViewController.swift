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
    
    var username = ""
    var amount = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    
    
    @IBAction func transferButton(_ sender: Any) {
        print ("tranferButton pressed")
        
        //TODO  Ensure not empty or nil
        username = usernameField.text!
        amount = amountField.text!
        let headers = ["username":username, "amount":amount]
        print ("Attempting to transfer $\(amount) to \(username)")
        
        //Make call to transfer with username and amount as headers
        SVProgressHUD.show(withStatus: "Performing Transfer")
        MAS.getFrom("/otpProtect", withParameters: nil, andHeaders: headers, completion: { (response, error) in
            
            if (error == nil) {
                
                //We have data!
                SVProgressHUD.dismiss()
                print("Response: \(response!["MASResponseInfoBodyInfoKey"]!) ")
                
                //Parse JSON
//                print("Try to parse JSON...")
//                let resultJSON : JSON = JSON(response!["MASResponseInfoBodyInfoKey"]!)
//                let message = resultJSON["message"].stringValue
//
                let alertController = UIAlertController(title: "Success!", message: "$\(self.amount)  transferred to \(self.username)", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                self.usernameField.text = ""
                self.amountField.text = ""
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                print ("Error \(error!)")
                SVProgressHUD.dismiss()
                let alertController = UIAlertController(title: "Error", message: "Transfer could not be sent, please try again later.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }
    
    

}
