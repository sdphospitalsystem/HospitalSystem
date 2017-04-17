//
//  Patient.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 4/12/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import Foundation

class Patient
{
    var name: String = ""
    var password: String = ""
    var prfid: String = ""
    var sex: String = ""
    var address: String = ""
    var heart: Int = 0
    var body: Int = 0

    func getName() -> String {return self.name}
    func getPass()->String {return self.password}
    func getPRFID() -> String {return self.prfid}
    func getSex() -> String {return self.sex}
    func getAddress() -> String {return self.address}
    func getHeart() -> Int {return self.heart}
    func getBody() -> Int {return self.body}
    
    func setName(NAME:String) {self.name=NAME}
    func setPassword(PWD:String) {self.password=PWD}
    func setPRFID(PRFID:String) {self.prfid=PRFID}
    func setSex(SEX:String) {self.sex=SEX}
    func setAddress(ADD:String) {self.address=ADD}
    func setHeart(HEART:Int) {self.heart=HEART}
    func setBody(BODY:Int) {self.body=BODY}
    
}
