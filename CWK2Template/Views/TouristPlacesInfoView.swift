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

/*
 JUSTIFICATION FOR ADDED ENHANCEMENTS
 ----------------------------------------
 For the task requiring enhancements to the app, I have implemented a new view
 called TouristPlacesInfoView which has the purpose of allowing the user to press
 on one of the tourist attractions on the Place Map view, this will then take them
 to a separate view where they can see some extra details on that attraction such
 as the multiple images, a brief description and the wikipedia link. All these
 details come from the places.json file and no additions have been made to the json file.
 
 When the Place Map has attractions listed, the UI looks the same as the image for the
 place map view that was provided in the coursework spec, with the minor addition of
 arrows on each attraction to signify to the user that it is clickable. The Info View 
 also has a built in 'Back' button that will return the user to the mapview.
 
 Since the list of attractions are the buttons to go to this view, if the entered
 location has no tourist attractions listed then they simply will not be able to reach
 this view for that location. In the event that there are no images for the given
 tourist attraction such as with New York in this program, the view will instead
 have a grey box's that represent where images would be.
 
 I believe this addition provides a useful and practical addition to the application
 from the user perspective by allowing them to gain a extra information on the given
 tourist attraction beyond what the map view provides.
 
 I considered implementing the Wikipedia link as an actual link, however I was unsure
 if from a coursework perspective, I should be allowing the application to move away
 from the application and into Safari instead, even if it would have had a button
 to easily return to the application.
 ----------------------------------------
 */
