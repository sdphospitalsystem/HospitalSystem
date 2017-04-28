//
//  SuccessViewController.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 4/25/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//By this View, the new patients image should already be up so we can get that and save it
        let CurrUser:[String:String] = UserDefaults.standard.object(forKey: "CurrentPatientDetails") as! [String:String]
        let uname:String = CurrUser["PUsername"]!
        let picturePath:String = uname + ".jpeg"
        if let imageURL = URL(string: "http://sdphospitalsystem.uconn.edu/includes/uploads/" + picturePath){
            downloadImage(url: imageURL, username: uname)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?,_ response: URLResponse?, _ error: Error?) -> Void){
        URLSession.shared.dataTask(with: url){
            (data,response,error) in
            completion(data,response,error)
            }.resume()
    }
    
    func downloadImage(url: URL, username:String)
    {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error) in
            guard let data = data, error == nil else {return}
            print("Download Finished")
            DispatchQueue.main.async {()-> Void in
                let image = UIImage(data: data)
                let JPG = UIImageJPEGRepresentation(image!, 1.0)
                UserDefaults.standard.set(JPG, forKey: username)
            }
        }
    }



}
