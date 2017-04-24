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

    

    
    @IBAction func contactPatient(_ sender: UIButton)
    {
        
        
    }
    
    @IBAction func cancelApp(_ sender: UIButton)
    {
        let _URL = URL(string: "http://sdphospitalsystem.uconn.edu/delete_appointment.php")
        var request = URLRequest(url: _URL!)
        request.httpMethod="POST"
        let postString = "pName=\(self.patientName.text!)"
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
    
    
    func setDefault()
    {
        
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
