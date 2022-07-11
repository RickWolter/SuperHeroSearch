//
//  ComicSearchViewModel.swift
//  DisneyTakeHome
//
//  Created by Rick W. on 7/10/22.
//

import Foundation
import SwiftUI
import Combine

class ComicsViewModel: ObservableObject {
  
  @Published var fetchedComics: [Comic] = []
  @Published var offset: Int = 0
  
  init(){}
  
  func fetchComics(){
    
    let publicKey = "bcef02a63819df04b8fa913013e4568a"
    //let privateKey = "5b53459fba33e82de4ae470a758d0a8ed3f2121c"
    //let hash = MD5(data: "\(ts)\(privateKey)\(publicKey)")
    //got this hash from an online tool (although not techincally a hash)
    let MD5HashString = "016a43cf34bab3d9f1862138b005ca8b"
    let domain = "https://gateway.marvel.com:443/v1/public/"
    let ts = "1"
    let comicsQuery = "/comics?"
    let url = "\(domain)\(comicsQuery)&limit=50&&offset=\(offset)&ts=\(ts)&apikey=\(publicKey)&hash=\(MD5HashString)"
    
    let session = URLSession(configuration: .default)
    
    session.dataTask(with: URL(string: url)!) { (data, _, err) in
      
      if let error = err{
        print(error.localizedDescription)
        return
      }
      
      guard let data = data else{
        print("no data found")
        return
      }
      
      do{
        
        let comics = try JSONDecoder().decode(ComicContainer.self, from: data)
        
        DispatchQueue.main.async {
          
          self.fetchedComics.append(contentsOf: comics.data.results)
          
        }
      }
      catch{
        print(error.localizedDescription)
      }
    }
    .resume()
  } //fetch comics
}
