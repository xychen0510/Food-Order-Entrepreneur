//
//  Utils.swift
//  UserLoginAndRegistration
//
//  Created by Chaoran Wang on 4/27/16.
//  Copyright © 2016 food. All rights reserved.
//

import UIKit
import Foundation

class Utils {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    static func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(testStr)
        return result
    }
    
    static func displayMyAlertMessage(userMessage:String, controller: UIViewController) {
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert);
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
        myAlert.addAction(okAction);
        controller.presentViewController(myAlert, animated: true, completion: nil);
    }
    
    // encode: convert from menu list to a string
    func encoding() -> String {
        print("start encoding")
        
        var orderPackage = String()
        var dishPackage = String()
        let loadData = NSUserDefaults().objectForKey("myShoppingCart") as? NSData
        var cart = (NSKeyedUnarchiver.unarchiveObjectWithData(loadData!) as? [Int:Int])!
        
        for (id, frequency) in cart {
            var dishID = NSString(format: "%03d", id)
            dishPackage = String( (Int(dishID as String)!<<1) | Int(frequency) )
            
            if orderPackage.isEmpty {
                orderPackage = dishPackage
            }
            else {
                orderPackage = String(Int(orderPackage)!<<4 | Int(dishPackage)!)
            }
        }
        return orderPackage
    }
    
    // decode: opposite direction as encode
    func decoding(orderPackage: String) -> [Int:Int] {
        print("start decoding")
        
        var cart : [Int:Int] = [:]
        var dishPackage = String()
        var orderPackageRetrieve = orderPackage
        var len = orderPackage.characters.count
        
        while(!orderPackageRetrieve.isEmpty) {
            dishPackage = orderPackageRetrieve.substringWithRange(Range<String.Index>(start: orderPackageRetrieve.startIndex.advancedBy(len-4), end: orderPackageRetrieve.endIndex.advancedBy(0)))
            var id = Int( dishPackage.substringWithRange(Range<String.Index>(start: dishPackage.startIndex.advancedBy(0), end: dishPackage.endIndex.advancedBy(-1))) )
            var frequency = Int( dishPackage.substringWithRange(Range<String.Index>(start: dishPackage.startIndex.advancedBy(3), end: dishPackage.endIndex.advancedBy(0))) )
            
            cart[id!] = frequency
            orderPackageRetrieve = String(Int(orderPackageRetrieve)!>>4)
            len = len-4
        }
        
        return cart
        
    }
}
