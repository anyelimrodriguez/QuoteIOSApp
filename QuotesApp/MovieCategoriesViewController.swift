//
//  MovieCategoriesViewController.swift
//  QuotesIOSApp
//
//  Created by Anyeli on 11/14/22.
//

import UIKit

//TO-DO
protocol SendShowTitleDelegateProtocol {
    func sendShowTitleToShowQuotesScreen(showTitle: String)
}

class MovieCategoriesViewController: UITableViewController {
    var showTitles = [String]()
    var howManyTimesRun = 0
    
    var delegate: SendShowTitleDelegateProtocol? = nil //TO-DO
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getShowTitles()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table View Data Source
    /*
        This method creates the number of rows needed for the table
        1, if haven't retrieved the data from API
        len of showTitle array if have
     */
    override func tableView(
      _ tableView: UITableView,
      numberOfRowsInSection section: Int
    ) -> Int {
        if(showTitles.count>1){
            return showTitles.count //The len of the array is the amount of rows
        }
        return 1
    }
    
    /* This method is called to build each cell for every row needed*/
    override func tableView(
      _ tableView: UITableView,
      cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
        withIdentifier: "MovieCategory",
        for: indexPath)
        
        let label = cell.viewWithTag(1000) as! UILabel
        
        //If already retrieved the show titles, make the current cell display the current show title
        if(showTitles.count>0)
        {
            print(showTitles.count)
            let currentShowTitle = showTitles[indexPath.row]
            label.text = currentShowTitle.capitalized
            label.adjustsFontSizeToFitWidth = true
            label.font = UIFont.boldSystemFont(ofSize: 22)
            label.textColor = UIColor(red: 182/255, green: 47/255, blue: 54/255, alpha: 1)
        }
        
        //Otherwise, show a loading screen
        else
        {
            if indexPath.row == 0 {
              label.text = "Loading..."
            }
        }
        return cell
    }
    //TODO: Delegate implementation?
    override func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(self.delegate != nil) {
            let showTitleToSend = showTitles[indexPath.row]
            self.delegate?.sendShowTitleToShowQuotesScreen(showTitle: showTitleToSend)
            dismiss(animated: true, completion: nil)
        }
    }
    
    /*
     This method prepares the transition between this view controller and the show quotes
     view controller by sending the show title for the selected row to the show quotes
     view controller so that it can be used as the query parameter for the API call
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the row that was just tapped
        let indexPath = tableView.indexPathForSelectedRow
        let index = indexPath?.row
        
        // The destination view controller is the show quotes view controller
        let showQuotesViewController = segue.destination as! ShowQuotesViewController
        
        // Pass the query param (which is the show title at clicked index)
        if(!showTitles.isEmpty){
            showQuotesViewController.queryParam = showTitles[index ?? 0]
        }
        else{
            showQuotesViewController.queryParam = ""
        }
            
    }
    
    //MARK: API call
    func apiURL() -> URL {
      let urlString = String(
        format: "https://web-series-quotes-api.deta.dev/series")
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
    //JSON response is an array of strings
    func parse(data: Data) -> [String]? {
        do {
          let decoder = JSONDecoder()
          let result = try decoder.decode(
            [String].self, from: data)
            return result.self //.showTitlesArr
        } catch {
          print("JSON Error: \(error)")
          return []
        }
      }
    
    func getShowTitles(){
        let url = apiURL()
        print("URL: '\(url)'")
        
        // Get a shared instance which uses def config
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
                self.showTitles = parseData
              DispatchQueue.main.async {
                //self.isLoading = false
                self.tableView.reloadData()
              }
                //print(showTitles[0])
                return
            }
          } else {
            print("Failure! \(response!)")
          }
        }
        // 5
        dataTask.resume()
        if(showTitles.isEmpty)
        {
            print("Not Ready Yet")
        }
        else
        {
            //currentQuote = "\(currentAPIQuote.quote)"
            //quoteLabel.text="\""+currentAPIQuote.quote!+"\""
            //authorLabel.text="-"+currentAPIQuote.author!
            //viewDidLoad()
            tableView.reloadData()
            print(showTitles[0])
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
