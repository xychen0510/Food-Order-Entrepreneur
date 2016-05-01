//
//  MealTableViewCell.swift
//  UserLoginAndRegistration
//
//  Created by Chaoran Wang on 4/29/16.
//  Copyright © 2016 food. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

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

    @IBAction func plusButtonTapped(sender: UIButton) {
        let num = Int(number.text!)! + 1
        number.text = String(Int(num))
        dispatch_async(dispatch_get_main_queue(), {
            self.persistNum(num)
        })
    }
    
    @IBAction func minusButtonTapped(sender: UIButton) {
        
        var num = Int(number.text!)!
        num = num - 1
        
        
        //put on different thread, file access not blocking UI
        
            if(num <= 0)
            {
                num = 0
                number.text = String(Int(num))
                dispatch_async(dispatch_get_main_queue(), {
                    self.removeKeyValuePair()
                })

            }
            else {
                number.text = String(Int(num))
                dispatch_async(dispatch_get_main_queue(), {
                    self.persistNum(num)
                })
            }
    }
        /*var test = Utils.encoding()
        print(test)
        print("1")
        var test1 = Utils.decoding(test)
        print(test1)
        print("2")*/
    
    
    //Need optimization, can't do persistence everytime has a +
    func persistNum(num : Int){
        //print("start persist")
        
        let loadData = NSUserDefaults().objectForKey("myShoppingCart") as? NSData
        var cart = (NSKeyedUnarchiver.unarchiveObjectWithData(loadData!) as? [Int:Int])!
        
        cart[self.id] = num
        //print(id)
        //print(cart[10])
        
        let storeData = NSKeyedArchiver.archivedDataWithRootObject(cart)
        NSUserDefaults.standardUserDefaults().setObject(storeData, forKey:"myShoppingCart")
        NSUserDefaults().synchronize()
    }
    
    func removeKeyValuePair(){
        
        let loadData = NSUserDefaults().objectForKey("myShoppingCart") as? NSData
        var cart = (NSKeyedUnarchiver.unarchiveObjectWithData(loadData!) as? [Int:Int])!
        
        cart.removeValueForKey(self.id)
        
        let storeData = NSKeyedArchiver.archivedDataWithRootObject(cart)
        NSUserDefaults.standardUserDefaults().setObject(storeData, forKey:"myShoppingCart")
        NSUserDefaults().synchronize()
    }
}

