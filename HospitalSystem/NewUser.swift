//
//  NewUser.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 4/12/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import Foundation
import UIKit

class NewUser: UIViewController
{
    var NewPatient: Patient = Patient()
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var addr: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NewPatient.setName(NAME: name.text!)
        NewPatient.setPassword(PWD: pass.text!)
        NewPatient.setAddress(ADD: addr.text!)
        let Scanner: ScanPi = ScanPi()
        let UID: String = Scanner.getUID()
        

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
