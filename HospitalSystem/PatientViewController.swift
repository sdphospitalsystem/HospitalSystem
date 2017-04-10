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
    var finalUID : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let session = NMSSHSession.connect(toHost: "50.28.143.246:/libnfc/examples", port: 22, withUsername: "pi")
        if(session?.isConnected)!{
            session?.authenticate(byPassword: "raspberry")
        }
        
        do { let response = try session?.channel.execute("nfc-poll", error: nil, timeout: 10000000)
            let _uid = response?.range(of: "UID")
            let uidEnd = _uid?.upperBound
            let rightIndex = response?.index(uidEnd!, offsetBy: 11)
            let uid = response?.substring(from: rightIndex!)
            let uidstart = uid?.startIndex
            let index = uid!.index(uidstart!, offsetBy: 14)
            var UID = uid?.substring(to: index)
            finalUID = (UID?.replacingOccurrences(of: "  ", with: "%20"))!
        } catch {
            print(error.localizedDescription)
        }
        let URLString = String(format: "http://sdphospitalsystem.uconn.edu/get_patient.php?prfid=%@", finalUID)
        let url = URL(string: URLString)
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

