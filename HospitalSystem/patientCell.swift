//
//  patientCell.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 4/21/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import UIKit

class patientCell: UITableViewCell {

    @IBOutlet weak var patientImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var hrLabel: UILabel!
    @IBOutlet weak var btLabel: UILabel!
    @IBOutlet weak var daLabel: UILabel!
    @IBOutlet weak var rtLabel: UILabel!
    
    @IBAction func contactPatient(_ sender: UIButton)
    {
        
    }
    @IBAction func deletePatient(_ sender: UIButton)
    {
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
