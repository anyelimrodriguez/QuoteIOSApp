//
//  TextColorViewController.swift
//  QuotesIOSApp
//
//  Created by Anyeli on 12/9/22.
//

import UIKit

class TextColorViewController: UIViewController {
    
    @IBOutlet var redTextLabel: UILabel!
    @IBOutlet var blueTextLabel: UILabel!
    @IBOutlet var yellowTextLabel: UILabel!
    @IBOutlet var greenTextLabel: UILabel!
    
    let defaults = UserPreferences.shared.defaults
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let txtColor = defaults.array(forKey: "QuotesTextColor")
        
        if(txtColor == nil){
            print("Text Color has not been set")
        } else{
            print("Text Color has been set before.")

        }

        // Do any additional setup after loading the view.
        let tappedRed = UITapGestureRecognizer(target: self, action: #selector(changeTextToRed))
            redTextLabel.isUserInteractionEnabled = true
            redTextLabel.addGestureRecognizer(tappedRed)
        let tappedBlue = UITapGestureRecognizer(target: self, action: #selector(changeTextToBlue))
            blueTextLabel.isUserInteractionEnabled = true
            blueTextLabel.addGestureRecognizer(tappedBlue)
        let tappedYellow = UITapGestureRecognizer(target: self, action: #selector(changeTextToYellow))
            yellowTextLabel.isUserInteractionEnabled = true
            yellowTextLabel.addGestureRecognizer(tappedYellow)
        let tappedGreen = UITapGestureRecognizer(target: self, action: #selector(changeTextToGreen))
            greenTextLabel.isUserInteractionEnabled = true
            greenTextLabel.addGestureRecognizer(tappedGreen)

       
    }
    
    @objc func changeTextToRed(sender: UITapGestureRecognizer){
        print("Tapped Red")
        //let defaults = UserDefaults.standard
        //defaults.set("", forKey: "QuotesTextColor")
        
        var txtColor = defaults.array(forKey: "QuotesTextColor")
        
        //Making an array with the digits for red color
        var redColor: [Double] = []
        redColor.append(207/255) //r
        redColor.append(84/255) //g
        redColor.append(77/255) //b
        
        /*print("RED COLOR IS")
        print("R \(redColor[0])")
        print("G \(redColor[1])")
        print("B \(redColor[2])")*/
        
        if(txtColor == nil){
            print("Text Color has not been set")
            
          //  print(txtColor![0])
           // print(txtColor![1])
           // print(txtColor![2])
            //print(redColor[0])
        } else{
            print("Text Color has been set before.")
            print("Current Color is:")
            print("R \(txtColor![0])")
            print("G \(txtColor![1])")
            print("B \(txtColor![2])")
            print("Just changed it to....")

        }
        
        defaults.set(redColor, forKey: "QuotesTextColor")
        txtColor = defaults.array(forKey: "QuotesTextColor")
        
        print("Current Text Color is:")
        print(txtColor![0])
        print(txtColor![1])
        print(txtColor![2])
        
        //label.textColor = UIColor(red: 182/255, green: 47/255, blue: 54/255, alpha: 1)
    }
    
    @objc func changeTextToBlue(sender: UITapGestureRecognizer){
        print("Tapped Blue")
        //let defaults = UserDefaults.standard
        //defaults.set("", forKey: "QuotesTextColor")
        
        //Making an array with the digits for blue color
        var blueColor: [Double] = []
        blueColor.append(93/255) //r
        blueColor.append(183/255) //g
        blueColor.append(222/255) //b
        
        /*print("BLUE COLOR IS")
        print("R \(blueColor[0])")
        print("G \(blueColor[1])")
        print("B \(blueColor[2])")*/
        
        //Getting the text color
        var txtColor = defaults.array(forKey: "QuotesTextColor")
        
        if(txtColor == nil){
            print("Text Color has not been set")
            
            //print(txtColor![0])
            //print(txtColor![1])
            //print(txtColor![2])
            //print(redColor[0])
        } else{
            print("Text Color has been set before.")
           /* print("Current Color is:")
            print("R \(txtColor![0])")
            print("G \(txtColor![1])")
            print("B \(txtColor![2])")
            print("Just changed it to....")*/

        }
        
        defaults.set(blueColor, forKey: "QuotesTextColor")
        txtColor = defaults.array(forKey: "QuotesTextColor")
        
        /*print("Current Text Color is:")
        print(txtColor![0])
        print(txtColor![1])
        print(txtColor![2])*/
        
        //label.textColor = UIColor(red: 182/255, green: 47/255, blue: 54/255, alpha: 1)
    }

    @objc func changeTextToYellow(sender: UITapGestureRecognizer){
        print("Tapped Yellow")
        //let defaults = UserDefaults.standard
        //defaults.set("", forKey: "QuotesTextColor")
        
        //Making an array with the digits for blue color
        var yellowColor: [Double] = []
        yellowColor.append(207/255) //r
        yellowColor.append(187/255) //g
        yellowColor.append(77/255) //b
        
        /*print("BLUE COLOR IS")
        print("R \(blueColor[0])")
        print("G \(blueColor[1])")
        print("B \(blueColor[2])")*/
        
        //Getting the text color
        var txtColor = defaults.array(forKey: "QuotesTextColor")
        
        if(txtColor == nil){
            print("Text Color has not been set")
        } else{
            print("Text Color has been set before.")

        }
        
        defaults.set(yellowColor, forKey: "QuotesTextColor")
        txtColor = defaults.array(forKey: "QuotesTextColor")
        
        /*print("Current Text Color is:")
        print(txtColor![0])
        print(txtColor![1])
        print(txtColor![2])*/
        
    }
    
    @objc func changeTextToGreen(sender: UITapGestureRecognizer){
        print("Tapped Green")
        //let defaults = UserDefaults.standard
        //defaults.set("", forKey: "QuotesTextColor")
        
        //Making an array with the digits for blue color
        var greenColor: [Double] = []
        greenColor.append(53/255) //r
        greenColor.append(187/255) //g
        greenColor.append(77/255) //b
        
        //Getting the text color
        var txtColor = defaults.array(forKey: "QuotesTextColor")
        
        if(txtColor == nil){
            print("Text Color has not been set")
        } else{
            print("Text Color has been set before.")

        }
        
        defaults.set(greenColor, forKey: "QuotesTextColor")
        txtColor = defaults.array(forKey: "QuotesTextColor")
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
