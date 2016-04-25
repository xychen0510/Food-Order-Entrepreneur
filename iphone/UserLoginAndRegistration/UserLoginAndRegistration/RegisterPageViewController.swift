//
//  RegisterPageViewController.swift
//  UserLoginAndRegistration
//
//  Created by Chaoran Wang on 4/23/16.
//  Copyright © 2016 food. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonTapped(sender: UIButton) {
    
            let userEmail = userEmailTextField.text!;
            
            let userPassword = userPasswordTextField.text!;
            
            let userRepeatPassword = repeatPasswordTextField.text!;
            
            
            
            // Check for empty fields
            
            if (userEmail.isEmpty || userPassword.isEmpty || userRepeatPassword.isEmpty) {
                
                
                
                //Display alert message
                
                displayMyAlertMessage("All fields are required");
                
                return;
                
                
                
            }
            
            
            
            // Check if password match
            
            if (userPassword != userRepeatPassword) {
                
                //Display an alert message
                
                displayMyAlertMessage("Passwords do not match");
                
                return;
                
            }
     
        
        /*
        
        let myUrl = NSURL(string: "http://www.jogchat.com/user-register/userRegister.php");
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        
        let postString = "email=\(userEmail)&password=\(userPassword)";
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                println("error=\(error)")
                return
            }
            
            var err:NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &err) as? NSDictionary
            
            if let parseJSON = json {
                var resultValue = parseJSON("status"] as? String
                println("result" \(resultValue)")
                
                var isUserRegistered:Bool = false;
                if(resultValue == "Success") { isUserRegistered = true; }
                var messageToDisplay:String = parseJSON["message"] as String!;
                
                if (!isUserRegistered) {
                    messageToDisplay = parseJSON["message"] as String!;
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    // Display alert message with confirmation.
                    var myAlert = UIAlertController(title:"Alert", message: messageToDisplay, preferredStyle: UIAlerStyle.Alert);
                    let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.Default){ action in
                        self.dismissViewControllerAnimated(true, completion: nil);
                    }
                    myAlert.addAction(okAction);
                    self.presentViewController(myAlert, animated: true, completion: nil);
                });
                
            }
        }
        
        task.resume();*/
        
        
            // Store user login info locally and make logic test locally.
            
            // Store data
            
            // Usually we don't store these in local device but send it over network
            
            NSUserDefaults.standardUserDefaults().setObject(userEmail, forKey: "userEmail");
            
            NSUserDefaults.standardUserDefaults().setObject(userPassword, forKey: "userPassword");
            
            NSUserDefaults.standardUserDefaults().synchronize();
            
            
            
            // Display alert message with confirmation.
            
            let myAlert = UIAlertController(title: "Alert", message: "Registration is successful. Thank you!", preferredStyle: UIAlertControllerStyle.Alert);
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) {
                
                action in self.dismissViewControllerAnimated(true, completion: nil);
                
            }
            
            myAlert.addAction(okAction);
            
            self.presentViewController(myAlert, animated: true, completion: nil);
    }

    
    func displayMyAlertMessage(userMessage:String) {
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert);
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
        myAlert.addAction(okAction);
        self.presentViewController(myAlert, animated: true, completion: nil);
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
