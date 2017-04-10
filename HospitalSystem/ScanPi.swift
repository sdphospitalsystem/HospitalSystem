//
//  ScanPi.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 4/9/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import Foundation
import UIKit

class ScanPi: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let session = NMSSHSession.connect(toHost: "137.99.226.18:/libnfc/examples", port: 22, withUsername: "pi")
        if(session?.isConnected)!{
            session?.authenticate(byPassword: "raspberry")
        }
        do { let response = try session?.channel.execute("nfc-poll", error: nil, timeout: 10000000)
            let _uid = response?.range(of: "UID")
            let uidEnd = _uid?.upperBound
            let rightIndex = response?.index(uidEnd!, offsetBy: 11)
            let uid = response?.substring(from: rightIndex!)
            let uidstart = uid?.startIndex
            let index = uid!.index(uidstart!, offsetBy: 14)
            let UID = uid?.substring(to: index)
            print(UID)
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    
    
    
}
