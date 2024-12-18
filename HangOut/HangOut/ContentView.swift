//
//  ContentView.swift
//  HangOut
//
//  Created by Ciro De Sieno on 06/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var dataManager = DataManager()

    var body: some View {
        NavigationView {
            VStack {
                TabBarView(recentPlaces: dataManager.recentPlaces)
                MapView(dataManager: dataManager)
                    .edgesIgnoringSafeArea(.all)
            }
            .navigationTitle("HangOut")
            .navigationBarTitleDisplayMode(.inline)
        }
        .environmentObject(dataManager)
    }
}
