//
//  ShowQuotesViewController.swift
//  QuotesIOSApp
//
//  Created by Anyeli on 12/5/22.
//

import UIKit

class ShowQuotesViewController: UIViewController {
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var quoteLabel: UILabel!

    var currentAPIQuote = ShowQuoteResult()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startQuotes()
        // Do any additional setup after loading the view.
    }
    
    //The first time the show quote screen opens
    func startQuotes(){
        quoteLabel.text = "It's okay to not be okay all the time."
    }
    
    @IBAction func getNewQuote(){
        //bool retrieved = true

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
            //Unwrap optional obj from data and turns response into show result object
            if let data = data {
                //if it fails to parse data, return
                guard let parseData = self.parse(data: data) else {return}
                self.currentAPIQuote = parseData
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
        if(currentAPIQuote.quote==nil)
        {
            print("EMPTY QUOTE")
        }
        else
        {
            quoteLabel.text=currentAPIQuote.quote
            //print(currentAPIQuote[0].quote!)
        }
    }
    
    // MARK: - Helper Methods
    func apiURL() -> URL {
      let urlString = String(
        format: "https://web-series-quotes-api.deta.dev/quote/?series=breaking_bad")
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
  //JSON response is an array w/ showquoteresult inside
  func parse(data: Data) -> ShowQuoteResult? {
    do {
      let decoder = JSONDecoder()
      let result = try decoder.decode(
        [ShowQuoteResult].self, from: data)
        return result[0].self //Response is an array with 1 showresult obj inside 
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
