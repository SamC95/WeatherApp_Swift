//
//  WeatherForcastView.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//

import SwiftUI

struct WeatherForecastView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    var body: some View {
        NavigationView {
            ZStack{
                Color(red: 176 / 255, green: 207 / 255, blue: 236 / 255)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: 365, height: 285)
                    .offset(CGSize(width: 0, height: -250.0))
                ScrollView{
                    VStack(alignment: .leading, spacing: 16) {
                        if let hourlyData = weatherMapViewModel.weatherDataModel?.hourly {
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                
                                HStack(spacing: 10) {
                                    
                                    ForEach(hourlyData) { hour in
                                        HourWeatherView(current: hour)
                                    }
                                }
                                .padding(.horizontal, 16)
                            }
                            .frame(height: 180)
                        }
                        Divider()
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                        VStack {
                            List {
                                ForEach(weatherMapViewModel.weatherDataModel?.daily ?? []) { day in
                                    DailyWeatherView(day: day)
                                }
                            }
                            .listStyle(GroupedListStyle())
                            .frame(height: 500)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .padding(.horizontal, 14)
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Image(systemName: "sun.min.fill")
                            VStack{
                                Text("Weather Forecast for \(weatherMapViewModel.city)").font(.title3)
                                    .fontWeight(.bold)
                            }
                        }
                    }
                }
            }
        }
    }
    
    struct WeatherForcastView_Previews: PreviewProvider {
        static var previews: some View {
            WeatherForecastView().environmentObject(WeatherMapViewModel())
        }
    }
}
