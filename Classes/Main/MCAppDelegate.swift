//
//  MCAppDelegate.swift
//  Duke Medicine Mobile Companion
//
//  Created by Ricky Bloomfield on 6/13/14.
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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UIAlertViewDelegate {
                            
    var window: UIWindow?
    var keyWindow: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        // Override point for customization after application launch.
        
        // Set user agent to iPad so the links always work
        let userAgentDict = [
            "UserAgent": "Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5355d Safari/8536.25"
            ]
        NSUserDefaults.standardUserDefaults().registerDefaults(userAgentDict)
        
        // Change global tint color
        window!.tintColor = DUKE_BLUE()
        
        // Initialize default settings
        registerDefaultsFromSettingsBundle()
        
        return true
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // Handle the URL scheme (dukemedmc://)
    func application(application: UIApplication!, openURL url: NSURL!, sourceApplication: String!, annotation: AnyObject!) -> Bool {
        
        // Check to see if a modal view controller is already being shown (and which one).  If it is, close it first, then open up the new one.
        var modalClassName = NSStringFromClass(window!.rootViewController?.presentedViewController?.classForCoder)
        if (modalClassName != nil) { // This will be 'nil' if there is not a showing modal view
            println("Modal view '\(modalClassName)' is now showing, so will close it.")
            window!.rootViewController?.presentedViewController?.dismissViewControllerAnimated(false, completion: {self.handleURL(url)})
        }
        
        else {
            // Loading the URL for the first time
            handleURL(url)
        }
        
        return true
    }
    
    func handleURL(url: NSURL) {
        if url.host == "uptodate" {
            let urlString = "http:/\(url.path!)?\(url.query!)"
            let webViewController = MCModalWebViewController(address: urlString, tintColor: UPTODATE_GREEN())
            webViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            window!.rootViewController?.presentViewController(webViewController, animated: true, completion: nil)
        }
        
        else if url.host == "bilitool" {
            let urlString = "http:/\(url.path!)?\(url.query!)"
            let webViewController = MCModalWebViewController(address: urlString, tintColor: BILITOOL_YELLOW())
            webViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            window!.rootViewController?.presentViewController(webViewController, animated: true, completion: nil)
        }
        
        else if url.host == "maps" {
            let mapsBaseURL = USER_DEFAULTS().objectForKey("mapsBaseURL") as String
            let urlString = "\(mapsBaseURL)?\(url.query!)"
            
            // If default Safari Google Maps is selected, will open the website in this app (because this allows the user to conveniently get back to Haiku), otherwise will push the user to the other native app
            if mapsBaseURL == "https://maps.google.com/maps" {
                let webViewController = MCModalWebViewController(address: urlString, tintColor: DUKE_BLUE())
                webViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
                window!.rootViewController?.presentViewController(webViewController, animated: true, completion: nil)
            } else {
                if UIApplication.sharedApplication().canOpenURL(NSURL .URLWithString(urlString)) {
                    // Detaching thread for this because UIApplication was having fits being called at the same time as the app was starting
                    NSThread.detachNewThreadSelector(Selector("openURLInBackground:"), toTarget: self, withObject: urlString)
                } else {
                // Display an alert if the users attempts to use an app that is not installed
                    let title = titleForValueInPlistNamed("Root", "mapsBaseURL", mapsBaseURL)
                    let alert = UIAlertView(title: "App Not Installed", message: "\(title) is not installed.  Please change your default maps app selection and try again.", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                }
            }
        }
        
        else {
            let alert = UIAlertView(title: "Whoops!", message: "The app did not understand that URL.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
    }
    
    // Detach thread for Maps URLs
    func openURLInBackground(urlString: String) {
        UIApplication.sharedApplication().openURL(NSURL.URLWithString(urlString))
    }
}