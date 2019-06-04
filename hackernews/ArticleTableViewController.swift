//
//  ArticleTableViewController.swift
//  hackernews
//
//  Created by Winker,Luke on 5/31/19.
//  Copyright © 2019 Winker,Luke. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController {

    // MARK: Properties
    var itemIds = [Int]()
    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Hacker News"
        print("View did load \(itemIds.count)")

        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        // Kick off API call
        getHackerNewsStories()
        // Async call return, when it returns the table view will update automatically.
    }
    
    @objc func refresh(sender: AnyObject) {
        getHackerNewsStories()
        items.removeAll()
        refreshControl?.endRefreshing()
        print("Refresh was called")
    }
    
    func getHackerNewsStories() {
        let jsonUrlTopStories = "https://hacker-news.firebaseio.com/v0/topstories.json?"
        guard let url = URL(string: jsonUrlTopStories) else { return }
        var localItemIds = [Int]()
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            var dataAsString = String(data: data, encoding: .utf8)
            //print(dataAsString!)
            dataAsString = dataAsString?.replacingOccurrences(of: "[", with: "")
            dataAsString = dataAsString?.replacingOccurrences(of: "]", with: "")
            
            var stringArray = dataAsString!.components(separatedBy: ",")
            
            // above works, but optimization would be to JSON parse
            var intArray = [Int]()
            for numberString in stringArray {
                intArray.append(Int(numberString)!)
            }
            self.itemIds = intArray
            localItemIds = intArray
            DispatchQueue.main.async{
                self.tableView.reloadData()
                self.getItems()
            }
            print("url sesh \(self.itemIds.count)")
            }.resume()
        
        print("num of rows \(itemIds.count)")
        
    }
    
    func getItems() {
        
        for id in self.itemIds {
            var itemFromId = "https://hacker-news.firebaseio.com/v0/item/\(id).json?"
            guard let url = URL(string: itemFromId) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard var data = data else { return }
                
                do {
                    var item = try JSONDecoder().decode(Item.self, from: data)
                    self.items.append(item)
                } catch {
                    print("Json decode error", err)
                }
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
            }.resume()
        }
    }

    // MARK: - Table view data source
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
        print(items.count)
        let item = items[indexPath.row]
        
        // Change data
        cell.titleTextView?.text = item.title
        cell.summaryLabel?.text = "\(item.score) points by \(item.by) | \(item.kids.count) comments"
        cell.timeLabel?.text = getMinutesAgo(item: item)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowWebViewSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! WebViewController
                controller.targetItem = items[indexPath.row]
            }
        }
    }
    
    // refresh
    
    
    
    //
    
    func getMinutesAgo(item: Item) -> String {
        let myDouble = Double(item.time)
        let pastDate = Date(timeIntervalSince1970: myDouble)
        return pastDate.timeAgoDisplay()
    }
 
    // Model Objects
    
   

}

extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        if secondsAgo < 60 {
            return "\(secondsAgo)s"
        } else if secondsAgo < 60 * 60 {
            return "\(secondsAgo / 60)m"
        } else if secondsAgo < 60 * 60 * 24 {
            return "\(secondsAgo / 60 / 60)h"
        }
        
        return "\(secondsAgo / 60 / 60 / 24) days"
    }
}
