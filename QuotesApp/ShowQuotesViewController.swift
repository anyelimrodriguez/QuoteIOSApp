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
    @IBOutlet var authorLabel: UILabel!
    var currentAPIQuote = ShowQuoteResult()
    var currentQuote = ""
    var currentAuthor = ""
    
    var queryParam = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("QueryParam:\(queryParam)")
        
        getNewQuote()
        startQuotes()
        
        // Do any additional setup after loading the view.
    }
    
    //The first time the show quote screen opens
    func startQuotes(){
        quoteLabel.text = "It's okay to not be okay all the time."
    }
    
    // TODO: Possible delegate
    func sendShowTitleToShowQuotesScreen(showTitle: String) {
        self.queryParam = showTitle
        print("QueryParam:\(queryParam)")
    }
    
    // MARK: Retrieve Quotes Method
    @IBAction func getNewQuote(){
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
        if(currentAPIQuote.quote==nil||currentAPIQuote.quote=="")
        {
            print("EMPTY QUOTE")
        }
        else
        {
            //currentQuote = "\(currentAPIQuote.quote)"
            quoteLabel.text="\""+currentAPIQuote.quote!+"\""
            authorLabel.text="-"+currentAPIQuote.author!
            //print(currentAPIQuote[0].quote!)
        }
    }
    
    // MARK: - Helper Methods
    
    /*
     The URL for the API is the base endpoint /quote with the
     query parameter being the show the user selected from the table view
    */
    func apiURL() -> URL {
      let urlString = "https://web-series-quotes-api.deta.dev/quote/?series="+queryParam
      /*let urlString = String(
        format: "https://web-series-quotes-api.deta.dev/quote/?series=", queryParam)*/
      let url = URL(string: urlString)
      return url!
    }
    
    /*
     This function tries to perform the API request w/ the url from apiURL
    */
    
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
        return result[0].self //Response is an array with 1 showquoteresult obj inside
    } catch {
      print("JSON Error: \(error)")
      return nil }
  }
    
    // MARK: - Copy and Share Methods
    @IBAction func shareQuote(_ sender: UIBarButtonItem) {
        let text = quoteLabel.text
        let textShare = [text]
        let activityViewController = UIActivityViewController(activityItems: textShare as [Any] , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func copyQuote(sender: UIBarButtonItem){
        let text = quoteLabel.text
        UIPasteboard.general.string = text
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
