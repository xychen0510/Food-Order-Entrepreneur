//
//  AppleProductsTableViewController.swift
//  Pretty Apple
//
//  Created by Duc Tran on 3/28/15.
//  Copyright (c) 2015 Duc Tran. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    var meals = [Meal]()
    
    var cart : [Int:Int] = [:]
    
    override func viewWillAppear(animated: Bool) {
        dispatch_async(dispatch_get_main_queue(), {
        
        // Load any saved meals, otherwise load sample data.
            if let savedMeals = self.loadMeals() {
                self.meals = savedMeals
            } else {
            // Load the sample data.
                self.loadSampleMeals()
            }
        
            //NSUserDefaults.standardUserDefaults().removeObjectForKey("myShoppingCart")
            let data = NSUserDefaults().objectForKey("myShoppingCart") as? NSData
        
        
            if(data == nil) {
                self.initializeShoppingCart()
            } else {
                self.cart = (NSKeyedUnarchiver.unarchiveObjectWithData(data!) as? [Int:Int])!
            }
        
            self.tableView.reloadData()
        })

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func initializeShoppingCart() {
        //using swift dictionary, hash table for shopping cart [id:num]
        let newCart : [Int:Int] = [:]
        let data = NSKeyedArchiver.archivedDataWithRootObject(newCart)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey:"myShoppingCart")
        NSUserDefaults().synchronize()
    }
    
    func loadSampleMeals() {
        var newMeals = [Meal]()
        newMeals = [Meal]()
        newMeals.append(Meal(id: 1, name: "苦瓜牛肉", price: 9.9, photo: UIImage(imageLiteral: "Image"))!)
        newMeals.append(Meal(id: 2, name: "凉拌三丝", price: 9.9, photo: UIImage(imageLiteral:"Image-2"))!)
        newMeals.append(Meal(id: 3, name: "四川凉面", price: 9.9, photo: UIImage(imageLiteral:"Image-1"))!)
        newMeals.append(Meal(id: 4, name: "手工大包子", price: 9.9, photo: UIImage(imageLiteral:"Image-3"))!)
        newMeals.append(Meal(id: 5, name: "炸酱面", price: 9.9, photo: UIImage(imageLiteral:"Image-4"))!)
        newMeals.append(Meal(id: 6, name: "羊肉烩面", price: 9.9, photo: UIImage(imageLiteral:"Image-5"))!)
        newMeals.append(Meal(id: 7, name: "羊肉泡馍", price: 9.9, photo: UIImage(imageLiteral:"Image-6"))!)
        newMeals.append(Meal(id: 8, name: "盐水鸭", price: 9.9, photo: UIImage(imageLiteral:"Image-7"))!)
        self.meals = newMeals
        saveMeals()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return meals.count
    }
    
    // indexPath: which section and which row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //self.tableView.bounces = true;
        let cell = tableView.dequeueReusableCellWithIdentifier("MealTableViewCell", forIndexPath: indexPath) as! MealTableViewCell
        
        let meal = meals[indexPath.row]
        cell.id = meal.id
        cell.name?.text = meal.name
        cell.photo.image = meal.photo
        cell.price?.text = "$" + String(meal.price)
        if(cart[meal.id] == nil) {
            cell.number?.text = String(0)
        } else {
            cell.number?.text = String(Int(cart[meal.id]!))
        }
        return cell
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    // MARK: NSCoding
    func saveMeals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(self.meals, toFile: Meal.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }
    
    func loadMeals() -> [Meal]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.ArchiveURL.path!) as? [Meal]
    }

    
}
