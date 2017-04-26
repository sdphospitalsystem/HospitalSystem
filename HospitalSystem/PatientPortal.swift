//
//  PatientPortal.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 4/22/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import UIKit

class PatientPortal: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    var UNAME:String!
    var NAME:String!

    @IBAction func logoutClicked(_ sender: UIButton)
    {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let _URL2 = URL(string: "http://sdphospitalsystem.uconn.edu/iosGetName.php")
        var request = URLRequest(url: _URL2!)
        request.httpMethod="POST"
        let postString = "uname=\(self.UNAME as! String)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            do{
                self.NAME = String(data: data!, encoding: .utf8) as! String
            }catch{
                print("ERROR DOWNLOADING JSON")
            }
        }
        task.resume()

        
        // Do any additional setup after loading the view.
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        let date = dateFormatter.string(from: currentDate)
        dateLabel.text = date
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PatientDetailSegue"
        {
            if let nextView = segue.destination as? PatientDetailsViewController{
                print("Uname 2 : \(self.UNAME)")
                nextView.UNAME = self.UNAME
            }
        }
        if segue.identifier == "MakeAppSegue"
        {
            if let nextView = segue.destination as? MakeAppointment{
                nextView.NAME = self.NAME as! String
            }
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
