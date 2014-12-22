//
//  MCHaikuOrCanto.swift
//  Duke Medicine Mobile Companion
//
//  Created by Ricky Bloomfield on 7/7/14.
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

import Foundation

/**
Opens the Canto app
*/
func openCanto() {
    UIApplication.sharedApplication().openURL(NSURL(string: "epiccanto://")!)
}

/**
Opens the Haiku app
*/
func openHaiku() {
    UIApplication.sharedApplication().openURL(NSURL(string: "epichaiku://")!)
}

/**
Opens the App Store to the Canto app
*/
func downloadCanto() {
    UIApplication.sharedApplication().openURL(NSURL(string: "itms-apps://itunes.apple.com/us/app/epic-canto/id395395172?mt=8")!)
}

/**
Opens the App Store to the Haiku app
*/
func downloadHaiku() {
    UIApplication.sharedApplication().openURL(NSURL(string: "itms-apps://itunes.apple.com/us/app/epic-haiku/id348308661?mt=8")!)
}

/**
Returns the string "Haiku" or "Canto" based on whether each is installed.  If on iPad and both are installed, returns the preference in settings
*/
func HaikuOrCanto() -> String! {
    let HaikuInstalled: Bool = UIApplication.sharedApplication().canOpenURL(NSURL(string: "epichaiku://")!)
    let CantoInstalled: Bool = UIApplication.sharedApplication().canOpenURL(NSURL(string: "epiccanto://")!)
    
    if IPAD() {
        if HaikuInstalled && CantoInstalled {
            return USER_DEFAULTS().objectForKey("returnTo") as String
        } else if (HaikuInstalled) {
            return "Haiku"
        } else if (CantoInstalled) {
            return "Canto"
        }
    } else if (HaikuInstalled) {
        return "Haiku"
    }
    
    return nil
}

/**
Opens the appropriate app based on app availability and preference (per HaikuOrCanto() function above)
*/
func openHaikuOrCanto() {
    if HaikuOrCanto()? == "Haiku" {openHaiku()}
    else if HaikuOrCanto()? == "Canto" {openCanto()}
}