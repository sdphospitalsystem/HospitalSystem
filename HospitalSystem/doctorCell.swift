//
//  doctorCell.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 4/22/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import UIKit


class doctorCell: UITableViewCell{
    @IBOutlet weak var name: UILabel!

    var Email:String = ""
    var Phone:String = ""
    
    @IBAction func contactClicked(_ sender: Any) {
        DispatchQueue.main.async {
            print("Clicked here")
            let phoneAlert = UIAlertController(title: "Contact", message: "Make Call?", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Yes", style: .default) { (UIAlertAction) in
                //code to make call here
                //phone "url":
                let phoneURL:URL = URL(string: "telprompt://\(self.Phone)")!
                UIApplication.shared.openURL(phoneURL)
            }
            let no = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            phoneAlert.addAction(ok)
            phoneAlert.addAction(no)
            UIApplication.shared.keyWindow?.rootViewController?.present(phoneAlert, animated: true, completion: {
                phoneAlert.dismiss(animated: true, completion: nil)
            })

        }
        //Present an alert to ask the user if they want to contact
            }
    
    @IBAction func emailClicked(_ sender: Any) {
        
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
