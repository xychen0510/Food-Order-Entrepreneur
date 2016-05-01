//
//  CartTableViewCell.swift
//  UserLoginAndRegistration
//
//  Created by Joe on 4/29/16.
//  Copyright © 2016 food. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    var id: Int!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var number: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
    
    @IBAction func minusButtonTapped(sender: UIButton) {
        var num = Int(number.text!)!
        if(num == 0) { removeKeyValuePair(); return }
        num = num - 1
        number.text = String(Int(num))
        persistNum(num)
        let total = Utils.calcTotalPrice()
        print("total\(total)")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.theViewController.totalPrice.text = "\(total)"
        
        /*var test = Utils.encoding()
         print(test)
         print("1")
         var test1 = Utils.decoding(test)
         print(test1)
         print("2")*/
    }

    
    
    @IBAction func plusButtonTapped(sender: UIButton) {
        let num = Int(number.text!)! + 1
        if num>=10 {
            let myAlert = UIAlertController(title: "Sorry", message: "Reach order maximum for a dish", preferredStyle: UIAlertControllerStyle.Alert);
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
            myAlert.addAction(okAction);
            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(myAlert, animated: true, completion: nil);
            return
        }
        number.text = String(Int(num))
        persistNum(num)
        print(Utils.calcTotalPrice())
    }
    
    
    
    
    
    
    
    /*@IBAction func plusButtonTapped(sender: UIButton) {
        let num = Int(number.text!)! + 1
        number.text = String(Int(num))
        persistNum(num)
    }
    
    @IBAction func minusButtonTapped(sender: UIButton) {
        
        var num = Int(number.text!)!
        if(num == 0) { removeKeyValuePair(); return }
        num = num - 1
        number.text = String(Int(num))
        persistNum(num)
        /*var test = Utils.encoding()
         print(test)
         print("1")
         var test1 = Utils.decoding(test)
         print(test1)
         print("2")*/
    }*/
    
    //Need optimization, can't do persistence everytime has a +
    func persistNum(num : Int){
        //print("start persist")
        
        let loadData = NSUserDefaults().objectForKey("myShoppingCart") as? NSData
        var cart = (NSKeyedUnarchiver.unarchiveObjectWithData(loadData!) as? [Int:Int])!
        
        cart[id] = num
        //print(id)
        //print(cart[10])
        
        let storeData = NSKeyedArchiver.archivedDataWithRootObject(cart)
        NSUserDefaults.standardUserDefaults().setObject(storeData, forKey:"myShoppingCart")
        NSUserDefaults().synchronize()
    }
    
    func removeKeyValuePair(){
        
        let loadData = NSUserDefaults().objectForKey("myShoppingCart") as? NSData
        var cart = (NSKeyedUnarchiver.unarchiveObjectWithData(loadData!) as? [Int:Int])!
        
        cart.removeValueForKey(id)
        
        let storeData = NSKeyedArchiver.archivedDataWithRootObject(cart)
        NSUserDefaults.standardUserDefaults().setObject(storeData, forKey:"myShoppingCart")
        NSUserDefaults().synchronize()
    }
}

