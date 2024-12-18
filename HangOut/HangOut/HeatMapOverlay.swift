//
//  HeatMapOverlay.swift
//  HangOut
//
//  Created by Ciro De Sieno on 06/12/24.
//

import MapKit

struct HeatMapOverlay {
    static func addHeatmap(to mapView: MKMapView, with locations: [CLLocationCoordinate2D]) {
        for location in locations {
            let circle = MKCircle(center: location, radius: 500)
            mapView.addOverlay(circle)
        }
    }

    static func color(for density: Int) -> UIColor {
        switch density {
        case 0..<10:
            return UIColor.blue
        case 10...:
            return UIColor.red
        default:
            return UIColor.clear
        }
    }
}

