//
//  MCSettingsViewController.swift
//  Duke Medicine Mobile Companion
//
//  Created by Ricky Bloomfield on 6/15/14.
//  Copyright (c) 2014 Duke Medicine
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

class MCSettingsViewController: IASKAppSettingsViewController, IASKSettingsDelegate {
    
    override init() {
        super.init()
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nil)
    }
    
    override init(style: UITableViewStyle) {
        if style != UITableViewStyle.Grouped {
            println("Only UITableViewStyleGrouped style is supported, forcing it.")
        }
        
        super.init(style: style)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set self as delegate for IASK delegate methods
        delegate = self
        title = "Settings"
        
        // Run the function used to determine whether or not to show the "Return to:" option in Settings
        determineHiddenKeys()
    }
    
    // Remove appropriate settings depending whether Haiku and/or Canto are installed
    func determineHiddenKeys() {
        let HaikuInstalled = UIApplication.sharedApplication().canOpenURL(NSURL(string: "epichaiku://")!)
        let CantoInstalled = UIApplication.sharedApplication().canOpenURL(NSURL(string: "epiccanto://")!)
        
        var set = NSMutableSet()
        
        // Hide the "Return to" button if neither app is installed
        if !(HaikuInstalled && CantoInstalled) {
            set.addObject("returnTo")
        }
        
        // Hide the "Open Haiku" button if Haiku is not installed, otherwise, hide the "Download Haiku" button
        if !HaikuInstalled {
            set.addObject("openHaiku")
        } else {
            set.addObject("downloadHaiku")
        }
        
        // Hide the "Open Canto" button if Canto is not installed, otherwise, hide the "Download Canto" button
        if !CantoInstalled {
            set.addObject("openCanto")
        } else {
            set.addObject("downloadCanto")
        }
        
        // Hide both "Open Canto" and "Download Canto" if this is not an iPad
        if !IPAD() {
            set.addObject("openCanto")
            set.addObject("downloadCanto")
        }
        
        hiddenKeys = set
    }
    
    // Open a webview to the Duke Medicine home page
    func showDukeMedicine() {
        let webViewController = MCModalWebViewController(address: "http://www.dukemedicine.org", tintColor: DUKE_BLUE())
        webViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(webViewController, animated: true, completion: nil)
    }
    
    // Allow specific actions when tapping buttons
    func settingsViewController(sender: IASKAppSettingsViewController!, buttonTappedForSpecifier specifier: IASKSpecifier!) {
        if specifier.key() == "openCanto" {
            openCanto()
        } else if specifier.key() == "openHaiku" {
            openHaiku()
        } else if specifier.key() == "downloadCanto" {
            downloadCanto()
        } else if specifier.key() == "downloadHaiku" {
            downloadHaiku()
        } else if specifier.key() == "DukeMedicine" {
            showDukeMedicine()
        }
    }
    
    // This is a required delegate method
    func settingsViewControllerDidEnd(sender: IASKAppSettingsViewController!) {
        
    }
}
