//
//  LocationModel.swift
//  MapApp
//
//  Created by Admin on 21.06.2024.
//

import Foundation
import MapKit

struct Location {
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
}
