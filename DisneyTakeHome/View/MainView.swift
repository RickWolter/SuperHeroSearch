//
//  MainView.swift
//  DisneyTakeHome
//
//  Created by Rick W. on 7/10/22.
//

import SwiftUI

struct MainView: View {

  @StateObject var characterSearchViewModel = CharacterSearchViewModel()
  @StateObject var comicSearchViewModel = ComicsViewModel()
  
  init() // Nav bar modifications
  {
    let appearance = UINavigationBarAppearance()

    
    // Apply to all downstream Nav bars
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().compactAppearance = appearance
  }
  
  var body: some View {

      TabView{
          
          // Characters View...
          ComicsView()
              .tabItem {
                  Image(systemName: "person.3.fill")
                  Text("Comics")
              }
          // setting Environment Object...
          // so that we can access data on character View...
              .environmentObject(comicSearchViewModel)
          
        CharacterSearchView()
              .tabItem {
                  Image(systemName: "books.vertical.fill")
                  Text("Chracters")
              }
              .environmentObject(characterSearchViewModel)
      }.onAppear(perform: {
        
        // for the transparency bug in iOS 15 -
        //TODO: remove onAppear Nav Bar appearance from here once iOS 15 transparency bug is sovled
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        if #available(iOS 15.0, *) {
          UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        } else {
        }
        // correct the transparency bug for Navigation bars
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
      })    .splashView {
        ZStack {
          
          Image("MarvelLogo")
            
        }
      }
  }
}
