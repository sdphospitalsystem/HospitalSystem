//
//  ContactDoctorTableViewController.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 4/22/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import UIKit
import MessageUI

class ContactDoctorTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.allowsSelectionDuringEditing = false
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {return 1}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let AllDoctors = UserDefaults.standard.object(forKey: "DoctorContacts") as! [[String:String]]
        return AllDoctors.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let CurrentDoctors = UserDefaults.standard.object(forKey: "DoctorContacts") as! [[String:String]]
        let cell = tableView.dequeueReusableCell(withIdentifier: "doctorCell", for: indexPath) as! doctorCell
        cell.name.text = CurrentDoctors[row]["DName"]!
        cell.setNeedsLayout()
        return cell
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
