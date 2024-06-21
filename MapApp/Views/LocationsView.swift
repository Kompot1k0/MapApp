//
//  LocationsView.swift
//  MapApp
//
//  Created by Admin on 21.06.2024.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject var vm: LocationsViewModel
    
    var body: some View {
        ZStack {
            map
            
            VStack {
                header
                Spacer()
            }
        }
    }
}


extension LocationsView {
    private var header: some View {
        Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
            .font(.title2)
            .fontWeight(.black)
            .foregroundColor(.primary)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.6), radius: 20, x: 0, y: 15)
            .padding()

    }
    
    private var map: some View {
        Map(coordinateRegion: $vm.mapRegion)
            .ignoresSafeArea()
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}
