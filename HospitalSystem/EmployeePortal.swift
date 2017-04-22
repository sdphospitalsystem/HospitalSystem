//
//  EmployeePortal.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 4/21/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import UIKit

class EmployeePortal: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var scanner:ScanPi = ScanPi()
    @IBOutlet weak var appView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!

    
    
    override func viewDidLoad() {
        //Set the date to whatever it is today:
        super.viewDidLoad()
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
        let webuid:String = scanner.getWebUID()
        //get one patient and display in new view
        
    }

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
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
