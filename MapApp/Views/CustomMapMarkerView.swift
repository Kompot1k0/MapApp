//
//  CustomMapMarkerView.swift
//  MapApp
//
//  Created by Admin on 22.06.2024.
//

import SwiftUI

struct CustomMapMarkerView: View {
    var body: some View {
        VStack(spacing: 0.0) {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .font(.headline)
                .frame(width: 25, height: 25)
                .foregroundColor(.white)
                .padding(6)
                .background(Color.accentColor)
                .clipShape(Circle())
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .font(.headline)
                .frame(width: 14)
                .foregroundColor(.accentColor)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -4)
        }
        .offset(y: -20)
    }
}

struct CustomMapMarkerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomMapMarkerView()
    }
}
