//
//  RandomAdviceViewController.swift
//  QuotesIOSApp
//
//  Created by Anyeli on 11/21/22.
//

import UIKit

class RandomAdviceViewController: UIViewController {
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var adviceLabel: UILabel!
    //@IBOutlet var shareButton: UIBarButtonItem!
    
    var currentAdvice = ""
    var randomVal = 0
    var currentAPIAdvice = AdviceResult()
    var advice = ["Listen to Bad Bunny.", "Dreams remain dreams until you take action.", "When you quit, you fail.", "Everything not saved will be lost.", "If you do something bad, make sure your sibling is around to blame.", "Trust dogs. They always know who to stay away from.","When in doubt, always ask your mother.",
        "Never break two laws at the same time because that’s how you get caught.","If you sleep until lunchtime, you can save your breakfast money.","If you’re gonna break the rules, only break one rule at a time.","Have more than you show, speak less than you know", "You can measure a person’s soul by how they treat service staff.", "If they talk shit about others to you, they’re probably talking shit about you to others. Stay away.", "Don’t shoot down an idea you can’t improve upon."]
    var adviceResults = [AdviceResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAdvice()
        // Do any additional setup after loading the view.
    }
    
    //The first time the advice screen opens
    func startAdvice(){
        adviceLabel.text = "It's okay to not be okay all the time."
    }
    
    /*func updateAdvice(){
        randomVal = Int.random(in: 0...advice.count-1)
        adviceLabel.text = advice[randomVal]
    }*/
    
    @IBAction func getNewAdvice(){
        //bool retrieved = true
        //When there's an error w/ API call, call from my own advice array
       // randomVal = Int.random(in: 0...advice.count-1)
       // adviceLabel.text = advice[randomVal]
        
        let url = apiURL()
        print("URL: '\(url)'")
        
        // Get a shared isntance which uses def config
        let session = URLSession.shared
        
        // data tasks are for fetching the contents of a given URL
        let dataTask = session.dataTask(with: url) { [self]data, response,
        error in // errors can happen when server can't be reached
          if let error = error {
            print("Failure! \(error.localizedDescription)")
          } else if let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200 { //HTTP responsse code 200 means success
            print("SUCCESS")
            //Unwrap optional obj from data and turns dic's contents in advice object
            if let data = data {
                //if it fails to parse data, return
                guard let parseData = self.parse(data: data) else {return}
                self.currentAPIAdvice = parseData
              //self.searchResults.sort(by: <)
              DispatchQueue.main.async {
                //self.isLoading = false
                //self.tableView.reloadData()
              }
                
              return
            }
          } else {
            print("Failure! \(response!)")
          }
        }
        // 5
        dataTask.resume()
        if(currentAPIAdvice.advice=="")
        {
            randomVal = Int.random(in: 0...advice.count-1)
            adviceLabel.text = advice[randomVal]
        }
        else
        {
            adviceLabel.text=currentAPIAdvice.advice!
            print(currentAPIAdvice.advice!)
        }
    }
    
    /*This method allows user to share the text in advice label using the activity view controller.
     ActivityView controller is the pop up that gives you options to share
    */
    @IBAction func shareText(_ sender: UIBarButtonItem) {
        let text = adviceLabel.text
        let textShare = [text]
        let activityViewController = UIActivityViewController(activityItems: textShare as [Any] , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func copyText(sender: UIBarButtonItem){
        let text = adviceLabel.text
        UIPasteboard.general.string = text
    }
    
    // MARK: - Helper Methods
    func apiURL() -> URL {
      let urlString = String(
        format: "https://api.adviceslip.com/advice")
      let url = URL(string: urlString)
      return url!
    }
    
    func performAPIRequest(with url: URL) -> Data? {
      do {
       return try Data(contentsOf: url)
      } catch {
       print("Download Error: \(error.localizedDescription)")
    return nil
        }
    }
    
  func parse(data: Data) -> AdviceResult? {
    do {
      let decoder = JSONDecoder()
      let result = try decoder.decode(
        ResultSlip.self, from: data)
        return result.slip
    } catch {
      print("JSON Error: \(error)")
      return nil }
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
