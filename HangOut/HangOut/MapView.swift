//
//  MapView.swift
//  HangOut
//
//  Created by Ciro De Sieno on 06/12/24.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @ObservedObject var dataManager: DataManager

    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.delegate = context.coordinator
        map.showsUserLocation = true
        map.setRegion(MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.8399, longitude: 14.2525), // Napoli
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        ), animated: true)

        // Aggiungi le heatmap
        HeatMapOverlay.addHeatmap(to: map, with: dataManager.locations)

        return map
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Aggiorna la mappa con nuovi dati
        uiView.removeOverlays(uiView.overlays)
        HeatMapOverlay.addHeatmap(to: uiView, with: dataManager.locations)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            guard let circle = overlay as? MKCircle else { return MKOverlayRenderer() }

            let renderer = MKCircleRenderer(circle: circle)
            renderer.fillColor = HeatMapOverlay.color(for: parent.dataManager.getDensity(at: circle.coordinate))
            renderer.alpha = 0.5
            return renderer
        }
    }
}
