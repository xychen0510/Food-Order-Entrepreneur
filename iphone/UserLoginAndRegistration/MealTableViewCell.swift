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
        persistNum(num)
    }
    
    @IBAction func minusButtonTapped(sender: UIButton) {
        
        var num = Int(number.text!)!
        if(num == 0) { removeKeyValuePair(); return }
        num = num - 1
        number.text = String(Int(num))
        persistNum(num)
    }
    
    //Need optimization, can't do persistence everytime has a +
    func persistNum(num : Int){
        
        let loadData = NSUserDefaults().objectForKey("myShoppingCart") as? NSData
        var cart = (NSKeyedUnarchiver.unarchiveObjectWithData(loadData!) as? [Int:Int])!
        
        cart[id] = num
        
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
