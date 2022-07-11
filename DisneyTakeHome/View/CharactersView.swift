//
//  MainView.swift
//  DisneyTakeHome
//
//  Created by Rick W. on 7/4/22.
//

import SwiftUI

struct CharactersView: View {
  
  @EnvironmentObject var characterSearchViewModel: CharacterViewModel
  
  var body: some View {
    
    VStack {
      Text("Marvel Characters").foregroundColor(Color.red).font(.largeTitle).bold()
        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color.red), alignment: .top)
        .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color.red), alignment: .bottom)
        .cornerRadius(16)
        .padding()
        .accessibilityHint("A search bar allowing you to look up various marvel characters")
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
        
      }
      .cornerRadius(16)
      .padding()
      .background(Color(red: 237/255, green: 29/255, blue: 36/255))
      
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
      }.accessibilityLabel("A list of Characters is displayed here is you put in search terms.")
    } // VStack
    
    
  } // var Body
} // MainView Struct

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    CharactersView()
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




