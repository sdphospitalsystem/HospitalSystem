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
        var userExists:String = ""
        USERNAME = username.text!
        PASSWORD = password.text!
        let _URL = URL(string: "http://sdphospitalsystem.uconn.edu/iosLogin.php")
        var request = URLRequest(url: _URL!)
        request.httpMethod="POST"
        let postString = "type=Patient&uname=\(USERNAME)&password=\(PASSWORD)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            
            userExists = String(data: data!, encoding: .utf8)!
            if(userExists == "LOGGED IN")
            {
                //User Exists
                self.performSegue(withIdentifier: "LogInSegue", sender: self)
            }else
            {
                //User does not exist
                let alert = UIAlertController(title: "Error", message: "Not a valid username/password combo", preferredStyle: .alert)
                let OK = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                    print("OK")
                })
                alert.addAction(OK)
                self.present(alert, animated: true, completion:nil)
            }

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
