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

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var chooseImage: UIButton!
    
    var NAME:String = ""
    var PASS:String=""
    var ADDR:String=""
    var USERNAME:String=""
    var EMAIL:String=""
    var PHONE:String=""
    var UID:String = ""
    var SEX:String = ""
    var Scanner:ScanPi = ScanPi()    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var addr: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var sex: UITextField!
 

    @IBAction func chooseImage(_ sender: UIButton) {
        
    }
    
    @IBAction func registerRFID(_ sender: Any) {
        UID = Scanner.getUID()
        continueButton.setTitle("Succesfully Register RFID tag", for: .normal)
        }
    
    @IBAction func `continue`(_ sender: UIButton)
    {
        NAME = name.text!
        PASS = pass.text!
        ADDR = addr.text!
        USERNAME = username.text!
        EMAIL = email.text!
        PHONE = phone.text!
        SEX = sex.text!
        print("Sending Data")
        var request = URLRequest(url: NSURL(string: "http://sdphospitalsystem.uconn.edu/register_patient.php")! as URL)
        request.httpMethod = "POST"
        print("UID= \(UID)")
        print("NAME= \(NAME)")
        print("PASS= \(PASS)")
        print("ADDR= \(ADDR)")
        print("USERNAME= \(USERNAME)")
        print("EMAIL= \(EMAIL)")
        print("PHONE= \(PHONE)")
        print("SEX= \(SEX)")
        let postString = "rfid=\(UID)&name=\(NAME)&pass=\(PASS)&add=\(ADDR)&uname=\(USERNAME)&email=\(EMAIL)&phone=\(PHONE)&sex=\(SEX)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            print("response = \(response)")
            
        }
        task.resume()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
