//
//  ResetPasswordViewController.swift
//  UserLoginAndRegistration
//
//  Created by Chaoran Wang on 4/27/16.
//  Copyright © 2016 food. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func confirmResetButtonTapped(sender: UIButton) {
        let userEmail = userEmailTextField.text!;
        if(userEmail.isEmpty) { return; }
        
        if (!Utils.isValidEmail(userEmail)){
            displayMyAlertMessage("Please enter a valid email!");
            return;
        }
        
        /* Begin contacting server end*/
        let myUrl = NSURL(string: "http://www.jogchat.com/Food-Order-Entrepreneur-PHP/user-register/resetPassword.php");
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        
        let postString = "email=\(userEmail)";
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
                    
                    var isResetEmailSent:Bool = false;
                    if(resultValue == "Success") { isResetEmailSent = true; }
                    var messageToDisplay:String = parseJSON["message"] as! String!;
                    
                    if (!isResetEmailSent) {
                        messageToDisplay = parseJSON["message"] as! String!;
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        // Display alert message with confirmation.
                        let myAlert = UIAlertController(title:"Alert", message: messageToDisplay, preferredStyle: UIAlertControllerStyle.Alert);
                        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.Default){ action in
                            self.dismissViewControllerAnimated(true, completion: nil);
                        }
                        myAlert.addAction(okAction);
                        self.presentViewController(myAlert, animated: true, completion: nil);
                    });
                }
            } catch{print(error)}
        }
        task.resume();
    }
    
    
    @IBAction func returnToLoginPageButtonTapped(sender: UIButton) {
            self.dismissViewControllerAnimated(true, completion: nil);
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
