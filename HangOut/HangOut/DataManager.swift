//
//  DataManager.swift
//  HangOut
//
//  Created by Ciro De Sieno on 06/12/24.
//

import Foundation
import CoreLocation

class DataManager: ObservableObject {
    @Published var recentPlaces: [String] = ["Vomero", "Castel dell'Ovo"]
    @Published var locations: [CLLocationCoordinate2D] = []

    func getDensity(at coordinate: CLLocationCoordinate2D) -> Int {
        // Simula un calcolo di densità per l'area
        return locations.filter { $0.distance(from: coordinate) < 500 }.count
    }
}

