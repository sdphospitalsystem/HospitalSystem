//
//  GetData.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 4/12/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import Foundation
class GetData
{
    var userType:String = ""
    var fieldType:String = ""
    var value:String = ""
    var baseURL:String = ""
    
    init(usr:String, fld:String, val:String) {
        self.userType = usr
        self.fieldType = fld
        self.value = val
        self.baseURL = "http://sdphospitalsystem.uconn.edu/"
    }
    
    func getURL()->String
    {
        var _URL = ""
        if self.userType=="Patient" && self.fieldType=="PRFID"  {
            _URL =  String(format: self.baseURL + "get_patient.php?prfid=%@", self.value)
        }
        return _URL
    }
    
    func downloadJSON()->JSONSerialization
    {
        
    }
    
    
}
