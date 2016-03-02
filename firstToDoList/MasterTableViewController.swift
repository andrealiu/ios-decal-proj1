//
//  MasterTableViewController.swift
//  firstToDoList
//
//  Created by Andrea Liu on 2/20/16.
//  Copyright © 2016 iOS Decal. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController {
    
    var toDoItems:NSMutableArray = NSMutableArray();
    
    override func viewDidAppear(animated: Bool) {
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        let itemListFromUserDefaults:NSMutableArray? = userDefaults.objectForKey("itemList") as? NSMutableArray
        
        if ((itemListFromUserDefaults) != nil) {
            toDoItems = itemListFromUserDefaults!
        }
        
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDoItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        
        let toDoItem:NSDictionary = toDoItems.objectAtIndex(indexPath.row) as! NSDictionary
        cell.textLabel?.text = toDoItem.objectForKey("taskName") as? String
        let completed:Bool = (toDoItem.objectForKey("completed") as? Bool)!
        if (completed) {
            cell.backgroundColor = UIColor(red: 216/255, green: 227/255, blue: 220/255, alpha: 1.0)
            //UITableViewCell.appearance().backgroundColor = UIColor.greenColor()
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.backgroundColor = UIColor.whiteColor()
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        return cell
    }
    
    
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            let mutableItemList:NSMutableArray = NSMutableArray()
            
            for dict:AnyObject in toDoItems {
                mutableItemList.addObject(dict as! NSDictionary)
            }
            
            mutableItemList.removeObjectAtIndex(indexPath.row)
            
            userDefaults.removeObjectForKey("itemList")
            userDefaults.setObject(mutableItemList, forKey: "itemList")
            userDefaults.synchronize()
            
            toDoItems = mutableItemList

            //toDoItems.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "showTaskDetail") {
            let selectedIndexPath:NSIndexPath = self.tableView.indexPathForSelectedRow!
            let nav = segue.destinationViewController as! UINavigationController
            let detailViewController:DetailViewController = nav.topViewController as! DetailViewController
            detailViewController.toDoData = toDoItems.objectAtIndex(selectedIndexPath.row)as! NSDictionary
        }
    }
    

}
