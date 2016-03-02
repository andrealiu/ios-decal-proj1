//
//  DetailViewController.swift
//  firstToDoList
//
//  Created by Andrea Liu on 2/23/16.
//  Copyright © 2016 iOS Decal. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var taskNameTextField: UITextField! = UITextField()
    
    @IBOutlet weak var taskCommentsTextView: UITextView! = UITextView()
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var toDoData:NSDictionary = NSDictionary()
    
    @IBOutlet weak var completeButton: UIButton!
    
    @IBOutlet weak var noteTitle: UILabel!
    
    var originalTaskName:String = ""
    
    var originalCommentsText:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskNameTextField.text! = toDoData.objectForKey("taskName") as! String
        
        taskCommentsTextView.text = toDoData.objectForKey("taskComment")as! String
        originalTaskName = taskNameTextField.text!
        originalCommentsText = taskCommentsTextView.text!

        if (toDoData.objectForKey("completed") as! Bool == true) {
            taskNameTextField.userInteractionEnabled = false
            taskCommentsTextView.userInteractionEnabled = false
            taskNameTextField.borderStyle = UITextBorderStyle.None
            saveButton.enabled = false
            completeButton.hidden = true
            if (taskCommentsTextView.text == "Add comments here...") {
                taskCommentsTextView.hidden = true
                noteTitle.hidden = true
            }
            
        }
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func completeButtonPressed(sender: AnyObject) {
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        let itemListArray:NSMutableArray = userDefaults.objectForKey("itemList") as! NSMutableArray
        
        var completeList:NSMutableArray? = userDefaults.objectForKey("completeList") as? NSMutableArray
        
        let mutableItemList:NSMutableArray = NSMutableArray()
        
        //mutableItemList.removeObject(toDoData)
        
        let completeData:NSMutableDictionary = NSMutableDictionary()
        
        completeData.setObject(toDoData.objectForKey("taskName") as! String, forKey: "taskName")
        completeData.setObject(toDoData.objectForKey("taskComment") as! String, forKey: "taskComment")
        completeData.setObject(true, forKey: "completed")
        completeData.setObject(0, forKey: "hoursSinceCompleted")
        
        for dict:AnyObject in itemListArray {
            if (dict.objectForKey("taskName") as! String == toDoData.objectForKey("taskName") as! String) {
                mutableItemList.addObject(completeData)
            } else {
                mutableItemList.addObject(dict as! NSDictionary)
            }
        }
        
        if ((completeList) != nil) {
            let newMutableCompleteList:NSMutableArray = NSMutableArray()
            
            for dict:AnyObject in completeList! {
                newMutableCompleteList.addObject(dict as! NSDictionary)
            }
            
            userDefaults.removeObjectForKey("completeList")
            newMutableCompleteList.addObject(completeData)
            userDefaults.setObject(newMutableCompleteList, forKey: "completeList")
        } else {
            userDefaults.removeObjectForKey("completeList")
            completeList = NSMutableArray()
            completeList!.addObject(completeData)
            userDefaults.setObject(completeList, forKey: "completeList")
        }
        
        //mutableItemList.addObject(completeData)
        
        userDefaults.removeObjectForKey("itemList")
        userDefaults.setObject(mutableItemList, forKey: "itemList")
        userDefaults.synchronize()

        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        var itemList:NSMutableArray? = userDefaults.objectForKey("itemList") as? NSMutableArray
        
        let dataSet:NSMutableDictionary = NSMutableDictionary()
        
        if let taskText = taskNameTextField.text where !taskText.isEmpty {
            dataSet.setObject(taskNameTextField.text!, forKey: "taskName")
            dataSet.setObject(taskCommentsTextView.text, forKey: "taskComment")
            dataSet.setObject(false, forKey: "completed")
            dataSet.setObject(0, forKey: "hoursSinceCompleted")
            
            
            if ((itemList) != nil) { // data already available
                let newMutableList:NSMutableArray = NSMutableArray()
                
                for dict:AnyObject in itemList! {
                    if (dict.objectForKey("taskName") as! String == originalTaskName) {
                        newMutableList.addObject(dataSet)
                    } else {
                    newMutableList.addObject(dict as! NSDictionary)
                    }
                }
                
                userDefaults.removeObjectForKey("itemList")
                //newMutableList.addObject(dataSet)
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
    @IBAction func deleteButtonpressed(sender: AnyObject) {
        /*let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        let itemListArray:NSMutableArray = userDefaults.objectForKey("itemList") as! NSMutableArray
        
        let mutableItemList:NSMutableArray = NSMutableArray()
        
        for dict:AnyObject in itemListArray {
            mutableItemList.addObject(dict as! NSDictionary)
        }
        
        //mutableItemList.removeObject(toDoData)
    
        
        userDefaults.removeObjectForKey("itemList")
        userDefaults.setObject(mutableItemList, forKey: "itemList")
        userDefaults.synchronize()
        self.dismissViewControllerAnimated(true, completion: nil)*/
        
    }*/
    @IBAction func cancelButtonPressed(sender: AnyObject) {
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
