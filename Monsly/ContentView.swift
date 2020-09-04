//
//  ContentView.swift
//  Monsly
//
//  Created by 정현민 on 2020/08/31.
//  Copyright © 2020 Hyunmin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      Form {
        NavigationLink(destination: CalculatorView()) {
          Text("집값 실질 소비금액 계산기")
        }
      }
      .navigationBarTitle("Home")
      .navigationBarItems(trailing: NavigationLink(destination: SettingView()) {
        Image(systemName: "wonsign.circle.fill")
      })
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
