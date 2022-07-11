//
//  Character.swift
//  DisneyTakeHome
//
//  Created by Rick W. on 7/4/22.
//

import Foundation

struct CharacterContainer: Codable {
  var data: CharacterData
}

struct CharacterData: Codable {
  var count: Int
  var results: [Character]
}

struct Character: Identifiable,Codable {
  var id: Int
  var name: String
  var description: String
  var thumbnail: [String:String]
  var urls: [[String: String]]
}




//Character {
//id (int, optional): The unique ID of the character resource.,
//name (string, optional): The name of the character.,
//description (string, optional): A short bio or description of the character.,
//modified (Date, optional): The date the resource was most recently modified.,
//resourceURI (string, optional): The canonical URL identifier for this resource.,
//urls (Array[Url], optional): A set of public web site URLs for the resource.,
//thumbnail (Image, optional): The representative image for this character.,
//comics (ComicList, optional): A resource list containing comics which feature this character.,
//stories (StoryList, optional): A resource list of stories in which this character appears.,
//events (EventList, optional): A resource list of events in which this character appears.,
//series (SeriesList, optional): A resource list of series in which this character appears.
//}
