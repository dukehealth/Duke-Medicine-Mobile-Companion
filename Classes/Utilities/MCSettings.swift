//
//  MCSettings.swift
//  Duke Medicine Mobile Companion
//
//  Created by Ricky Bloomfield on 6/12/14.
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
Runs the function below to register all the default values in Settings on the first run
*/
func registerDefaultsFromSettingsBundle() {
    USER_DEFAULTS().registerDefaults(defaultsFromPlistNamed("Root"))
    USER_DEFAULTS().synchronize()
}

/**
Iterates through the Settings plist to find default values, setting them if needed
*/
func defaultsFromPlistNamed(plistName: String) -> NSDictionary {
    let settingsBundlePath = NSBundle.mainBundle().bundlePath.stringByAppendingPathComponent("InAppSettings.bundle")
    let finalPath = settingsBundlePath.stringByAppendingPathComponent("\(plistName).plist")
    let settingsDict: NSDictionary = NSDictionary(contentsOfFile:finalPath)
    let prefSpecifierArray = settingsDict.objectForKey("PreferenceSpecifiers") as Array<NSDictionary>
    
    var defaults = NSMutableDictionary()    
    for prefSpecification in prefSpecifierArray {
        let key: String? = prefSpecification.objectForKey("Key") as? String
        let value: AnyObject? = prefSpecification.objectForKey("DefaultValue")
        if (key != nil && value != nil) {
            defaults.setObject(value!, forKey: key!)
        }
        
        let type: String? = prefSpecification.objectForKey("Type") as? String
        let viewControllerClass: String? = prefSpecification.objectForKey("IASKViewControllerClass") as? String
        if (type == "PSChildPaneSpecifier" && viewControllerClass == nil) {
            let file: String? = prefSpecification.objectForKey("File") as? String
            defaults.addEntriesFromDictionary(defaultsFromPlistNamed(file!))
        }
    }

    return defaults
}

/**
Accepts the name of the *.plist file, the key of the preference specifier and the value corresponding to the title in the PSMultiValueSpecifier.  'value' is only used if it's a PSMultiValueSpecifier.  If 'value' is 'nil' it will return the 'Title' for the key.
*/
func titleForValueInPlistNamed(plistName: String, key: String, value: String!) -> String {
    let settingsBundlePath = NSBundle.mainBundle().bundlePath.stringByAppendingPathComponent("InAppSettings.bundle")
    let finalPath = settingsBundlePath.stringByAppendingPathComponent("\(plistName).plist")
    let settingsDict: NSDictionary = NSDictionary(contentsOfFile:finalPath)
    let prefSpecifierArray = settingsDict.objectForKey("PreferenceSpecifiers") as Array<NSDictionary>
    
    for prefSpecification in prefSpecifierArray {
        let plistKey: String? = prefSpecification.objectForKey("Key") as? String
        if key == plistKey {
            
            // If 'value' is present, this means it's a PSMultiValueSpecifier
            if (value != nil) {
                let titles: NSArray = prefSpecification.objectForKey("Titles") as NSArray
                let values: NSArray = prefSpecification.objectForKey("Values") as NSArray
                let index = values.indexOfObject(value)
                if index > -1 {
                    return titles.objectAtIndex(index) as String
                }
            }
            
            // Otherwise, we just need to get the regular title for the key
            else {
                return prefSpecification.objectForKey("Title") as String
            }
        }
    }
    
    return "Title"
}