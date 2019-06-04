
//
//  CommentsTableViewController.swift
//  hackernews
//
//  Created by Winker,Luke on 6/4/19.
//  Copyright © 2019 Winker,Luke. All rights reserved.
//

import UIKit

class CommentsTableViewController: UITableViewController {

    var item: Item? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        var myItem = item
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
        cell.commentTextView.text = "\(item!.kids.count)"
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
}
