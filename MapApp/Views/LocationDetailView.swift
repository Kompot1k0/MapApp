//
//  LocationDetailView.swift
//  MapApp
//
//  Created by Admin on 23.06.2024.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    @Environment(\.dismiss) var dismiss
    
    let location: Location
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                    
                VStack(alignment: .leading, spacing: 16.0) {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapSection
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(alignment: .topTrailing) {
            backButton
        }
    }
}

extension LocationDetailView {
    
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) { image in
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text(location.description)
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
            if let url = URL(string: location.link) {
                Link("Learn more on Wiki", destination: url)
                    .foregroundColor(.blue)
            }
        }
    }
    
    private var mapSection: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(
            center: location.coordinates,
            span: MKCoordinateSpan(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01))),
            annotationItems: [location]) { location in
            MapAnnotation(coordinate: location.coordinates) {
                CustomMapMarkerView()
                    
            }
        }
            .aspectRatio(1, contentMode: .fill)
            .allowsHitTesting(false)
            .cornerRadius(10)
    }
    
    private var backButton: some View {
        Button {
            withAnimation(.easeInOut) {
                dismiss()
            }
        } label: {
            Image(systemName: "xmark")
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(10)
        }
        .padding()
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(location: LocationsDataService.locations.first!)
            .environmentObject(LocationsViewModel())
    }
}
