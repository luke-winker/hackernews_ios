//
//  File.swift
//  hackernews
//
//  Created by Winker,Luke on 5/31/19.
//  Copyright © 2019 Winker,Luke. All rights reserved.
//

import Foundation

struct Article: Codable {
    let id: Int
    let by: String
    let time: TimeInterval
    let text: String
    let title: String
    let url: URL
    let score: Int
    let descendents: Int
    
/*  init(json: [String: Any]) {
        id = json["id"] as? Int ?? -1
        by = json["by"] as? String ?? ""
        time = json["time"] as? TimeInterval ?? -1
        text = json["text"] as? String ?? ""
        title = json["title"] as? String ?? ""
        url = json["url"] as? URL ?? URL(string: "http://www.apple.com")!
        score = json["score"] as? Int ?? -1
        descendents = json["descendents"] as? Int ?? -1
    }*/
}
