//
//  EmployeeLoginViewController.swift
//  HospitalSystem
//
//  Created by Andrew T on 4/20/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import UIKit
import LocalAuthentication

class EmployeeLoginViewController: UIViewController {
    var USERNAME:String = ""
    var PASSWORD:String = ""
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func notifyUser(_ msg: String, err: String?) {
        let alert = UIAlertController(title: msg,
                                      message: err,
                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true,
                     completion: nil)
    }
    
    @IBAction func employeeLoginButton(_ sender: UIButton)
    {
        var userExists:String = ""
        self.USERNAME = username.text!
        self.PASSWORD = password.text!
        let _URL = URL(string: "http://sdphospitalsystem.uconn.edu/iosLogin.php")
        var request = URLRequest(url: _URL!)
        request.httpMethod="POST"
        let postString = "type=Doctor&uname=\(USERNAME)&password=\(PASSWORD)"
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
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "EmployeeLoginSegue", sender: self)
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
    
    @IBAction func touchIDLogin(_ sender: Any) {
        
        let context = LAContext()
        
        var error: NSError?
        
        if context.canEvaluatePolicy(
            LAPolicy.deviceOwnerAuthenticationWithBiometrics,
            error: &error) {
            
            // Device can use TouchID
            context.evaluatePolicy(
                LAPolicy.deviceOwnerAuthenticationWithBiometrics,
                localizedReason: "Access requires authentication",
                reply: {(success, error) in
                    DispatchQueue.main.async {
                        
                        if error != nil {
                            
                            switch error!._code {
                                
                            case LAError.Code.systemCancel.rawValue:
                                self.notifyUser("Session cancelled",
                                                err: error?.localizedDescription)
                                
                            case LAError.Code.userCancel.rawValue:
                                self.notifyUser("Please try again",
                                                err: error?.localizedDescription)
                                
                            case LAError.Code.userFallback.rawValue:
                                self.notifyUser("Authentication",
                                                err: "Password option selected")
                                // Custom code to obtain password here
                                
                            default:
                                self.notifyUser("Authentication failed",
                                                err: error?.localizedDescription)
                            }
                            
                        } else {
                            self.notifyUser("Authentication Successful",
                                            err: "You now have full access")
                            
                        }
                    }

                   self.navigateTo()
            })
           
        } else {
            // Device cannot use TouchID
            switch error!.code{
                
            case LAError.Code.touchIDNotEnrolled.rawValue:
                notifyUser("TouchID is not enrolled",
                           err: error?.localizedDescription)
                
            case LAError.Code.passcodeNotSet.rawValue:
                notifyUser("A passcode has not been set",
                           err: error?.localizedDescription)
                
            default:
                notifyUser("TouchID not available",
                           err: error?.localizedDescription)
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigateTo()
    {
        if let loggedInSuccess = storyboard?.instantiateViewController(withIdentifier: "EmployeePortal"){
            self.navigationController?.pushViewController(loggedInSuccess, animated: true)
        }
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
