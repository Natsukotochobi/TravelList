//
//  ContentView.swift
//  TravelList
//
//  Created by chobi on 2024/06/03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            ItemListView()
            
                .navigationTitle("旅の持ち物")
        } // NavigationView
    } // body
} // ContentView

#Preview {
    ContentView()
}
