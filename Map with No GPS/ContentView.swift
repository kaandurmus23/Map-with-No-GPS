//
//  ContentView.swift
//  Map with No GPS
//
//  Created by Kaan on 13.03.2024.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: UIViewRepresentable {
    var locations: [CLLocation]

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.mapType = .satellite
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        view.removeAnnotations(view.annotations)

        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            view.addAnnotation(annotation)
        }
    }
}

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private var locationManager = CLLocationManager()
    @Published var locations: [CLLocation] = []

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // Set the desired accuracy
    }

    func requestLocation() {
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.locations.append(location)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
}


struct ContentView: View {
    @ObservedObject var locationManager = LocationManager()

    var body: some View {
        ZStack {
            MapView(locations: locationManager.locations)
                .edgesIgnoringSafeArea(.all)
            Button("Use Current Location") {
                locationManager.requestLocation()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height * (0.85))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
