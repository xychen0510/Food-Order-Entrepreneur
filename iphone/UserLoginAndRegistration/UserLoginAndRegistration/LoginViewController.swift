//
//  LoginViewController.swift
//  UserLoginAndRegistration
//
//  Created by Chaoran Wang on 4/24/16.
//  Copyright © 2016 food. All rights reserved.
//
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LoginButtonTapped(sender: UIButton) {
        let userEmail = userEmailTextField.text!;
        let userPassword = userPasswordTextField.text!;
        
        if(userEmail.isEmpty || userPassword.isEmpty) { return; }
        
        // Send user data to server side
        let myUrl = NSURL(string: "http://www.jogchat.com/Food-Order-Entrepreneur-PHP/user-register/userLogin.php");
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "Post";
        let postString = "email=\(userEmail)&password=\(userPassword)";
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)\n")
                return
            }
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                
                if let parseJSON = json {
                    let resultValue = parseJSON["status"] as? String
                    print("result:\(resultValue)")
                    
                    
                    let messageToDisplay:String = parseJSON["message"] as! String!;
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        // Display alert message with confirmation.
                        if(resultValue=="Error") {
                            Utils.displayMyAlertMessage(messageToDisplay, controller: self);
                        }

                    });
                    
                    if(resultValue == "Success") {
                        // Login is successful
                        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn");
                        NSUserDefaults.standardUserDefaults().synchronize();
                        self.dismissViewControllerAnimated(true, completion: nil);
                    }
                }
                
            } catch{print(error)}
        }
        task.resume();
        
        /*
        let userEmailStored = NSUserDefaults.standardUserDefaults().stringForKey("userEmail");
        let userPasswordStored = NSUserDefaults.standardUserDefaults().stringForKey("userPassword");
        if (userEmailStored == userEmail) {
            if (userPasswordStored == userPassword) {
                // Login is successful
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn");
                NSUserDefaults.standardUserDefaults().synchronize();
                self.dismissViewControllerAnimated(true, completion: nil);
                
            }
        }*/
        
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
