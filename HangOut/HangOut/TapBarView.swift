//
//  TapBarView.swift
//  HangOut
//
//  Created by Ciro De Sieno on 06/12/24.
//

import SwiftUI

struct TabBarView: View {
    let recentPlaces: [String]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(recentPlaces, id: \.self) { place in
                    Text(place)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                        .font(.subheadline)
                }
            }
            .padding(.horizontal)
        }
        .background(Color(UIColor.systemBackground))
    }
}
