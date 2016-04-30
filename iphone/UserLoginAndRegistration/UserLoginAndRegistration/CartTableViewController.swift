//
//  CartTableViewController.swift
//  UserLoginAndRegistration
//
//  Created by Chaoran Wang on 4/29/16.
//  Copyright © 2016 food. All rights reserved.
//

import UIKit

class CartTableViewController: UITableViewController {

    var meals = [Meal]()
    
    var cart : [Int:Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        //NSUserDefaults.standardUserDefaults().removeObjectForKey("myShoppingCart")
        let data = NSUserDefaults().objectForKey("myShoppingCart") as? NSData
        
        if(data == nil) {
            //no sopping cart information available
        } else {
            cart = (NSKeyedUnarchiver.unarchiveObjectWithData(data!) as? [Int:Int])!
        }
        
        // Load any saved meals, otherwise load sample data.
        loadMeals()
    }
    
    func loadMeals() {
        meals = NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.ArchiveURL.path!) as! [Meal]
        for var i = 0; i < meals.count; i++ {
            if(cart[meals[i].id] == nil) {
                meals.removeAtIndex(i);
                i--;
            }
        }
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    
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
        cell.photo?.image = meal.photo
        cell.price?.text = "$" + String(meal.price)
        if(cart[meal.id] == nil) {
            cell.number?.text = String(0)
        } else {
            cell.number?.text = String(Int(cart[meal.id]!))
        }
        return cell
    }

}
