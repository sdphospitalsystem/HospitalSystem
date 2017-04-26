//
//  SuccessViewController.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 4/25/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {

    var UNAME:String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SuccessSegue"
        {
            var destNav = segue.destination as! UINavigationController
            var nextView = destNav.topViewController as! PatientPortal
            nextView.UNAME = self.UNAME
        }
    }



}
