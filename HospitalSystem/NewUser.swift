//
//  NewUser.swift
//  HospitalSystem
//
//  Created by Andras Palfi on 4/12/17.
//  Copyright © 2017 Andras Palfi. All rights reserved.
//

import Foundation
import UIKit

//**Class for Registration Page View Controllers*/
class NewUser: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    //UI Elements
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var addr: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var sex: UITextField!
    
    //Constants
    var NAME:String = ""
    var PASS:String=""
    var ADDR:String=""
    var USERNAME:String=""
    var EMAIL:String=""
    var PHONE:String=""
    var UID:String = ""
    var SEX:String = ""
    var Scanner:ScanPi = ScanPi()    

 
//"Choose Image From Library" button, opens the library
    //and saves a picture ot the ImageView
    @IBAction func chooseImage(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            
        }
        
    }
    
    //"Press to Scan RFID tag. Starts activity animation until the PI is done scanning
    @IBAction func registerRFID(_ sender: Any) {
        activity.startAnimating()
        UID = Scanner.getUID()
        continueButton.setTitle("Succesfully Registered RFID tag", for: .normal)
        activity.stopAnimating()
        }
    
    //"Register" Button. Starts a progress view, saves all the 
    //data that the user inputs, sends register_patient data,
    //uploads image to DB
    @IBAction func `continue`(_ sender: UIButton)
    {
        progress.progress=0.0
        //Sends the text data to register patients
        NAME = name.text!
        PASS = pass.text!
        ADDR = addr.text!
        USERNAME = username.text!
        EMAIL = email.text!
        PHONE = phone.text!
        SEX = sex.text!
        print("Sending Data")
        var request = URLRequest(url: NSURL(string: "http://sdphospitalsystem.uconn.edu/register_patient.php")! as URL)
        progress.isHidden = false
        progress.progress=0
        progress.progress+=0.1
        progress.progress+=0.2
        request.httpMethod = "POST"
        
        print("UID= \(UID)")
        print("NAME= \(NAME)")
        print("PASS= \(PASS)")
        print("ADDR= \(ADDR)")
        print("USERNAME= \(USERNAME)")
        print("EMAIL= \(EMAIL)")
        print("PHONE= \(PHONE)")
        print("SEX= \(SEX)")
        
        let postString = "rfid=\(UID)&name=\(NAME)&pass=\(PASS)&add=\(ADDR)&uname=\(USERNAME)&email=\(EMAIL)&phone=\(PHONE)&sex=\(SEX)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            print("response = \(response)")
            
        }
        task.resume()
        progress.progress+=0.2
        //Upload the image data
        let IMAGE:UIImage = imageView.image!
        ImageUploadRequest(pictureToUpload: IMAGE)
        
    }
    
    //Opens the view to select a picture
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo:[NSObject : AnyObject]!) {
        
        imageView.image = image
        self.dismiss(animated: true, completion: nil);
    }
    
    //Used for php stuff
    func generateBoundaryString() -> String {
        
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    //Function to upload an image to the DB
    func ImageUploadRequest(pictureToUpload: UIImage)
    {
        progress.progress+=0.1
        let _URL = URL(string: "http://sdphospitalsystem.uconn.edu/includes/iosImage.php")
        var request = URLRequest(url: _URL!)
        request.httpMethod="POST";
        let param = ["name" : USERNAME]
        let boundary = generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let imageData = UIImageJPEGRepresentation(pictureToUpload, 0.9) //sending image as JPG
        progress.progress+=0.1
        if(imageData==nil){return;}
        //create the body of data to send:
        request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
        //send the httpbody:
        let ses = URLSession(configuration: .default)
        progress.progress+=0.1
        let task = ses.dataTask(with: request)
        {
            data, response, error in
            if error != nil
            {
                print("error=\(error)")
                return
            }
            self.progress.progress+=0.1
            print("******* response = \(response)")
            let responseString = String(data: data!, encoding: .utf8)
            print("****** response data = \(responseString!)")
            //try to decode the response:
            do
            {
                self.progress.progress+=0.1
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String,String>
                print(json)
                //reset the image to nothing
                self.imageView.image = nil
            }catch{
                print(error)
            }
        }
        task.resume()
        self.progress.progress=1.0
    }
    
    //function to create an HTML message that can send images through PHP
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: Data, boundary: String)-> Data
    {
        var body = Data()
        if parameters != nil
        {
            for(key,value) in parameters!
            {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        let filename = self.USERNAME + ".jpeg"
        let mimetype = "image/jpg"
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data!)
        body.appendString(string: "\r\n")
        body.appendString(string: "--\(boundary)--\r\n")
        return body
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        activity.hidesWhenStopped=true
        progress.isHidden=true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
//extension for appending strings in the HTMl function
extension Data
{
    mutating func appendString(string: String)
    {
        let data = string.data(using: .utf8, allowLossyConversion: true)
        append(data!)
    }
}
