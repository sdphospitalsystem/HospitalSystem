//
//  ViewController.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 3/29/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import UIKit
import Foundation

class EmployeeViewController: UIViewController {
    
    
    @IBOutlet weak var empName: UILabel!
    @IBOutlet weak var empSex: UILabel!
    
    var Name : String = ""
    var Sex : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://sdphospitalsystem.uconn.edu/get_doctor.php?erfid=1003")
        do {
            let RESULT = try Data(contentsOf: url!)
            let JSON = try JSONSerialization.jsonObject(with: RESULT, options: .mutableContainers) as! [String : Any]
            Name = JSON["EName"] as! String
            Sex = JSON["ESex"] as! String

            empName.text = Name
            empSex.text = Sex
        }
        catch {
            print("ERROR DOWNLOADING JSON DATA")
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

