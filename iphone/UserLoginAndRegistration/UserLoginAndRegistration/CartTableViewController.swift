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
    
    @IBOutlet weak var totalPrice: UILabel!
    /*This method will run everytime user make the view appear*/
    override func viewWillAppear(animated: Bool) {
        
        dispatch_async(dispatch_get_main_queue(), {
            //NSUserDefaults.standardUserDefaults().removeObjectForKey("myShoppingCart")
            let data = NSUserDefaults().objectForKey("myShoppingCart") as? NSData
            
            if(data == nil) {
                //no shopping cart information available
            } else {
                self.cart = (NSKeyedUnarchiver.unarchiveObjectWithData(data!) as? [Int:Int])!
            }
            
            // Load any saved meals, otherwise load sample data.
            self.loadMeals()
            self.tableView.reloadData()
            self.totalPrice.text =  "Total Price: " + String(Utils.calcTotalPrice())
        })
    }
    
    /*This method only run once*/
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.cartTableViewControllerRef = self
    }

    /* note that this method is running on a thread, after newMeal calculation must assign back to self*/
    func loadMeals() {
        var newMeals = [Meal]()
        newMeals = NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.ArchiveURL.path!) as! [Meal]
        for var i = 0; i < newMeals.count; i++ {
            if(self.cart[newMeals[i].id] == nil) {
                newMeals.removeAtIndex(i);
                i--;
            }
        }
        self.meals = newMeals
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
        let cell = tableView.dequeueReusableCellWithIdentifier("CartTableViewCell", forIndexPath: indexPath) as! CartTableViewCell
        
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
