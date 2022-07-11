//
//  ComicSearchView.swift
//  DisneyTakeHome
//
//  Created by Rick W. on 7/10/22.
//

import SwiftUI
import Combine

struct ComicsView: View {
  
  @EnvironmentObject var comicViewModel: ComicsViewModel
  
  var body: some View {
    
    
    VStack {
      VStack {
        Text("Marvel Comics").foregroundColor(Color.red).font(.largeTitle).bold()
          .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color.red), alignment: .top)
          .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color.red), alignment: .bottom)
          .cornerRadius(16)
          .padding()
          .accessibilityIdentifier("Marvel Comics")
        
        ScrollView {
          
          
          if comicViewModel.fetchedComics.isEmpty{
            
            ProgressView()
              .padding(.top,30)
          } else {
            
            VStack(spacing: 15){
              
              ForEach(comicViewModel.fetchedComics){ comic in
                
                ComicRowView(comic: comic).padding()
              }
              
              
              if comicViewModel.offset == comicViewModel.fetchedComics.count{
                
                ProgressView()
                  .padding(.vertical)
                  .onAppear(perform: {
                    print("fetching new data....")
                    comicViewModel.fetchComics()
                  })
              }
              else{
                
                GeometryReader{reader -> Color in
                  
                  let minY = reader.frame(in: .global).minY
                  
                  let height = UIScreen.main.bounds.height / 1.3
                  
                  // when it goes over the height triggering update...
                  
                  if !comicViewModel.fetchedComics.isEmpty && minY < height {
                    
                    DispatchQueue.main.async {
                      // this sets the offset so that we dont fetch the same comics
                      comicViewModel.offset = comicViewModel.fetchedComics.count
                    }
                  }
                  return Color.clear
                }
                .frame(width: 20, height: 20)
              }
            }
          }
        } // ScrollView
        .accessibilityLabel("A list of comics downloaded from the Marvel API")
      } // VStack
      .onAppear(perform: {
        if comicViewModel.fetchedComics.isEmpty{
          comicViewModel.fetchComics()
        }
      })
    } // VStack
  } // Body
} // ComicSView Struct


struct ComicRowView: View {
  
  var comic: Comic
  
  var body: some View {
    
    
    VStack(alignment: .leading, content: {
      
      HStack() {
        
        AsyncImage(url: URL(string: makeURLString(data: comic.thumbnail )))  { image in
          image.resizable()
        } placeholder: {
          ProgressView()
        }
        .frame(width: 75, height: 75)
        
        Text(comic.title )
          .font(.title3)
          .fontWeight(.bold)
        Spacer()
      }
      
      Text(comic.description ?? "" )
        .font(.caption)
        .foregroundColor(.gray)
        .multilineTextAlignment(.leading)
    }) //VStack
  } // body
  
  func makeURLString(data: [String:String])->String{
    let path = data["path"] ?? ""
    let ext = data["extension"] ?? ""
    
    let http = "\(path).\(ext)"
    let https = "https" + http.dropFirst(4)
    
    return String( https)
  }
} // ComicRowView struct
