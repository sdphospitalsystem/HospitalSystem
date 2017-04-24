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
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var addr: UILabel!
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var username: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        let Scan:ScanPi = ScanPi()
        let finalUID = Scan.getWebUID()
        let URLString = String(format: "http://sdphospitalsystem.uconn.edu/get_patient.php?prfid=%@", finalUID)
        let url = URL(string: URLString)
        do {
            let RESULT = try Data(contentsOf: url!)
            let JSON = try JSONSerialization.jsonObject(with: RESULT, options: .mutableContainers) as! [String : Any]
            name.text = JSON["PName"] as! String
            addr.text = JSON["Address"] as! String
            sex.text = JSON["Sex"] as! String
            username.text = JSON["PUsername"] as! String
            DispatchQueue.main.async {
                let picturePath:String = JSON["PUsername"] as! String + ".jpeg"
                let imageURL:URL = URL(string: "http://sdphospitalsystem.uconn.edu/includes/uploads/" + picturePath)!
                let session = URLSession(configuration: .default)
                let picTask = session.dataTask(with: imageURL) { (data,response,error) in
                    if let e = error {
                        print("ERROR: \(e)")
                    }else{
                        if let imageData = data{
                            let IMAGE = UIImage(data: imageData)
                             self.imageView.image = IMAGE!
                        }else
                        {
                            print("Could not get image")
                        }
                    }
                    
                }
                picTask.resume()
            }
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

