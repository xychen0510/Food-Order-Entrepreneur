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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the sample data.
        loadSampleMeals()
    //NSUserDefaults.standardUserDefaults().removeObjectForKey("myShoppingCart")
        let data = NSUserDefaults().objectForKey("myShoppingCart") as? NSData

        
        if(data == nil) {
            initializeShoppingCart()
        } else {
            cart = (NSKeyedUnarchiver.unarchiveObjectWithData(data!) as? [Int:Int])!
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func initializeShoppingCart() {
        //using swift dictionary, hash table for shopping cart [id:num]
        for meal in meals {
            cart[meal.id] = 0
        }
        
        let data = NSKeyedArchiver.archivedDataWithRootObject(cart)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey:"myShoppingCart")
        NSUserDefaults().synchronize()
    }
    
    func loadSampleMeals() {
        meals = [Meal]()
        
        meals.append(Meal(id: 1, name: "苦瓜牛肉", price: "$9.9", photo: "Image"))
        meals.append(Meal(id: 2, name: "凉拌三丝", price: "$9.9", photo: "Image-2"))
        meals.append(Meal(id: 3, name: "四川凉面", price: "$9.9", photo: "Image-1"))
        meals.append(Meal(id: 4, name: "手工大包子", price: "$9.9", photo: "Image-3"))
        meals.append(Meal(id: 5, name: "炸酱面", price: "$9.9", photo: "Image-4"))
        meals.append(Meal(id: 6, name: "羊肉烩面", price: "$9.9", photo: "Image-5"))
        meals.append(Meal(id: 7, name: "羊肉泡馍", price: "$9.9", photo: "Image-6"))
        meals.append(Meal(id: 8, name: "盐水鸭", price: "$9.9", photo: "Image-7"))
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
        cell.price?.text = meal.price
        cell.number?.text = String(Int(cart[meal.id]!))
        return cell
    }
    
    override func viewDidAppear(animated: Bool) {
        
        /* Only need this if no navigation bar*/
        /*
        self.tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0)*/
        
        
        // login protected
        
        /*let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn");
        if (!isUserLoggedIn) {
            self.performSegueWithIdentifier("loginView", sender: self);
        }*/
    }
    
    /*@IBAction func LogoutButtonTapped(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn");
        NSUserDefaults.standardUserDefaults().synchronize();
        self.performSegueWithIdentifier("loginView", sender: self);
        
    }*/
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return NO if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return NO if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
}
