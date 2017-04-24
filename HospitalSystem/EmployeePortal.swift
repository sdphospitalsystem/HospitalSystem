//
//  EmployeePortal.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 4/21/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import UIKit

class EmployeePortal: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //var scanner:ScanPi = ScanPi()

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!

    var appData:Array<Dictionary<String,String>> = Array(arrayLiteral: Dictionary<String,String>())
    var numberOfApps:Int = 0
    
    override func viewDidLoad() {
        //Set the date to whatever it is today:
        super.viewDidLoad()
        tableView.allowsSelection = false
        
        //DELETE THIS AFTER TESTING
        UserDefaults.standard.set("johndoe", forKey: "currentEmployee")
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        let date = dateFormatter.string(from: currentDate)
        dateLabel.text = date
        self.tableView.setContentOffset(.zero, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func patientDirectory(_ sender: UIButton)
    {
        
    }
    @IBAction func scanBand(_ sender: UIButton)
    {
        activity.startAnimating()
        //let webuid:String = scanner.getWebUID()
        //get one patient and display in new view
        let Scanner:ScanPi = ScanPi()
        activity.stopAnimating()
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "ScanRFIDSegue", sender: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Get this employees appointments
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        activity.hidesWhenStopped = true
        let currentUser = UserDefaults.standard.string(forKey: "currentEmployee")
        let _URL = URL(string: "http://sdphospitalsystem.uconn.edu/get_app.php")
        var request = URLRequest(url: _URL!)
        request.httpMethod="POST"
        let postString = "uname=johndoe"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            do{
                let JSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! Array<Dictionary<String,String>>
                
                self.numberOfApps = JSON.count
                self.appData = JSON
                
                
                DispatchQueue.main.async(execute: {()-> Void in
                    self.tableView.reloadData()
                })
                //JSON file contains everything needed to make appointments
            }catch{
                print("ERROR DOWNLOADING JSON")
            }
        }
        task.resume()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // There is only one section since this table view only has cells of appointments
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //The number of rows is equal to the amount of appointments the data returned:
        return self.numberOfApps
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "appCell", for: indexPath) as! appCell
        cell.setDefault()
        let row = indexPath.row

        if let currentName:String = self.appData[row]["pName"]!
        {
            cell.patientName.text = currentName
        }
        if let currentReason:String = self.appData[row]["reason"]!
        {
           cell.reasonLabel.text = currentReason
        }
        if let currentDate:String = self.appData[row]["date"]!
        {
            cell.dateLabel.text = currentDate
        }
        
        
       return cell
    }
    

}
