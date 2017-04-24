//
//  appCell.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 4/21/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import UIKit
import MessageUI


class appCell: UITableViewCell, MFMailComposeViewControllerDelegate {

    
    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var reasonLabel: UILabel!

    var Email:String = ""
    var Phone:String = ""
    
  

    
    @IBAction func contactPatient(_ sender: UIButton)
    {
        print("Contact button clicked")
        //get the data for contacts
        //Get the contact data
        let _URL2 = URL(string: "http://sdphospitalsystem.uconn.edu/iosContacts.php")
        var request = URLRequest(url: _URL2!)
        request.httpMethod="POST"
        let postString = "name=\(self.patientName.text!)"
        print("NAME: \(self.patientName.text!)")
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
        task.resume()
        
        
        //Present an alert to ask the user if they want to contact
        var contactAlert = UIAlertController(title: "Contact", message: "Choose Email or Phone", preferredStyle: .alert)
        var _phone = UIAlertAction(title: "Phone", style: .default) { (UIAlertAction) in
            //code to make call here
            //phone "url":
            let phoneURL:URL = URL(string: "telprompt://\(self.Phone)")!
            UIApplication.shared.openURL(phoneURL)
        }
        var _email = UIAlertAction(title: "Email", style: .default) { (UIAlertAction) in
            //Code to do email here
            self.sendEmail(Recipient: self.Email, Subject: "Test")
        }
        contactAlert.addAction(_phone)
        contactAlert.addAction(_email)
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: false, completion: nil)
            UIApplication.shared.keyWindow?.rootViewController?.present(contactAlert, animated: true, completion: nil)
        }
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
            DispatchQueue.main.async {
                UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: false, completion: nil)
                UIApplication.shared.keyWindow?.rootViewController?.present(mail, animated: true, completion: nil)
            }
        }else{
            print("Error displaying MailView")
        }
    }
    
    //func to drive emails:
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func cancelApp(_ sender: UIButton)
    {
        let _URL = URL(string: "http://sdphospitalsystem.uconn.edu/delete_appointment.php")
        var request = URLRequest(url: _URL!)
        request.httpMethod="POST"
        let postString = "pName=\(self.patientName.text!)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            do{
                print(String(data: data!, encoding: .utf8))
            }catch{
                print("ERROR DOWNLOADING JSON")
            }
        }
        task.resume()
        
}
    
    
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
