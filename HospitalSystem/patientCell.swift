//
//  patientCell.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 4/21/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import UIKit
import MessageUI

class patientCell: UITableViewCell, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var patientImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var hrLabel: UILabel!
    @IBOutlet weak var btLabel: UILabel!
    @IBOutlet weak var daLabel: UILabel!
    @IBOutlet weak var rtLabel: UILabel!
    
    var Name:String = ""
    var Email:String = ""
    var Phone:String = ""
    @IBAction func contactPatient(_ sender: UIButton)
    {
    ///MOVED TO AllPatientTableController
        
    }
    @IBAction func deletePatient(_ sender: UIButton)
    {
    
 ///MOVED TO AllPatientTableController
    }
    
    //function to send emails
    func sendEmail(Recipient:String, Subject:String)
    {
        let toSend = [Recipient]
        if MFMailComposeViewController.canSendMail()
        {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(toSend)
            mail.setMessageBody(Subject, isHTML: true)
            UIApplication.shared.keyWindow?.rootViewController?.present(mail, animated: true, completion: nil)
        }else{
            print("Error displaying MailView")
        }
    }
    
    //func to drive emails:
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //download the data for contacts

        /**let _URL = URL(string: "http://sdphospitalsystem.uconn.edu/iosContacts.php")
        var request = URLRequest(url: _URL!)
        request.httpMethod="POST"
        print("NAME: \(self.Name)")
        let postString = "name=\(self.Name)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            do{
                let JSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! Array<String>
                self.Email = JSON[0]
                self.Phone = JSON[1]
            }catch{
                print("ERROR DOWNLOADING JSON")
            }
        }
        task.resume()**/
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
