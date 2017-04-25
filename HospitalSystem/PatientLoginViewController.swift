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
        self.USERNAME = username.text!
        self.PASSWORD = password.text!
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
            print(userExists)
            if(userExists == "LOGGED IN")
            {
                //User Exists
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "LogInSegue", sender: self)
                }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LogInSegue"
        {
            if let NextView = segue.destination as? PatientPortal{
                NextView.UNAME = self.USERNAME
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
