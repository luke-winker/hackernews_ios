//
//  Model.swift
//  hackernews
//
//  Created by Winker,Luke on 6/3/19.
//  Copyright © 2019 Winker,Luke. All rights reserved.
//

import Foundation


struct Item: Decodable {
    var by: String
    var descendants: Int
    var id: Int
    var kids: [Int]
    var score: Int
    var time: Int
    var title: String
    var type: String
    var url: String
}

struct IdArray {
    var ids: [Int]
}
