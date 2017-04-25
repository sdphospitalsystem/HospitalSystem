//
//  PatientDetailsViewController.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 4/25/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import UIKit

class PatientDetailsViewController: UIViewController {

    var UNAME:String!
    
    
    @IBOutlet weak var patientImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addrLabel: UILabel!
    @IBOutlet weak var unameLabel: UILabel!
    
    @IBOutlet weak var sexLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let username = UNAME!
        
        let URLString = String(format: "http://sdphospitalsystem.uconn.edu/get_patient_from_uname.php?uname=%@", username)
        let _URL = URL(string: URLString)
        
        do {
            let RESULT = try Data(contentsOf: _URL!)
            let JSON = try JSONSerialization.jsonObject(with: RESULT, options: .mutableContainers) as! [String : Any]
            nameLabel.text = JSON["PName"] as? String
            addrLabel.text = JSON["Address"] as? String
            sexLabel.text = JSON["Sex"] as? String
            unameLabel.text = JSON["PUsername"] as? String
            DispatchQueue.main.async {
                let picturePath:String = username + ".jpeg"
                let imageURL:URL = URL(string: "http://sdphospitalsystem.uconn.edu/includes/uploads/" + picturePath)!
                let session = URLSession(configuration: .default)
                let picTask = session.dataTask(with: imageURL) { (data,response,error) in
                    if let e = error {
                        print("ERROR: \(e)")
                    }else{
                        if let imageData = data{
                            let IMAGE = UIImage(data: imageData)
                            self.patientImage.image = IMAGE //set cell image to picture from url
                        }else
                        {
                            print("Could not get image")
                        }
                    }
                    
                }
                picTask.resume()

            }
        // Do any additional setup after loading the view.
        }catch{
            print("Error")
        }
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
