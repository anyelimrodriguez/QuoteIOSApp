//
//  UserPreferences.swift
//  QuotesIOSApp
//
//  Created by Anyeli on 12/9/22.
//

import Foundation
class UserPreferences
{
    let defaults = UserDefaults.standard
  
    //private let keyIntExample = "intExample"
  
    /*var QuoteTxtColor = {
        set {
            let redColor = [207/255, 84/255, 77/255]
            //defaults.set(redColor, forKey: "QuotesTextColor")
            defaults.setValue(redColor, forKey: "QuoteTextColor")
        }
        get {
            return defaults.array(forKey: "QuoteTextColor")
        }
    }*/
  
    //This makes this class accessible to all files in quotesapp folder
    class var shared: UserPreferences {
        struct Static {
            static let instance = UserPreferences()
        }
        return Static.instance
    }
}
