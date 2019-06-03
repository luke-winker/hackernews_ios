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

    @IBOutlet weak var webView: WKWebView!
    var targetString: String?
    
    override func loadView() {
        if let test = targetString, let url = URL(string: test) {

            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
