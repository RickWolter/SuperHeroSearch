//
//  MainView.swift
//  DisneyTakeHome
//
//  Created by Rick W. on 7/4/22.
//

import SwiftUI

struct CharacterSearchView: View {
  
  @EnvironmentObject var characterSearchViewModel: CharacterSearchViewModel
  
  
    var body: some View {
      
      
      
      VStack {
      
              VStack(spacing: 15){

                  // Search Bar...
                  HStack(spacing: 10){

                      Image(systemName: "magnifyingglass")
                          .foregroundColor(.black)

                      TextField("Search Character", text: $characterSearchViewModel.searchQuery)
                          .autocapitalization(.none)
                          .disableAutocorrection(true)
                          .foregroundColor(.black)
                  }
                  .cornerRadius(16)
                  .padding(.vertical,10)
                  .padding(.horizontal)
                  .background(Color.white)
                  // Shadows..
                  .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                  .shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5)

              }
              .cornerRadius(16)
              .padding()
              .background(Color(red: 237/255, green: 29/255, blue: 36/255))
             
        
        
        
        // start scroll
      
      ScrollView {
            if let characters = characterSearchViewModel.fetchedCharacters {
                  
                  if characters.isEmpty{
                
                      Text("No Results Found")
                          .padding(.top,20)
                  }
                  else {
                      
                      ForEach(characters){characterData in
                          
                          CharacterRowView(character: characterData)
                      }
                  }
              }
              else{

                  if characterSearchViewModel.searchQuery != ""{
                      ProgressView()
                          .padding(.top,40)
                  }
              }
  }
    } // VStack
  
} // var Body
} // MainView Struct

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterSearchView()
    }
}



struct CharacterRowView: View {
    
    var character: Character
    
    var body: some View {
        
    
            VStack(alignment: .leading, content: {
  
              HStack() {
                
                AsyncImage(url: URL(string: makeURLString(data: character.thumbnail)))  { image in
                  image.resizable()
              } placeholder: {
                  ProgressView()
              }
              .frame(width: 75, height: 75)
                  
                Text(character.name)
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
              }

                Text(character.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                   // .lineLimit(4)
                    .multilineTextAlignment(.leading)
              })
            
    }

  func makeURLString(data: [String:String])->String{
    let path = data["path"] ?? ""
    let ext = data["extension"] ?? ""
      
    let http = "\(path).\(ext)"
    let https = "https" + http.dropFirst(4)
    
    return String( https)
  }
}




