//
//  Models.swift
//  HangOut
//
//  Created by Ciro De Sieno on 06/12/24.
//

import Foundation
import CoreLocation

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

