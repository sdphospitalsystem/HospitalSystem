//
//  NewUser.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 4/12/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import Foundation
import UIKit


class NewUser: UIViewController, UITextFieldDelegate
{

    var NAME:String = ""
    var PASS:String=""
    var ADDR:String=""
    var DATE:Date?=nil
    var USERNAME:String=""
    var EMAIL:String=""
    var PHONE:String=""
    var Scanner:ScanPi = ScanPi()
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var addr: UITextField!
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    
    
    
    
    @IBAction func enterName(_ sender: Any) {
        let NAME = name.text!
    }
    @IBAction func enterPass(_ sender: Any) {
        let PASS = pass.text!
    }
    @IBAction func enterAddress(_ sender: Any) {
        let ADDR = addr.text!
    }
    @IBAction func enterDate(_ sender: Any) {
        let DATE = date.date
    }
    @IBAction func enterUserName(_ sender: Any) {
        let USERNAME = username.text!
    }
    @IBAction func enterEmail(_ sender: Any) {
        var EMAIL = email.text!
    }
    @IBAction func enterPhone(_ sender: Any) {
        var PHONE = phone.text!
    }
    
    
    @IBAction func registerRFID(_ sender: Any) {
        var UID = Scanner.getUID()
        print(UID)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
