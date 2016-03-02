//
//  AddViewController.swift
//  firstToDoList
//
//  Created by Andrea Liu on 2/20/16.
//  Copyright © 2016 iOS Decal. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var taskNameTextField: UITextField! = UITextField()

    @IBOutlet weak var commentsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func doneButtonTapped(sender: AnyObject) {
        
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        var itemList:NSMutableArray? = userDefaults.objectForKey("itemList") as? NSMutableArray
        
        let dataSet:NSMutableDictionary = NSMutableDictionary()
        
        if let taskText = taskNameTextField.text where !taskText.isEmpty {
            dataSet.setObject(taskNameTextField.text!, forKey: "taskName")
            dataSet.setObject(commentsTextView.text, forKey: "taskComment")
            dataSet.setObject(false, forKey: "completed")
            dataSet.setObject(0, forKey: "hoursSinceCompleted")
        
        
            if ((itemList) != nil) { // data already available
                let newMutableList:NSMutableArray = NSMutableArray()
            
                for dict:AnyObject in itemList! {
                    newMutableList.addObject(dict as! NSDictionary)
                }
            
                userDefaults.removeObjectForKey("itemList")
                newMutableList.addObject(dataSet)
                userDefaults.setObject(newMutableList, forKey: "itemList")
            
            } else { // this is the first todo item in the list
                userDefaults.removeObjectForKey("itemList")
                itemList = NSMutableArray()
                itemList!.addObject(dataSet)
                userDefaults.setObject(itemList, forKey: "itemList")
            }
        }
        
        userDefaults.synchronize()
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
