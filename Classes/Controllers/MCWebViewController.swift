//
//  MCWebViewController.swift
//  Maestro Care Mobile Companion
//
//  Created by Ricky Bloomfield on 6/25/14.
//  Copyright (c) 2014 Duke Medicine. All rights reserved.
//

import UIKit

class MCWebViewController: UIViewController, UIAlertViewDelegate {

    /*var webViewController: SVWebViewController?
    var barsTintColor: UIColor?
    var viewTintColor: UIColor?
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init(address urlString: String!, andTintColor color: UIColor!) {
        let url: NSURL = NSURL.URLWithString(urlString)
        self.webViewController = SVWebViewController(URL: url)
        super.init(rootViewController: self.webViewController)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self.webViewController, action: Selector("doneButtonClicked:"))
        
        self.viewTintColor = color
        
        // Make all UIBarButtonItems have bold text (so Haiku/Canto button matches the 'Done' button)
        let barButtonAppearanceDict = [NSFontAttributeName : UIFont.boldSystemFontOfSize(17.0)]
        UIBarButtonItem.appearance().setTitleTextAttributes(barButtonAppearanceDict, forState: UIControlState.Normal)
        
        let title = "❮ \(HaikuOrCanto)"
        var returnButton: UIBarButtonItem?
        
        if IPAD() {
            returnButton = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.Plain, target: self, action: Selector("touchesBegan:withEvent:"))
        } else {
            returnButton = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.Plain, target: self, action: Selector("returnToHaikuCanto"))
        }
        
        if IPAD() {
            self.navigationItem.leftBarButtonItem = returnButton
        } else {
            self.navigationItem.rightBarButtonItem = doneButton
            print("Done button added")
            
            // Show the Haiku/Canto button on if one or both are installed
            if self.HaikuOrCanto() != nil {
                self.navigationItem.leftBarButtonItem = returnButton
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //self.webViewController!.title = self.title;
        self.navigationBar.tintColor = self.viewTintColor;
    }*/
    
    
}