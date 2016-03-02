//
//  WelcomeScreenViewController.swift
//  firstToDoList
//
//  Created by Andrea Liu on 2/29/16.
//  Copyright © 2016 iOS Decal. All rights reserved.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
    
    var timer:NSTimer = NSTimer()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        timer = NSTimer.scheduledTimerWithTimeInterval(3600.0, target: self, selector: "addHourToTaskHourCount", userInfo: nil, repeats: true)
    }
    
    func addHourToTaskHourCount() {
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let completeList:NSMutableArray? = userDefaults.objectForKey("completeList") as? NSMutableArray
        let itemListArray:NSMutableArray? = userDefaults.objectForKey("itemList") as? NSMutableArray
        let mutableItemList:NSMutableArray = NSMutableArray()
        
        if ((itemListArray) != nil) {
            for dict:AnyObject in itemListArray! {
                /*let hoursSinceDictObjectCompleted = dict.objectForKey("hoursSinceCompleted") as! Int
                
                if (!(hoursSinceDictObjectCompleted + 1 == 2)) {
                    mutableItemList.addObject(dict as! NSDictionary)
                } */
                mutableItemList.addObject(dict as! NSDictionary)
            }
        }
        
        if ((completeList) != nil) {
            let newMutableCompleteList:NSMutableArray = NSMutableArray()
            
            for dict:AnyObject in completeList! {
                let dictObject = dict as! NSDictionary
                let dictObjectCompleted = dict.objectForKey("completed") as! Bool
                let newUpdatedHoursObject = NSMutableDictionary()
                let hoursSinceDictObjectCompleted = dict.objectForKey("hoursSinceCompleted") as! Int
                
                newUpdatedHoursObject.setObject(dictObject.objectForKey("taskName") as! String, forKey: "taskName")
                newUpdatedHoursObject.setObject(dictObject.objectForKey("taskComment") as! String, forKey: "taskComment")
                newUpdatedHoursObject.setObject(dictObjectCompleted, forKey: "completed")
                if (!(hoursSinceDictObjectCompleted + 1 == 24)) {
                    if (dictObjectCompleted) {
                        newUpdatedHoursObject.setObject(hoursSinceDictObjectCompleted + 1, forKey: "hoursSinceCompleted")
                    } else {
                        newUpdatedHoursObject.setObject(dictObject.objectForKey("hoursSinceCompleted") as! Int, forKey: "hoursSinceCompleted")
                    }
                    newMutableCompleteList.addObject(newUpdatedHoursObject)
                } else {
                    newUpdatedHoursObject.setObject(0, forKey: "hoursSinceCompleted")
                    mutableItemList.removeObject(newUpdatedHoursObject)
                }
            }
            print(mutableItemList)
            print(newMutableCompleteList)
            userDefaults.removeObjectForKey("completeList")
            userDefaults.setObject(newMutableCompleteList, forKey: "completeList")
            userDefaults.removeObjectForKey("itemList")
            userDefaults.setObject(mutableItemList, forKey: "itemList")
            userDefaults.synchronize()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
