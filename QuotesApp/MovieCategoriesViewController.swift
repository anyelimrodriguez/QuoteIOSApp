//
//  MovieCategoriesViewController.swift
//  QuotesIOSApp
//
//  Created by Anyeli on 11/14/22.
//

import UIKit

class MovieCategoriesViewController: UITableViewController {
    let row0text = "Walk the dog"
    let row1text = "Brush teeth"
    let row2text = "Learn iOS development"
    let row3text = "Soccer practice"
    let row4text = "Eat ice cream"
    
    var showTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getShowTitles()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    //override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
      //  return 0
   // }

    // MARK: - Table View Data Source
    override func tableView(
      _ tableView: UITableView,
      numberOfRowsInSection section: Int
    ) -> Int {
    return 9
    }
    
    override func tableView(
      _ tableView: UITableView,
      cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: "MovieCategory",
        for: indexPath)
      // Add the following code
      let label = cell.viewWithTag(1000) as! UILabel
      if indexPath.row == 0 {
        label.text = "Random Quote from Any"
      } else if indexPath.row == 1 {
        label.text = "Mindhunter"
      } else if indexPath.row == 2 {
        label.text = "True Detective"
      } else if indexPath.row == 3 {
        label.text = "Soprano"
      } else if indexPath.row == 4 {
        label.text = "The Wire"
      } else if indexPath.row == 5 {
          label.text = "Sillicon Valley"
      } else if indexPath.row == 6 {
          label.text = "The Office"
      } else if indexPath.row == 7 {
          label.text = "Space Force"
      } else if indexPath.row == 8 {
          label.text = "Forrest Gump"
      }
        
    return cell
        
    }
    
    
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
    
    /*@IBAction*/ func getShowTitles(){
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
                self.showTitles = parseData
              DispatchQueue.main.async {
                //self.isLoading = false
                //self.tableView.reloadData()
              }
            print(showTitles[0])
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
            print("EMPTY QUOTE")
        }
        else
        {
            //currentQuote = "\(currentAPIQuote.quote)"
            //quoteLabel.text="\""+currentAPIQuote.quote!+"\""
            //authorLabel.text="-"+currentAPIQuote.author!
            //viewDidLoad()
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
