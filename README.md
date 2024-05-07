# Swift Weather App Project
By [Sam Clark](https://github.com/SamC95)

This project was coursework for my third year module: Mobile Native Application Development -- at the University of Westminster

The project builds upon an initial starting template provided by my module lecturer: Girish Lukka

The API Key is no longer active, please include your own from [OpenWeather](https://openweathermap.org/) using the One Call API 3.0 service; if running the application.

## Contents
* [Project Brief]()
* [Approach]()
* [Technologies]()
* [Responsibilities]()
* [Key Learnings]()
* [Achievements]()
* [Challenges]()
* [Conclusions]()

## Project Brief
* When the app launches for the first time, a user will see the current weather for London including the date and time.
* Forecast tab gives a rich weather view of the current location, with a top part a scrollable view showing a summary of hourly weather for the next 48 hours and the bottom part a vertically scrollable view showing summarised weather for each of the following next 8 days for the location from City tab.
* Places tab is a compound view with a top part showing a map with pins of tourist attraction places and the bottom part a scrollable list of the tourist places loaded from file data, if there is data relating to the location.
* When the user changes the location in City tab, all other views must also change and load relevant data for this new place.
* The app interface follows Apple guidelines.
* The app interacttion is consistent
* The app data should be formatted correctly.
* The app interface should match the images provided.
* The application must be built using SwiftUI, CoreLocation, MapKit Frameworks and the Openweather API. Frameworks or Libraries such as Pods, Lottie, SDWebImage, WeatherKit, UIKit and others are not allowed.

## Approach

### Design Images

As mentioned in the project brief, the requirement for the project was that the application matches the design images provided in the specification.

These are as below: 

<img src="https://github.com/SamC95/WeatherApp_Swift/assets/132593571/df6ed312-99e0-42ea-9179-50432009ec3f" width="400" />

As such, the core design goal of the project was to get the specified functionality working in the provided template and ensure that the user interface meets the given specification requirements.


## Technologies

![Static Badge](https://img.shields.io/badge/Swift-%23F05138?style=for-the-badge&logo=Swift&logoColor=white)
![Static Badge](https://img.shields.io/badge/Xcode-%23147EFB?style=for-the-badge&logo=Xcode&logoColor=white)
![image](https://camo.githubusercontent.com/5d4f07e411a7b968c9a1c2c46a5b97945aefeda4d7fd643bb93c10525cfefa3f/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f4a534f4e2d2532333030303030303f7374796c653d666f722d7468652d6261646765266c6f676f3d4a534f4e266c6f676f436f6c6f723d7768697465)

[OpenWeather API](https://openweathermap.org/)

## Responsibilities

Since the project was based on the use of a provided template, a lot of the initial structure was already defined. As such the aim was to implement the necessary functionality to allow the application to use the OpenWeather API dynamically to retrieve results for any location.

Below shows the process of getting the coordinates for a specific city based on the user search and using the longitude and latitude values to determine the weather data that is received along with the coordinates for the MapView.

```swift
 init() {
        Task {
            do {
                try await getCoordinatesForCity()
            } 
            catch {
                print("Error loading weather data: \(error)")
            }
        }
    }
    func getCoordinatesForCity() async throws {  
        let geocoder = CLGeocoder()
        if let placemarks = try? await geocoder.geocodeAddressString(city),
           let location = placemarks.first?.location?.coordinate {
            
            DispatchQueue.main.async {
                self.coordinates = location
                self.region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            }
            let data = try await loadData(lat: location.latitude, lon: location.longitude )
            print("Weather data loaded: \(String(describing: data.timezone))")

        } else {
            print("Error: Unable to find the coordinates")
        }
    }

    func loadData(lat: Double, lon: Double) async throws -> WeatherDataModel {
        if let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&units=metric&appid=APIKEYHERE") {
            let session = URLSession(configuration: .default)

            do {
                let (data, _) = try await session.data(from: url)
                let weatherDataModel = try JSONDecoder().decode(WeatherDataModel.self, from: data)

                DispatchQueue.main.async {
                    self.weatherDataModel = weatherDataModel
                    print("weatherDataModel loaded")
                }
```

The next block of code below shows the MapView with the appropriate pins to match the attractions in the List below it, based on the current location and if that location has data in the locally stored JSON file.

This was only the case for four locations: London, Paris, Rome & New York. Other locations will still work but would not have map pins or attraction locations shown below the map.

```swift
var body: some View {
        NavigationView {
            VStack(spacing: 5) {
                if weatherMapViewModel.coordinates != nil {
                    VStack(spacing: 10){
                        Map(coordinateRegion: $mapRegion, showsUserLocation: true, annotationItems: locations) { location in
                            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.coordinates.latitude, longitude: location.coordinates.longitude)) {
                                VStack{
                                    Image(systemName: "mappin.circle.fill")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.red)
                                }
                            }
                        }
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
                            Spacer()
                            Spacer()
                            
                            NavigationLink(destination: TouristPlacesInfoView(locationName: locationName)
                                .onAppear {
                                    locationName = location.name
                                }
                            ){}
                            .frame(width: 20, height: 20)
                            Spacer(minLength: 40)
                        }
                        .frame(width: 350, height: 100, alignment: .center)
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
                    locations = weatherMapViewModel.loadLocationsFromJSONFile(cityName: weatherMapViewModel.city) ?? []
                }
            }
        }
    }
```

### Application Screenshots

Below shows screenshots of my final implementation of the requirements, along with my extra component that provides extra details about the specific tourist attraction.

<p float="left">
  <img width="210" alt="Screenshot 2024-05-07 at 17 52 54" src="https://github.com/SamC95/WeatherApp_Swift/assets/132593571/fbb40f54-596e-4374-9771-7335cf0e676b">
  <img width="210" alt="Screenshot 2024-05-07 at 17 54 53" src="https://github.com/SamC95/WeatherApp_Swift/assets/132593571/c75e4ec9-e546-4818-a74a-d13a7a157496">
  <img width="210" alt="Screenshot 2024-05-07 at 17 55 41" src="https://github.com/SamC95/WeatherApp_Swift/assets/132593571/b9bf2b07-7432-4246-9fdd-3a8901be8b3e">
  <img width="210" alt="Screenshot 2024-05-07 at 17 56 20" src="https://github.com/SamC95/WeatherApp_Swift/assets/132593571/5b327317-b00a-40a6-849c-bcc3d6b63f9b">
</p>

## Key Learnings

* Gained a basic understanding of Swift application development.
* Learnt good design patterns around MVVM (Model-View-ViewModel) architecture.
* Gained further knowledge of utilising APIs in applications and manipulating JSON data to display appropriate data.
* Learnt how to use Map functionality in a Swift Application
* Was able to analyse and adapt existing template code to include the specified functionality.

## Achievements

* Effectively managed to meet the expected design requirements from both UI and functionality perspectives.
* Application correctly worked with any location or weather types without crashes or bugs.
* Implemented an extra View (Tourist Attraction Information) with appropriate Wikipedia Link to enhance application functionality beyond the key requirements.

## Challenges

The most challenging aspect of the project for me was properly implementing the Map and associated MapPins as this took me longer than expected to figure out. Some other challenges were getting the UI exactly as needed to match the given design images.

## Conclusions

This project allowed me to gain basic knowledge of Swift application development using Xcode and utilise the MVVM design patterns to create an application that adheres to expected Swift development standards. It also allowed for me to further expand my knowledge of utilising APIs after having had a little bit of experience in a prior module.

If I had more time to work on the application and was able to explore new features beyond the requirements that were given, I would have liked to implement an account system so that I could implement functionality so that the user can save locations and have a View where they are saved in a list for easy access to the current data from those locations.
