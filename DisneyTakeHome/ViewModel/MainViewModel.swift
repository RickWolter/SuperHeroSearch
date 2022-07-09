//
//  MainViewModel.swift
//  DisneyTakeHome
//
//  Created by Rick W. on 7/4/22.
//

import Foundation
import SwiftUI
import Combine

class MainViewModel: ObservableObject {
  
  @Published var fetchedCharacters: [Character]? = nil
  @Published var searchQuery = ""
  
  var searchCancellable: AnyCancellable? = nil
  
  init(){
    
    searchCancellable = $searchQuery
      .debounce(for: 0.4, scheduler: RunLoop.main)
      .sink(receiveValue: { str in
        
        if str == ""{
          self.fetchedCharacters = nil
        }
        else{
          self.fetchedCharacters = nil
          self.fetchCharacters()
        }
      })
  }
  
  func fetchCharacters(){
    
    let lettersToBeSearched = searchQuery.replacingOccurrences(of: " ", with: "%20")
    let publicKey = "bcef02a63819df04b8fa913013e4568a"
    //let privateKey = "5b53459fba33e82de4ae470a758d0a8ed3f2121c"
    //let hash = MD5(data: "\(ts)\(privateKey)\(publicKey)")
    //got this hash from online tool
    let MD5HashString = "016a43cf34bab3d9f1862138b005ca8b"
    let domain = "https://gateway.marvel.com:443/v1/public/"
    let charactersQuery = "characters?nameStartsWith="
    let ts = "1"
    
    let url = "\(domain)\(charactersQuery)\(lettersToBeSearched)&limit=100&ts=\(ts)&apikey=\(publicKey)&hash=\(MD5HashString)"
    
    URLSession.shared.dataTask(with: URL(string: url)!) { (data, _, err) in
      
      if let error = err{
        print(error.localizedDescription)
        return
      }
      
      guard let APIData = data else{
        print("no data found")
        return
      }
      
      do{
        
        let characters = try JSONDecoder().decode(CharacterContainer.self, from: APIData)
        
        DispatchQueue.main.async {
          
          if self.fetchedCharacters == nil{
            self.fetchedCharacters = characters.data.results
          }
        }
      }
      catch{
        print(error.localizedDescription)
      }
    }
    .resume()
  }
}
