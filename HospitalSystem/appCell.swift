//
//  appCell.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 4/21/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import UIKit

class appCell: UITableViewCell {

    
    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var reasonLabel: UILabel!


    
    var NAME:String = ""
    var REASON:String = ""
    var DATE:Date? = nil

    
    
    
    @IBAction func contactPatient(_ sender: UIButton)
    {
        let alert = UIAlertController(title: "Contact Patient?", message: "Select EMail or Phone", preferredStyle: .alert)
        let EMail = UIAlertAction(title: "Email", style: .default) { (UIAlertAction) in
            //code to send email here
        
        }
        let Phone = UIAlertAction(title: "Phone", style: .default) { (self) in
            //code to call here
        }
        let Cancel = UIAlertAction(title: "Cancel", style: .default) { (self) in
            return
        }
        alert.addAction(EMail)
        alert.addAction(Phone)
        alert.addAction(Cancel)
    }
    
    @IBAction func cancelApp(_ sender: UIButton)
    {
        let alert = UIAlertController(title: "Delete Appointment?", message: "Are you sure? The patient will be notified of the cancellation.", preferredStyle: .alert)
        let Yes = UIAlertAction(title: "Yes", style: .default) { (UIAlertAction) in
            //code to delete appointment here
        }
        let No = UIAlertAction(title: "Cancel", style: .default) { (UIAlertAction) in
            return
        }
        alert.addAction(Yes)
        alert.addAction(No)
    }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
