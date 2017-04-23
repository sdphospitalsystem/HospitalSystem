//
//  PatientPortal.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 4/22/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import UIKit

class PatientPortal: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!

    @IBAction func logoutClicked(_ sender: UIButton)
    {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        let date = dateFormatter.string(from: currentDate)
        dateLabel.text = date
        
        
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
