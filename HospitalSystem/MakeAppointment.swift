//
//  MakeAppointment.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 4/21/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//
import Foundation
import UIKit

class MakeAppointment: UIViewController {

    var NAME:String!
    @IBOutlet weak var appDate: UIDatePicker!

    
    @IBOutlet weak var reasonText: UITextField!
    var returnData:Data = Data()
    
    @IBAction func scheduleApp(_ sender: UIButton)
    {
        let CurrentPatient = UserDefaults.standard.object(forKey: "CurrentPatientDetails") as! [String:String]
        let date = appDate.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:MM:SS"
        let mysqlDate:String = dateFormatter.string(from: date)
        print(mysqlDate)
        let textResponse:String = reasonText.text!
        let name:String = CurrentPatient["PName"]!
        
        let _URL = URL(string: "http://sdphospitalsystem.uconn.edu/make_appointment.php")
        var request = URLRequest(url: _URL!)
        request.httpMethod="POST"
        let postString = "pName=\(name)&date=\(mysqlDate)&reason=\(textResponse)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            print(String(data: data!, encoding: .utf8))
        }
        task.resume()
        DispatchQueue.main.async {
            var alert = UIAlertController(title: "Make Appointment", message: "Success!, you have registered your appointment.", preferredStyle: .alert)
            var OK = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(OK)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func textField(_ sender: AnyObject) {
        self.view.endEditing(true);
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
