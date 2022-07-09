//
//  ContentView.swift
//  SwiftUITest_Image
//
//  Created by Rick W. on 7/7/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      
      
      
      ScrollView {
      HStack {
        AsyncImage(url: URL(string: "https://example.com/icon.png"))
            .frame(width: 200, height: 200)
        AsyncImage(url: URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg"))  { image in
          image.resizable()
      } placeholder: {
          ProgressView()
      }
      .frame(width: 100, height: 100)
//      Image(systemName: "placeholder image")
//      .data(url: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")!)
    }
      }
    }
  
  
  
  
  func makeURL(data: [String:String])->URL{
    let path = data["path"] ?? ""
    let ext = data["extension"] ?? ""
      
      
    return URL(string: "\(path).\(ext)")!
    
    
    
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




extension Image {

func data(url:URL) -> Self {

if let data = try? Data(contentsOf: url) {

return Image(uiImage: UIImage(data: data)!)

.resizable()

}

return self
.resizable()

}

}
