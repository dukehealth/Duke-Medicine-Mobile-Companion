//
//  MCModalWebViewController.swift
//  Duke Medicine Mobile Companion
//
//  Created by Ricky Bloomfield on 6/29/14.
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

class MCModalWebViewController: UINavigationController {
    var webViewController: TOWebViewController = TOWebViewController()
    
    // With Swift, we now need to override all initializers used (i.e., they're not automatically assumed to exist from super)
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(address urlString: String!, tintColor: UIColor!) {
        self.init(URL: NSURL.URLWithString(urlString), tintColor: tintColor)
    }

    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    init(URL url: NSURL!, tintColor: UIColor!) {
        self.webViewController = TOWebViewController(URL: url)
        
        // Make all UIBarButtonItems have bold text (so Haiku/Canto button matches the 'Done' button)
        let barButtonAppearanceDict = [NSFontAttributeName : UIFont.boldSystemFontOfSize(17.0)]
        UIBarButtonItem.appearance().setTitleTextAttributes(barButtonAppearanceDict, forState: UIControlState.Normal)
        
        // Create Return button
        let title = "❮ \(HaikuOrCanto())"
        var returnButton: UIBarButtonItem = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.Plain, target: self.webViewController, action: Selector("returnToHaikuOrCanto"))
        
        // Show the Haiku or Canto button on the left if one or both are installed
        if HaikuOrCanto() != nil {
            self.webViewController.navigationItem.leftBarButtonItem = returnButton
        }
        
        // In Swift, we have to call super.init after we initialize (but before we call any class methods)
        super.init(rootViewController: self.webViewController)
        
        // Set color for UINavigationController navigationBar - any method called on 'self' must happen after super.init called
        self.view.tintColor = tintColor
    }
}

// Add required functionality to SVWebViewController via an extension (new to Swift)
extension TOWebViewController {
    
    /**
    Return to the appropriate app.  If on iPad, close the webview when leaving since there isn't a 'Done' button there
    */
    func returnToHaikuOrCanto() {
        if HaikuOrCanto() == "Haiku" {
            openHaiku()
            if IPAD() {
                dispatch_after(1, dispatch_get_main_queue(), {
                    self.dismissViewControllerAnimated(true, completion: nil)
                    })
            }
        } else if HaikuOrCanto() == "Canto" {
            openCanto()
            if IPAD() {
                dispatch_after(1, dispatch_get_main_queue(), {
                    self.dismissViewControllerAnimated(true, completion: nil)
                    })
            }
        }
    }
}