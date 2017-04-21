//
//  PatientLoginViewController.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 4/20/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import Foundation

class PatientLoginViewController: UIViewController
{
    var USERNAME:String = ""
    var PASSWORD:String = ""
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func login(_ sender: UIButton) {
        USERNAME = username.text!
        PASSWORD = password.text!
        let _URL = URL(string: "http://sdphospitalsystem.uconn.edu/iosLogin.php")
        var request = URLRequest(url: _URL!)
        request.httpMethod="POST"
        let postString = "uname=\(USERNAME)&password=\(PASSWORD)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            print("data = \(data)")
            
        }
        task.resume()

        
        
    }
    
    
    override func viewDidLoad() {
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
