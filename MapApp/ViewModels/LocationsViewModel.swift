//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by Admin on 21.06.2024.
//

import Foundation
import MapKit
import SwiftUI

@MainActor
class LocationsViewModel: ObservableObject {
    // all downloaded locations
    @Published var locations: [Location]
    
    // current location
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    @Published private(set) var isListShowing: Bool = false
    @Published var isLearnMoreSheetShowing: Bool = false
    
    init() {
        let locations = LocationsDataService.locations
        let defaultLocation = Location(
            name: "Colosseum",
            cityName: "Rome",
            coordinates: CLLocationCoordinate2D(latitude: 41.8902, longitude: 12.4922),
            description: "The Colosseum is an oval amphitheatre in the centre of the city of Rome, Italy, just east of the Roman Forum. It is the largest ancient amphitheatre ever built, and is still the largest standing amphitheatre in the world today, despite its age.",
            imageNames: [
                "rome-colosseum-1",
                "rome-colosseum-2",
                "rome-colosseum-3",
            ],
            link: "https://en.wikipedia.org/wiki/Colosseum")
        self.locations = locations
        self.mapLocation = locations.first ?? defaultLocation
        self.updateMapRegion(location: locations.first ?? defaultLocation)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)
        }
    }
    
    func changeIsListShowing() {
        withAnimation(.easeInOut) {
            isListShowing.toggle()
        }
    }
    
    func showSelectedLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            isListShowing = false
        }
    }
    
    func nextButtonPressed() {
        guard let currentLocationIndex = locations.firstIndex(where: { $0.id == mapLocation.id }) else {return}
        
        // handle case where current location is last in array
        if currentLocationIndex == locations.count - 1 {
            if let nextLocation = locations.first {
                withAnimation(.easeInOut) {
                    mapLocation = nextLocation
                    isListShowing = false
                }
            }
        } else {
            withAnimation(.easeInOut) {
                mapLocation = locations[currentLocationIndex + 1]
                isListShowing = false
            }
        }
    }
    
    func changeisLearnMoreSheetShowing() {
        withAnimation(.easeInOut) {
            isLearnMoreSheetShowing.toggle()
        }
    }
}
