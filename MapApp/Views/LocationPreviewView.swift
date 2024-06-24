//
//  LocationPreviewView.swift
//  MapApp
//
//  Created by Admin on 22.06.2024.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    let location: Location
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack {
                imageSection
                titleSection
            }
            Spacer()
            VStack() {
                learnMoreButton
                nextButton
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 50)
        )
        .cornerRadius(10)
    }
}

extension LocationPreviewView {
    
    private var imageSection: some View {
        Group {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                    .padding(6)
                    .background(Color.white)
                    .cornerRadius(10)
            }
        }
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.headline)
        }
    }
    
    private var learnMoreButton: some View {
        Button {
            vm.changeisLearnMoreSheetShowing()
        } label: {
            Text("Learn more")
                .font(.headline)
                .frame(width: 130, height: 40)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button {
            vm.nextButtonPressed()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 130, height: 40)
        }
        .buttonStyle(.bordered)
    }
}

struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            LocationPreviewView(location: LocationsDataService.locations.first!)
        }
    }
}
