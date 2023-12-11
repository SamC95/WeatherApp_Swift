//
//  HourWeatherView.swift
//  CWK2Template
//
//  Created by girish lukka on 02/11/2023.
//

import SwiftUI

struct HourWeatherView: View {
    var current: Current
    
    var body: some View {
        let formattedDate = DateFormatterUtils.formattedDateWithDay(from: TimeInterval(current.dt))
        let weatherIcon = current.weather.first?.icon
        let hourlyTemp = current.temp
        let hourlyDescription = current.weather.first?.weatherDescription
        
        VStack(alignment: .center, spacing: 5) {
            Text(formattedDate)
                .font(.body)
                .padding(.horizontal)
                .padding(.top)
                .foregroundColor(.black)
            
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weatherIcon ?? "").png"))
                .frame(height: 40)
                
            Text(String(format: "%.0f\u{00B0}C", hourlyTemp))
                .frame(width: 125)
                .font(.body)
                .multilineTextAlignment(.leading)
                .lineLimit(nil) 
                .padding(.horizontal)
                .foregroundColor(.black)
            
            Text(hourlyDescription?.rawValue.capitalized ?? "")
                .frame(width: 125)
                .font(.body)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .padding(.horizontal)
                .padding(.bottom)
                .foregroundColor(.black)
        }
        .background(Color.teal)
        .cornerRadius(5)    }
}




