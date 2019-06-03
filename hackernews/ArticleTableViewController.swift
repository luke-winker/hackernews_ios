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
    var items = [Item?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Hacker News"
        print("View did load \(itemIds.count)")
        
        // Kick off API call
        getHackerNewsStories()
        // Async call return, when it returns the table view will update automatically.
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
        cell.titleTextView?.text = item?.title
        cell.summaryLabel?.text = "\(item!.score) points by \(item!.by) | \(item!.kids.count) comments"
        cell.timeLabel?.text = "13m"
        return cell
    }
 
    // Model Objects
    
    struct Item: Decodable {
        var by: String
        var descendants: Int
        var id: Int
        var kids: [Int]
        var score: Int
        var time: Int
        var title: String
        var type: String
        var url: URL
    }
    
    struct IdArray {
        var ids: [Int]
    }

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
