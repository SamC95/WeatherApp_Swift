//
//  TouristPlacesInfoView.swift
//  CWK2Template
//
//  Created by Sam Clark on 26/12/2023.
//

import SwiftUI

struct TouristPlacesInfoView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    @State var locations: [Location] = []
    var locationName: String
    
    var touristAttraction: Location? {
        return locations.first { $0.name == locationName }
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                Image("background2")
                    .resizable()
                    .opacity(0.3)
                    .aspectRatio(contentMode: .fill)
                    .offset(y: -100)
                
                VStack{
                    if weatherMapViewModel.coordinates != nil {
                        Text(touristAttraction?.name.capitalized ?? "")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(touristAttraction?.cityName.capitalized ?? "")
                            .font(.title3)
                            .foregroundStyle(Color.gray)
                        
                        HStack{
                            Spacer()
                            Image("\(touristAttraction?.imageNames.first ?? "")")
                                .resizable()
                                .frame(width: 150, height: 150, alignment: .center)
                                .background(Color.gray)
                                .cornerRadius(20)
                            
                            Spacer()
                            
                            Image("\(touristAttraction?.imageNames.last ?? "")")
                                .resizable()
                                .frame(width: 150, height: 150, alignment: .center)
                                .background(Color.gray)
                                .cornerRadius(20)
                            
                            Spacer()
                        }
                        
                        Text(touristAttraction?.description ?? "")
                            .font(.system(size: 16))
                            .multilineTextAlignment(.center)
                            .frame(width: 250, height: 200)
                        
                        Spacer(minLength: 150)
                        
                        Text("More Information at: ")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .frame(width: 350, height: 50)
                        
                        Text("\(touristAttraction?.link ?? "Error: No link found")")
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                            .frame(width: 350, height: 10)
                        
                        Spacer()
                    }
                }
                .onAppear {
                    DispatchQueue.main.async {
                        if (weatherMapViewModel.coordinates != nil) {
                            locations = weatherMapViewModel.loadLocationsFromJSONFile(cityName: weatherMapViewModel.city) ?? []
                        }
                    }
                }
            }
        }
    }
}
