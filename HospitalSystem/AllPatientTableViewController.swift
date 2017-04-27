//
//  AllPatientTableViewController.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 4/21/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import UIKit
import MessageUI

class AllPatientTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    let Defaults = UserDefaults.standard
    
    @IBAction func contactPatientClicked(_ sender: Any) {
        print("Contact button clicked")
        //get the data for contacts
        //Get the contact data
        var Email:String = ""
        var Phone:String = ""
        let _index:IndexPath? = self.tableView.indexPathForSelectedRow
        let _Cell = self.tableView.cellForRow(at: _index!) as! patientCell
        let _Name = _Cell.nameLabel.text!
        let _URL2 = URL(string: "http://sdphospitalsystem.uconn.edu/iosContacts.php")
        var request = URLRequest(url: _URL2!)
        request.httpMethod="POST"
        let postString = "name=\(_Name)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            do{
                let JSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! Array<String>
                Email = JSON[0]
                Phone = JSON[1]
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
            let phoneURL:URL = URL(string: "telprompt://\(Phone)")!
            UIApplication.shared.openURL(phoneURL)
        }
        var _email = UIAlertAction(title: "Email", style: .default) { (UIAlertAction) in
            //Code to do email here
            self.sendEmail(Recipient: Email, Subject: "Test")
        }
        contactAlert.addAction(_phone)
        contactAlert.addAction(_email)
        self.present(contactAlert, animated: true, completion: nil)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        tableView.allowsSelectionDuringEditing = false
        self.tableView.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Load the pictures and patient data from defaults
        
        //self.AllPatients = Defaults.object(forKey: "AllPatientData") as! Array<Dictionary<String, String>>
        //self.Pictures = Defaults.object(forKey: "PatientImages") as! Dictionary<String, UIImage>
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {return 1}
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let Patients = Defaults.object(forKey: "AllPatientData") as! Array<Dictionary<String, Any>>
        return Patients.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Patients = Defaults.object(forKey: "AllPatientData") as! Array<Dictionary<String, String>>
        let cell = tableView.dequeueReusableCell(withIdentifier: "patientDetail", for: indexPath) as! patientCell
        let row = indexPath.row
        cell.addLabel.text! = Patients[row]["Address"]!
        cell.sexLabel.text! = Patients[row]["Sex"]!
        cell.nameLabel.text! = Patients[row]["PName"]!
        let currentUNAME:String = Patients[row]["PUsername"]!
        if let imageData = Defaults.object(forKey: currentUNAME) as? Data{
            if let _image = UIImage(data: imageData)
            {
                cell.pImage.image = _image
            }
        }
        
        cell.setNeedsLayout()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        var Patients = Defaults.object(forKey: "AllPatientData") as! Array<Dictionary<String, Any>>
        if(editingStyle == UITableViewCellEditingStyle.delete)
        {
            let currentRowToDelete = indexPath.row
            let currentPatientToDelete = Patients[currentRowToDelete]["pName"]!
            Patients.remove(at: currentRowToDelete) //actually delete it from data
            //Delete from DB
            let _URL = URL(string: "http://sdphospitalsystem.uconn.edu/remove_patient.php")
            var request = URLRequest(url: _URL!)
            request.httpMethod="POST"
            let postString = "name=\(currentPatientToDelete)"
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
        //save updated data to UD
        Defaults.set(Patients, forKey: "AllPatientData") as! Array<Dictionary<String, Any>>
        self.tableView.deleteRows(at: [indexPath], with: .left)
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
            self.present(mail, animated: true, completion: nil)
        }else{
            print("Error displaying MailView")
        }
    }
    
    //func to drive emails:
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
