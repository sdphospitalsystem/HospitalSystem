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

    var appData:Array<Dictionary<String,Any>>? = nil
    var numberOfApps:Int = 0
    
    override func viewDidLoad() {
        //Set the date to whatever it is today:
        super.viewDidLoad()
        
        activity.hidesWhenStopped = true
        //DELETE THIS AFTER TESTING
        UserDefaults.standard.set("johndoe", forKey: "currentEmployee")
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
    
    @IBAction func patientDirectory(_ sender: UIButton)
    {
        
    }
    @IBAction func scanBand(_ sender: UIButton)
    {
        activity.startAnimating()
        //let webuid:String = scanner.getWebUID()
        //get one patient and display in new view
        
    }

    override func viewWillAppear(_ animated: Bool) {
        //Get this employees appointments
        self.tableView.register(appCell.self, forCellReuseIdentifier: "appCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
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
                let JSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! Array<Dictionary<String,Any>>
                
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
        let row = indexPath.row
   
        cell.patientName.text = self.appData?[row]["pName"] as! String
        cell.reasonLabel.text = self.appData?[row]["reason"] as! String
        cell.dateLabel.text = self.appData?[row]["dat"] as! String
        
    
        return cell
    }
    

}
