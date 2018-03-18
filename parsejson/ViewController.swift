//
//  ViewController.swift
//  parsejson
//
//  Created by Chip on 3/9/18.
//  Copyright © 2018 TennisIQ. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    @IBOutlet var searchText: UISearchController!
    
    var tableArray = [String] ()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        parseJSON()
        
        
    }
    
    func parseJSON () {
        
        let url = URL(string: "https://api.github.com")
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error ) in

            
        guard error == nil else {
            print("returned error")
            return
        }

        guard let content = data else {
            print("No data")
            return
        }
            
            
        
        guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
            print("Not containing JSON")
            return
        }
            
            
            print(json)
   

        if let array = json["current_user_repositories_url"] as? [String] {
            self.tableArray = array
        } else {
            
            print("Json is not displaying")
            
            }
        
        print(self.tableArray)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        
        }

        task.resume()
    }
    
}

    extension ViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = self.tableArray[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.tableArray.count

        
        
    }
    
}

   



