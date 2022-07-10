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
        Text("Marvel Comics").foregroundColor(Color.red).font(.largeTitle).bold()
          
              .cornerRadius(16)
              .padding()
             // .background(Color(red: 237/255, green: 29/255, blue: 36/255))

      ScrollView {
        

        if comicViewModel.fetchedComics.isEmpty{
            
            ProgressView()
                .padding(.top,30)
        } else {
          
          VStack(spacing: 15){
              
              ForEach(comicViewModel.fetchedComics){ comic in
                  
                ComicRowView(comic: comic)
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
                              // setting offset to current fetched comics count...
                              // so 0 will be now fetched from 20...
                              // and so on....
                              comicViewModel.offset = comicViewModel.fetchedComics.count
                          }
                      }
                      
                      return Color.clear
                  }
                  .frame(width: 20, height: 20)
              }
          }
        }
        
        
//            if let comics = comicSearchViewModel.fetchedComics {
//
//                  if comics.isEmpty{
//
//                      Text("No Results Found")
//                          .padding(.top,20)
//                  }
//                  else {
//
//                      ForEach(comics){ comicData in
//
//                        ComicRowView(comic: comicData)
//                      }
//                  }
//              }
            
  }
    } // VStack
      .onAppear(perform: {
      if comicViewModel.fetchedComics.isEmpty{
          comicViewModel.fetchComics()
      }
  })
}
}





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

              Text(comic.title )
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



//struct ComicRowView: View {
//
//    var character: Comic
//
//    var body: some View{
//
//        HStack(alignment: .top,spacing: 15){
//
////            WebImage(url: extractImage(data: character.thumbnail))
////                .resizable()
////                .aspectRatio(contentMode: .fill)
////                .frame(width: 150, height: 150)
////                .cornerRadius(8)
//
//            VStack(alignment: .leading, spacing: 8, content: {
//
//                Text(character.title)
//                    .fontWeight(.bold)
//
//                if let description = character.description{
//
//                    Text(description)
//                        .font(.caption)
//                        .foregroundColor(.gray)
//                        .lineLimit(3)
//                        .multilineTextAlignment(.leading)
//                }
//
//                // Links....
//                HStack(spacing: 10){
//
//                    ForEach(character.urls,id: \.self){data in
//
////                        NavigationLink(
////                            destination: WebView(url: extractURL(data: data))
////                                .navigationTitle(extractURLType(data: data)),
////                            label: {
////                                Text(extractURLType(data: data))
////                            })
//                    }
//                }
//            })
//
//            Spacer(minLength: 0)
//        }
//        .padding(.horizontal)
//    }
//
//    func extractImage(data: [String: String])->URL{
//
//        // combining both and forming image...
//        let path = data["path"] ?? ""
//        let ext = data["extension"] ?? ""
//
//        return URL(string: "\(path).\(ext)")!
//    }
//
//    func extractURL(data: [String:String])->URL{
//
//        let url = data["url"] ?? ""
//
//        return URL(string: url)!
//    }
//
//    func extractURLType(data: [String:String])->String{
//
//        let type = data["type"] ?? ""
//
//        return type.capitalized
//    }
//}
