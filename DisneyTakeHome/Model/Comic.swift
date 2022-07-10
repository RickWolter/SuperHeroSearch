//
//  Comic.swift
//  DisneyTakeHome
//
//  Created by Rick W. on 7/10/22.
//

import Foundation




import SwiftUI

struct ComicContainer: Codable {
    var data: ComicData
}

struct ComicData: Codable {
    var count: Int
    var results: [Comic]
}

struct Comic: Identifiable,Codable {
    var id: Int
    var title: String
    var description: String?
    var thumbnail: [String:String]
    var urls: [[String: String]]
}
