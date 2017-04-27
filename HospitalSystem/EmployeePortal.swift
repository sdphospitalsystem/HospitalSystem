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
    let Defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        tableView.allowsSelectionDuringEditing = false
        //tableView.setEditing(true, animated: false)
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        let date = dateFormatter.string(from: currentDate)
        dateLabel.text = date
        self.tableView.setContentOffset(.zero, animated: true)
        //Set the date to whatever it is today:
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        self.tableView.dataSource = self
        self.tableView.delegate = self
        }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // There is only one section since this table view only has cells of appointments
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //The number of rows is equal to the amount of appointments the data returned:
        let ApptData = Defaults.object(forKey: "ApptData") as! Array<Dictionary<String,String>>
        return ApptData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "appCell", for: indexPath) as! appCell
        let row = indexPath.row
        var ApptData = Defaults.object(forKey: "ApptData") as! Array<Dictionary<String,String>>
        cell.patientName.text! = ApptData[row]["pName"]!
        cell.reasonLabel.text! = ApptData[row]["reason"]!
        cell.dateLabel.text! = ApptData[row]["date"]!
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        var ApptData = Defaults.object(forKey: "ApptData") as! Array<Dictionary<String,String>>
        if(editingStyle == UITableViewCellEditingStyle.delete)
        {
            let currentRowToDelete = indexPath.row
            let currentAppToDelete = ApptData[currentRowToDelete]["pName"]!
            ApptData.remove(at: currentRowToDelete) //actually delete it from user defaults data
            //Remove it from DB
            let _URL = URL(string: "http://sdphospitalsystem.uconn.edu/delete_appointment.php")
            var request = URLRequest(url: _URL!)
            request.httpMethod="POST"
            let postString = "pName=\(currentAppToDelete)"
            request.httpBody = postString.data(using: String.Encoding.utf8)
            let task = URLSession.shared.dataTask(with: request) {
                data, response, error in
                if error != nil {
                    print("error=\(error)")
                    return
                }
                do{
                    print(String(data: data!, encoding: .utf8))
                }catch{
                    print("ERROR DOWNLOADING JSON")
                }
            }
            task.resume()
        }
        //Save new data set back to UserDefaults
        Defaults.set(ApptData, forKey: "ApptData") as! Array<Dictionary<String,String>>
        self.tableView.deleteRows(at: [indexPath], with: .left) //remove it from the tableview
    }
        
    
    

}
