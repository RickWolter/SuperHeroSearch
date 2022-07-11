//
//  MainView.swift
//  DisneyTakeHome
//
//  Created by Rick W. on 7/10/22.
//

import SwiftUI

struct MainView: View {
  
  @StateObject var characterSearchViewModel = CharacterViewModel()
  @StateObject var comicSearchViewModel = ComicsViewModel()
  
  init(){}
  
  var body: some View {
    
    TabView{
      
      // Characters View...
      ComicsView()
        .tabItem {
          Image(systemName: "person.3.fill")
          Text("Comics")
        }.environmentObject(comicSearchViewModel)
        .accessibility(identifier: "Comics Tab Button")
        .accessibilityLabel("A Tab Button that takles you to the screen where various Comics are displayed in a list ")
      CharactersView()
        .tabItem {
          Image(systemName: "books.vertical.fill")
          Text("Chracters")
        }.environmentObject(characterSearchViewModel)
        .accessibility(identifier: "Characters Tab Button")
        .accessibilityHint("A Tab Button that takes you to the screen where Characters can be searched for")
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
    }).splashView {
      //used this as a Slpash screen rather within plist becuase it was more customizable
      ZStack {
        Image("MarvelLogo")
      }
    }
  }
}
