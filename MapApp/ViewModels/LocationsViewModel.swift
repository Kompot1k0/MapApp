//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by Admin on 21.06.2024.
//

import Foundation

class LocationsViewModel: ObservableObject {
    
    @Published var locations: [Location]
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
    }
}
