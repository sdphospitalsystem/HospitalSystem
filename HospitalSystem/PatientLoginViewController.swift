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
    var Defaults = UserDefaults.standard
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func login(_ sender: UIButton) {
        var userExists:String = ""
        self.USERNAME = username.text!
        self.PASSWORD = password.text!
        
//We first get all the patient details based and save them so no more data requests need to be made:
        
        let URLString = String(format: "http://sdphospitalsystem.uconn.edu/get_patient_from_uname.php?uname=%@", self.USERNAME)
        let _url = URL(string: URLString)
        do {
            let RESULT = try Data(contentsOf: _url!)
            let CurrentPatientDetails = try JSONSerialization.jsonObject(with: RESULT, options: .mutableContainers) as! [String:String]
            let uname:String = CurrentPatientDetails["PUsername"] as! String
            UserDefaults.standard.set(CurrentPatientDetails, forKey: "CurrentPatientDetails")
            
//we now get the patients image and save it to his username:
            let picturePath:String = uname + ".jpeg"
            if let imageURL = URL(string: "http://sdphospitalsystem.uconn.edu/includes/uploads/" + picturePath){
                downloadImage(url: imageURL, username: uname)
            }
//Finally we get all the doctors:
            let _URL = URL(string: "http://sdphospitalsystem.uconn.edu/contact_doctor.php")
            do {
                let data = try Data(contentsOf: _URL!)
                let JSON = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String:String]]
                UserDefaults.standard.set(JSON, forKey: "DoctorContacts")
            } catch {
                print("Error downlading data")
            }
            UserDefaults.standard.synchronize()
        } catch  {
            "Error Downloading and saving data"
        }
        
        //Run script to login
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
                DispatchQueue.main.async {
                    //User does not exist
                    let alert = UIAlertController(title: "Error", message: "Not a valid username/password combo", preferredStyle: .alert)
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
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?,_ response: URLResponse?, _ error: Error?) -> Void){
        URLSession.shared.dataTask(with: url){
            (data,response,error) in
            completion(data,response,error)
            }.resume()
    }
    
    func downloadImage(url: URL, username:String)
    {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error) in
            guard let data = data, error == nil else {return}
            print("Download Finished")
            DispatchQueue.main.async {()-> Void in
                let image = UIImage(data: data)
                let JPG = UIImageJPEGRepresentation(image!, 1.0)
                self.Defaults.set(JPG, forKey: username)
            }
        }
    }
    
    
}
