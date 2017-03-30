//
//  ViewController.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 3/29/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import UIKit
import Foundation

class PatientViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var hrLabel: UILabel!
    @IBOutlet weak var btLabel: UILabel!
    @IBOutlet weak var daLabel: UILabel!
    @IBOutlet weak var roomtypeLabel: UILabel!
    
    var Name : String = ""
    var Sex : String = ""
    var Add : String = ""
    var HR : String = ""
    var BT : String = ""
    var DA : String = ""
    var RoomType : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://sdphospitalsystem.uconn.edu/get_patient.php?prfid=b3%2079%20a2%209e5")
        do {
            let RESULT = try Data(contentsOf: url!)
            let JSON = try JSONSerialization.jsonObject(with: RESULT, options: .mutableContainers) as! [String : Any]
            Name = JSON["PName"] as! String
            Sex = JSON["PSex"] as! String
            Add = JSON["Address"] as! String
            HR = JSON["HeartRate"] as! String
            BT = JSON ["BodyTemp"] as! String
            DA = JSON ["DateAdmitted"] as! String
            RoomType = JSON["PRoomType"] as! String
            nameLabel.text = Name
            sexLabel.text = Sex
            addLabel.text = Add
            hrLabel.text = HR
            btLabel.text = BT
            daLabel.text = DA
            roomtypeLabel.text = RoomType
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

