//
//  StatsViewController.swift
//  firstToDoList
//
//  Created by Andrea Liu on 2/20/16.
//  Copyright © 2016 iOS Decal. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    var completedItems:NSMutableArray = NSMutableArray();
    
    @IBOutlet weak var numTasksCompletedIn24Hours: UILabel!

    @IBOutlet weak var clearButton: UIButton!
    
    override func viewDidAppear(animated: Bool) {
        
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        let completedListFromUserDefaults:NSMutableArray? = userDefaults.objectForKey("completeList") as? NSMutableArray
        
        if ((completedListFromUserDefaults != nil)) {
            completedItems = completedListFromUserDefaults!
        }
        
        numTasksCompletedIn24Hours.text = String(completedItems.count)
        
        if (completedItems.count == 0) {
            clearButton.hidden = true
        } else {
            clearButton.hidden = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        clearButton.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clearButtonPressed(sender: AnyObject) {
        
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        let emptyCompletedItems:NSMutableArray = NSMutableArray()
        
        userDefaults.removeObjectForKey("completeList")
        userDefaults.setObject(emptyCompletedItems, forKey: "completeList")
        userDefaults.synchronize()
        numTasksCompletedIn24Hours.text = "0"
        clearButton.hidden = true
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
