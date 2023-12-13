//
//  TouristPlacesMapView.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit

struct TouristPlacesMapView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    @State var locations: [Location] = []
    @State var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5216871, longitude: -0.1391574), latitudinalMeters: 11500, longitudinalMeters: 11500)
    var body: some View {
        NavigationView {
            VStack(spacing: 5) {
                if weatherMapViewModel.coordinates != nil {
                    VStack(spacing: 10){
                        Map(coordinateRegion: $mapRegion, showsUserLocation: true)
                            .offset(y: -65)
                            .edgesIgnoringSafeArea(.all)
                            .frame(width: 500, height: 300)
                        VStack{
                            Text("Tourist Attractions in \(weatherMapViewModel.city)")
                        }
                        .offset(y: -65)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.title2)
                        .fontWeight(.semibold)
                    }
                }
                List{
                    ForEach(locations.filter {$0.cityName == weatherMapViewModel.city}) { location in
                        HStack{
                            Image("\(location.imageNames.first ?? "")")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                            
                            Text("\(location.name)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .listSectionSeparator(.hidden)
                .offset(x: 25, y: -65)
                
            }
            .frame(height:700)
            .padding(.horizontal)
        }
        .onAppear {
            DispatchQueue.main.async {
                updateRegion()
                
                if (weatherMapViewModel.coordinates != nil) {
                    locations = weatherMapViewModel.loadLocationsFromJSONFile(cityName: weatherMapViewModel.city)!
                }
            }
        }
    }
    
    func updateRegion() {
        if (weatherMapViewModel.city == "London") {
            mapRegion = MKCoordinateRegion(center: weatherMapViewModel.coordinates ?? CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00), latitudinalMeters: 11500, longitudinalMeters: 11500)
        }
        else {
            mapRegion = MKCoordinateRegion(center: weatherMapViewModel.coordinates ?? CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00), latitudinalMeters: 4000, longitudinalMeters: 4000)
        }
    }
}


struct TouristPlacesMapView_Previews: PreviewProvider {
    static var previews: some View {
        TouristPlacesMapView().environmentObject(WeatherMapViewModel())
    }
}
