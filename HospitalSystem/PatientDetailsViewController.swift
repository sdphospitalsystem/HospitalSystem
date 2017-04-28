//
//  PatientDetailsViewController.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 4/25/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import UIKit

class PatientDetailsViewController: UIViewController {


    @IBOutlet weak var patientImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addrLabel: UILabel!
    @IBOutlet weak var unameLabel: UILabel!
    
    @IBOutlet weak var sexLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Load the patients details from U.D
        let CurrentUser = UserDefaults.standard.object(forKey: "CurrentPatientDetails") as! [String:String]
        let uname:String = CurrentUser["PUsername"]!
        if let imageData = UserDefaults.standard.object(forKey: uname) as? Data{
            if let _image = UIImage(data: imageData)
            {
                patientImage.image = _image
            }
        }
        nameLabel.text! = CurrentUser["PName"]!
        addrLabel.text! = CurrentUser["Address"]!
        unameLabel.text! = CurrentUser["PUsername"]!

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
