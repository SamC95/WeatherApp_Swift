//
//  WeatherNowView.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//

import SwiftUI

struct WeatherNowView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    @State private var isLoading = false
    @State private var temporaryCity = ""
    var body: some View {
        ZStack {
            Image("sky")
                .resizable()
                .opacity(0.5)
                .aspectRatio(contentMode: .fill)
                .offset(y: -70)
            
            VStack{
                HStack{
                    Text("Change Location")
                    
                    TextField("Enter New Location", text: $temporaryCity)
                        .onSubmit {
                            
                            weatherMapViewModel.city = temporaryCity
                            Task {
                                do {
                                    // write code to process user change of location
                                } catch {
                                    print("Error: \(error)")
                                    isLoading = false
                                }
                            }
                        }
                }
                .bold()
                .font(.system(size: 20))
                .padding(10)
                .shadow(color: .blue, radius: 10)
                .cornerRadius(10)
                .fixedSize()
                .font(.custom("Arial", size: 26))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(15)
                
                VStack{
                    HStack{
                        Text("Current Location: \(weatherMapViewModel.city)")
                    }
                    .bold()
                    .font(.system(size: 20))
                    .padding(10)
                    .shadow(color: .blue, radius: 10)
                    .cornerRadius(10)
                    .fixedSize()
                    .font(.custom("Arial", size: 26))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .cornerRadius(15)
                    let timestamp = TimeInterval(weatherMapViewModel.weatherDataModel?.current.dt ?? 0)
                    let formattedDate = DateFormatterUtils.formattedDateTime(from: timestamp)
                    Text(formattedDate)
                        .padding()
                        .font(.title)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 1)
                }
                
                VStack(alignment: .leading, spacing: 10){
                    HStack{
                        // Current Weather Description
                        if let forecast = weatherMapViewModel.weatherDataModel {
                            let weatherArray = forecast.current.weather
                            
                            if let first = weatherArray.first {
                                let currentDescription = first.weatherDescription
                                let currentIcon = first.icon
                                
                                Label {
                                    Spacer(minLength: 5)
                                        .frame(maxWidth: 40, alignment: .center)
                                    Text("\(currentDescription.rawValue.capitalized)")
                                        .font(.system(size: 25, weight: .medium))
                                        .padding(.top)
                                        .frame(alignment: .leading)
                                } icon: {
                                    Image(currentIcon)
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                }
                            }
                        }
                        else {
                            Text("N/A")
                                .font(.system(size: 25, weight: .medium))
                        }
                    }
                    
                    HStack(spacing: 10){
                        // Weather Temperature Value
                        if let forecast = weatherMapViewModel.weatherDataModel {
                            Label {
                                Spacer(minLength: 5)
                                    .frame(maxWidth: 50)
                                Text("Temp: \((Double)(forecast.current.temp), specifier: "%.2f") ºC")
                                    .font(.system(size: 25, weight: .medium))
                            } icon: {
                                Image("temperature")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            }
                        }
                        else {
                            Text("Temp: N/A")
                                .font(.system(size: 25, weight: .medium))
                        }
                    }
                    
                    HStack{
                        // Weather Humidity Value
                        if let forecast = weatherMapViewModel.weatherDataModel {
                            Label {
                                Spacer(minLength: 5)
                                    .frame(maxWidth: 45)
                                Text("Humidity: \(forecast.current.humidity) %")
                                    .font(.system(size: 25, weight: .medium))
                            } icon: {
                                Image("humidity")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            }
                        }
                        else {
                            Text("Humidity: N/A")
                                .font(.system(size: 25, weight: .medium))
                        }
                    }
                    
                    HStack{
                        //Current Pressure Value
                        if let forecast = weatherMapViewModel.weatherDataModel {
                            Label {
                                Spacer(minLength: 5)
                                    .frame(maxWidth: 20)
                                Text("Pressure: \(forecast.current.pressure) hPa")
                                    .font(.system(size: 25, weight: .medium))
                            } icon: {
                                Image("pressure")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            }
                        }
                        else {
                            Text("Pressure: N/A")
                                .font(.system(size: 25, weight: .medium))
                        }
                    }
                    
                    HStack{
                        //Current Wind Speed Value
                        if let forecast = weatherMapViewModel.weatherDataModel {
                            Label {
                                Spacer(minLength: 5)
                                    .frame(maxWidth: 20)
                                Text("Windspeed: \((Double)(forecast.current.windSpeed), specifier: "%.2f") mph")
                                    .font(.system(size: 25, weight: .medium))
                            } icon: {
                                Image("windSpeed")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            }
                        }
                        else {
                            Text("Windspeed: N/A")
                                .font(.system(size: 25, weight: .medium))
                        }
                    }
                }
            }
        }
    }
    struct WeatherNowView_Previews: PreviewProvider {
        static var previews: some View {
            WeatherNowView()
        }
    }
}
