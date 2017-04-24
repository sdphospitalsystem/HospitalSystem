//
//  SettingsViewController.swift
//  HospitalSystem
//
//  Created by Andrew T on 4/23/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var OLDUSERNAME:String = ""
    var NEWUSERNAME:String = ""
    
    var USERNAME:String = ""
    var OLDPASSWORD:String = ""
    var NEWPASSWORD:String = ""
    var NEWPASSWORD2:String = ""
    
    @IBOutlet weak var oldusername: UITextField!
    @IBOutlet weak var newusername: UITextField!
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var oldpassword: UITextField!
    @IBOutlet weak var newpassword: UITextField!
    @IBOutlet weak var newpassword2: UITextField!
    
    @IBAction func changeUsername(_ sender: Any) {
        var success:String = ""
        self.OLDUSERNAME = oldusername.text!
        self.NEWUSERNAME = newusername.text!
        let _URL = URL(string: "http://sdphospitalsystem.uconn.edu/change_username.php")
        var request = URLRequest(url: _URL!)
        request.httpMethod="POST"
        let postString = "oldUser=\(OLDUSERNAME)&newUser=\(NEWUSERNAME)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            success = String(data: data!, encoding: .utf8)!
            print(success)
            if(success == "<p style=\"color:green;\">Username successfully changed.</p>")
            {
                //Username successfully changed
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Username change", message: "Successfully changed username.", preferredStyle: .alert)
                    let OK = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                        print("OK")
                    })
                    alert.addAction(OK)
                    self.present(alert, animated: true, completion:nil)
                }
            }else
            {
                //Username already taken
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: "The username you entered is already taken.", preferredStyle: .alert)
                    let OK = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                        print("OK")
                    })
                    alert.addAction(OK)
                    self.present(alert, animated: true, completion:nil)
                }
            }
        }
        task.resume()
    }
    
    
    @IBAction func changePassword(_ sender: Any) {
        var success:String = ""
        self.USERNAME = username.text!
        self.OLDPASSWORD = oldpassword.text!
        self.NEWPASSWORD = newpassword.text!
        self.NEWPASSWORD2 = newpassword2.text!
        if self.NEWPASSWORD2 != self.NEWPASSWORD {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error", message: "The new passwords do not match. Make sure all fields are entered correctly.", preferredStyle: .alert)
                let OK = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                    print("OK")
                })
                alert.addAction(OK)
                self.present(alert, animated: true, completion:nil)
            }
        }
        let _URL = URL(string: "http://sdphospitalsystem.uconn.edu/change_password.php")
        var request = URLRequest(url: _URL!)
        request.httpMethod="POST"
        let postString = "oldPassword=\(OLDPASSWORD)&newPassword=\(NEWPASSWORD)&userName=\(USERNAME)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            success = String(data: data!, encoding: .utf8)!
            print(success)
            if(success == "<p style=\"color:green;\">Password successfully changed.<p>")
            {
                //Password successfully changed
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Password change", message: "Successfully changed password.", preferredStyle: .alert)
                    let OK = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                        print("OK")
                    })
                    alert.addAction(OK)
                    self.present(alert, animated: true, completion:nil)
                }
            }else
            {
                //Password change unsuccessful
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: "Unsuccessfully changed password. Make sure all fields are entered correctly.", preferredStyle: .alert)
                    let OK = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                        print("OK")
                    })
                    alert.addAction(OK)
                    self.present(alert, animated: true, completion:nil)
                }
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
