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
    static func encoding() -> String {
        print("start encoding")
        
        var orderPackage = String()
        var dishPackage = String()
        var count = 0
        let loadData = NSUserDefaults().objectForKey("myShoppingCart") as? NSData
        let cart = (NSKeyedUnarchiver.unarchiveObjectWithData(loadData!) as? [Int:Int])!
        
        for (id, frequency) in cart {
            count = count+4
            //print("id \(id)")
            //print("freq \(frequency)")
            //let dishID = NSString(format: "%03d", id)
            //dishPackage = String( (Int(dishID as String)!<<1) | Int(frequency) )
            dishPackage = NSString(format: "%04d", id*10+frequency) as String
            print(dishPackage)
            
            if orderPackage.isEmpty {
                orderPackage = dishPackage
            }
            else {
                //orderPackage = NSString(format: "%0\(count)d", Int(orderPackage)!*10000+Int(dishPackage)!) as String
                orderPackage = orderPackage+dishPackage
            }
        }
        return orderPackage
    }
    
    // decode: opposite direction as encode
    static func decoding(orderPackage: String) -> [Int:Int] {
        print("start decoding")
        
        var cart : [Int:Int] = [:]
        var dishPackage = String()
        var orderPackageRetrieve = orderPackage
        var len = orderPackage.characters.count
        
        while(!orderPackageRetrieve.isEmpty) {
            dishPackage = orderPackageRetrieve.substringWithRange(Range<String.Index>(start: orderPackageRetrieve.startIndex.advancedBy(len-4), end: orderPackageRetrieve.endIndex.advancedBy(0)))
            //print("dishPackage \(dishPackage)")
            let id = Int( dishPackage.substringWithRange(Range<String.Index>(start: dishPackage.startIndex.advancedBy(0), end: dishPackage.endIndex.advancedBy(-1))) )
            //print("id \(id)")
            let frequency = Int( dishPackage.substringWithRange(Range<String.Index>(start: dishPackage.startIndex.advancedBy(3), end: dishPackage.endIndex.advancedBy(0))) )
            //print("frequency \(frequency)")
            
            cart[id!] = frequency
            //orderPackageRetrieve = String(Int(orderPackageRetrieve)!-Int( dishPackage.substringWithRange(Range<String.Index>(start: dishPackage.startIndex.advancedBy(len-4), end: dishPackage.endIndex.advancedBy(0))) )!)
            orderPackageRetrieve = orderPackageRetrieve.substringToIndex(orderPackageRetrieve.endIndex.predecessor())
            orderPackageRetrieve = orderPackageRetrieve.substringToIndex(orderPackageRetrieve.endIndex.predecessor())
            orderPackageRetrieve = orderPackageRetrieve.substringToIndex(orderPackageRetrieve.endIndex.predecessor())
            orderPackageRetrieve = orderPackageRetrieve.substringToIndex(orderPackageRetrieve.endIndex.predecessor())
            len = len-4
        }
        
        return cart
        
    }
    
    static func calcTotalPrice() -> Double {
        var totalPrice = 0.0
        var dishPrice = 0.0
        var price = 0.0
        
        let meals = NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.ArchiveURL.path!) as! [Meal]
        let loadData = NSUserDefaults().objectForKey("myShoppingCart") as? NSData
        let cart = (NSKeyedUnarchiver.unarchiveObjectWithData(loadData!) as? [Int:Int])!
        for (id, frequency) in cart {
            print("id \(id)")
            print("freq \(frequency)")
            
            for var i=0; i<meals.count; i++ {
                if(meals[i].id == id) {
                    price = Double(meals[i].price)
                }
            }
            dishPrice = price*Double(frequency)
            totalPrice = totalPrice+dishPrice
        }
        return totalPrice
    }
}
