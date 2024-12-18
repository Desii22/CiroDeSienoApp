//
//  VoiceOver.swift
//  HangOut
//
//  Created by Ciro De Sieno on 12/12/24.
//

import SwiftUI
import MapKit

struct AccessibleMapView: UIViewRepresentable {
    @Binding var locations: [CLLocationCoordinate2D]

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.removeOverlays(mapView.overlays)
        for location in locations {
            let circle = MKCircle(center: location, radius: 500)
            mapView.addOverlay(circle)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: AccessibleMapView

        init(_ parent: AccessibleMapView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let circle = overlay as? MKCircle {
                let renderer = MKCircleRenderer(circle: circle)

                // Determine color based on density
                let density = parent.getDensity(at: circle.coordinate)
                renderer.fillColor = density >= 10 ? UIColor.red.withAlphaComponent(0.4) : UIColor.blue.withAlphaComponent(0.4)
                renderer.strokeColor = UIColor.clear
                renderer.lineWidth = 0
                
                // VoiceOver for the heatmap
                circle.accessibilityLabel = "Heatmap area"
                circle.accessibilityValue = density >= 10 ? "High density of people" : "Low density of people"
                
                return renderer
            }
            return MKOverlayRenderer()
        }
    }

    // Helper function to calculate density
    func getDensity(at coordinate: CLLocationCoordinate2D) -> Int {
        locations.filter { $0.distance(from: coordinate) < 500 }.count
    }
}


