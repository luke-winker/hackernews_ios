//
//  WebViewController.swift
//  hackernews
//
//  Created by Winker,Luke on 6/3/19.
//  Copyright © 2019 Winker,Luke. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var targetItem: Item? = nil
    @IBOutlet weak var webView: WKWebView!
    
    func loadWebPage() {
        guard let urlString = targetItem?.url else { return }
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebPage()
        self.navigationItem.title = targetItem?.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let item = targetItem {
            self.navigationItem.title = "\(item.score) points"
            self.navigationItem.rightBarButtonItem?.title = "\(item.kids.count) comments"
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCommentsSegue" {
            let controller = segue.destination as! CommentsTableViewController
            controller.item = targetItem
        }
    }
}
