//
//  ScanPi.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 4/9/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import Foundation
import UIKit

class ScanPi {
    let session = NMSSHSession.connect(toHost: "sdppi.hopto.org:/libnfc/examples", port: 22, withUsername: "pi")
    
    func getUID()->String{
        var UID:String = ""
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
            UID = (uid?.substring(to: index))!
        } catch {
            print(error.localizedDescription)
        }
        return UID
    }
    
    func getWebUID()->String{
        var UID:String=""
        UID = self.getUID()
        UID = UID.replacingOccurrences(of: "  ", with: "%20%20")
        return UID
    }
    
    
    
    
    
}
