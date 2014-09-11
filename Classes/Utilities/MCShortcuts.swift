//
//  MCShortcuts.swift
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
Shortcut to return appropriate standard user defaults
*/
func USER_DEFAULTS() -> NSUserDefaults  {
    return NSUserDefaults.standardUserDefaults()
}

/**
Shortcut to return the info dictionary
*/
func MAIN_INFO_DICTIONARY() -> NSDictionary {
    return NSBundle.mainBundle().infoDictionary
}

/**
Shortcut to return the short version string
*/
func BUNDLE_VERSION() -> NSString {
    return MAIN_INFO_DICTIONARY().objectForKey("CFBundleShortVersionString") as NSString
}

/**
Shortcut that returns 'true' if the current device is an iPad and 'false' if not
*/
func IPAD() -> Bool {
    return UIDevice.currentDevice().userInterfaceIdiom == .Pad ? true : false
}