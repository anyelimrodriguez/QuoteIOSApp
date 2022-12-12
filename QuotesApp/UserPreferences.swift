//
//  UserPreferences.swift
//  QuotesIOSApp
//
//  Created by Anyeli on 12/9/22.
//

import Foundation
import UIKit
/*class UserPreferences
{
    //make it private
    //hide init -> private init
    //have methods 
    let defaults = UserDefaults.standard
  
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
}*/

class UserPreferences
{
    //make it private
    //hide init -> private init
    //have methods
    private let defaults = UserDefaults.standard
  
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
    
    func getQuoteTextColor()->[Any]?{
        var txtColor = defaults.array(forKey: "QuotesTextColor")
        if(txtColor != nil){
            print("UserPref -> Text Color has been set")
            print(txtColor![0])
            print(txtColor![1])
            print(txtColor![2])

        } else{
            print("UserPref -> Text Color has not been set")
            //Making an array with the digits for red color
            var redColor: [Double] = []
            redColor.append(207/255) //r
            redColor.append(84/255) //g
            redColor.append(77/255) //b
            
            defaults.set(redColor, forKey: "QuotesTextColor")
            txtColor = defaults.array(forKey: "QuotesTextColor")
            
            print(txtColor![0])
            print(txtColor![1])
            print(txtColor![2])
            //print(redColor[0])
        }
        //return defaults.array(forKey: "QuoteTextColor")
        return txtColor
    }
    
    func setQuoteTextColor(color: [Double]){
        defaults.set(color, forKey: "QuotesTextColor")
    }
  
    //This makes this class accessible to all files in quotesapp folder
    class var shared: UserPreferences {
        struct Static {
            static let instance = UserPreferences()
        }
        return Static.instance
    }
}
