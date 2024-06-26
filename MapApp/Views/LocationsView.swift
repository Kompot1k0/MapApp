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
    let maxWidthForIPad: CGFloat = 600
    
    
    var body: some View {
        ZStack {
            map
            VStack {
                header
                Spacer()
                footer
            }
        }
        .sheet(isPresented: $vm.isLearnMoreSheetShowing) {
            LocationDetailView(location: vm.mapLocation)
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
                .animation(.none, value: vm.mapLocation)
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
        .frame(maxWidth: maxWidthForIPad)
    }
    
    private var map: some View {
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates,
                          content: {
                CustomMapMarkerView()
                    .scaleEffect(location == vm.mapLocation ? 1 : 0.7)
                    .onTapGesture {
                        vm.showSelectedLocation(location: location)
                    }
            })
        })
            .ignoresSafeArea()
    }
    
    private var footer: some View {
        ForEach(vm.locations, content: { location in
            if vm.mapLocation == location {
                LocationPreviewView(location: location)
                    .shadow(color: .black.opacity(0.6), radius: 20)
                    .padding()
                    .frame(maxWidth: maxWidthForIPad)
                    .frame(maxWidth: .infinity)
                    .transition(.asymmetric(
                        insertion: .move(edge: .leading),
                        removal: .move(edge: .trailing)))
            }
        })
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}
