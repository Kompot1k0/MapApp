//
//  LocationsView.swift
//  MapApp
//
//  Created by Admin on 21.06.2024.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
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
        VStack {
            Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                .font(.title2)
                .fontWeight(.black)
                .foregroundColor(.primary)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                
                .overlay(alignment: .leading) {
                    Image(systemName: vm.isListShowing ? "arrow.up" : "arrow.down")
                        .padding()
                        .rotationEffect(Angle(degrees: vm.isListShowing ? 180 : 0) )
                }
                .onTapGesture {
                    vm.changeIsListShowing()
                }
            
            if vm.isListShowing {
                LocationsListView()
            }
        }
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
