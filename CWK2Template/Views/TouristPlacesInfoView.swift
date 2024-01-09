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
                        
                        if (touristAttraction?.link != nil) {
                            Link("\(touristAttraction?.link ?? "Error: No link found")", destination: URL(string: touristAttraction?.link ?? "") ?? URL(string: "www.wikipedia.org")!)
                                .font(.system(size: 14))
                                .multilineTextAlignment(.center)
                                .frame(width: 350, height: 10)
                        }
                        else {
                            Text("\(touristAttraction?.link ?? "Error: No link found")")
                                .font(.system(size: 14))
                                .multilineTextAlignment(.center)
                                .frame(width: 350, height: 10)
                        }
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
 
 I have also implemented the wikipedia link that is included in places.json for the
 tourist attractions. I have done this by first using an if condition to check that the
 value is not nil to prevent crashes. If it is not nil then the link will be displayed as
 clickable, if it does for some reason retrieve a nil value then it should instead just
 display the link as text that is not clickable. I was unsure if this is an acceptable
 approach to using a force-unwrap as I know they are generally not the ideal approach due
 to the risk of crashes, but I have tested it thoroughly with the mentioned if block and
 encountered no crashes or bugs.
 
 When the link is clicked it will open in Safari, there is a button provided by the OS to
 return to the weather app, it is worth noting for performance factors of the
 emulator that opening these links and pressing back to the app will not close the pages
 on the Safari browser app.
 
 This extra view provides beneficial context to the user on what each tourist attraction is
 and whether they may want to visit it, in a way that is clear from a UI/UX standpoint. It
 also allows for the use of more of the provided json data from a development standpoint.
 As such I feel this is an addition that naturally extends the purpose of the app in a
 way that doesn't alter the overall style.
 ----------------------------------------
 */
