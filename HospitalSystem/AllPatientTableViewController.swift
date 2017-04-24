//
//  AllPatientTableViewController.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 4/21/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import UIKit

class AllPatientTableViewController: UITableViewController {

    @IBOutlet weak var patient: patientCell!
    var appData:Array<Dictionary<String,Any>>? = nil
    var numberOfApps:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.layoutIfNeeded()
        //self.tableView.allowsSelection = false
        self.tableView.reloadData()
        let _URL = URL(string: "http://sdphospitalsystem.uconn.edu/get_all_patient.php")
        do {
            let data =  try Data(contentsOf: _URL!)
            let JSON = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! Array<Dictionary<String, Any>>
            self.appData = JSON
            self.numberOfApps = (self.appData?.count)!
        }catch{
            print("Cannot download data")
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.numberOfApps
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "patientDetail", for: indexPath) as! patientCell
        let row = indexPath.row
        cell.addLabel.text = self.appData?[row]["Address"]as! String
        //cell.daLabel.text = self.appData?[row]["DateAdmitted"] as! String
        //cell.rtLabel.text = self.appData?[row]["LoginAs"] as! String
        cell.sexLabel.text = self.appData?[row]["Sex"] as! String
        cell.nameLabel.text = self.appData?[row]["PName"] as! String
        cell.Name = self.appData?[row]["PName"] as! String
        let uname = self.appData?[row]["PUsername"] as! String
        DispatchQueue.main.async {
            let picturePath:String = uname+".jpeg"
            let imageURL:URL = URL(string: "http://sdphospitalsystem.uconn.edu/includes/uploads/" + picturePath)!
            let session = URLSession(configuration: .default)
            let picTask = session.dataTask(with: imageURL) { (data,response,error) in
                if let e = error {
                    print("ERROR: \(e)")
                }else{
                    if let imageData = data{
                        let IMAGE = UIImage(data: imageData)
                        cell.imageView?.image = IMAGE //set cell image to picture from url
                    }else
                    {
                        print("Could not get image")
                    }
                }
                
            }
            picTask.resume()
        }
        
        cell.setNeedsLayout()
        return cell
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
