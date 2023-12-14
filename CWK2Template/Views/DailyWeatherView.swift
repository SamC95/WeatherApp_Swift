//
//  DailyWeatherView.swift
//  CWK2Template
//
//  Created by girish lukka on 02/11/2023.
//

import SwiftUI

struct DailyWeatherView: View {
    var day: Daily
    var body: some View {
        
        let weatherIcon = day.weather.first?.icon
        let weatherDescription = day.weather.first?.weatherDescription
        let maxTemp = day.temp.max
        let minTemp = day.temp.min
        
        HStack{
            // Allows for resizing of ASyncImage and covers potential error cases
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weatherIcon ?? "")@2x.png")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                    
                case.success(let image):
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                    
                case.failure(let error):
                    Text(error.localizedDescription)
                    
                @unknown default:
                    fatalError()
                }
            }
            .foregroundStyle(.black)
            
            VStack{
                Text(weatherDescription?.rawValue.capitalized ?? "")
                    .frame(width: 125)
                    .font(.system(size: 15))
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .foregroundColor(.black)
                
                let formattedDate = DateFormatterUtils.formattedDateWithWeekdayAndDay(from: TimeInterval(day.dt))
                Text(formattedDate)
                    .frame(width: 125)
                    .font(.system(size: 15))
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .foregroundColor(.black)
            }
            .padding(.horizontal)
            
            HStack(spacing: 0){
                Text(String(format: "%.0f\u{00B0}C", maxTemp))
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                
                Text("/")
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                
                Text(String(format: "%.0f\u{00B0}C", minTemp))
                    .font(.system(size: 15))
                    .foregroundColor(.black)
            }
        }
        .frame(height: 40)
        .background(Image("background").opacity(0.03))
    }
}

//struct DailyWeatherView_Previews: PreviewProvider {
//    static var day = WeatherMapViewModel().weatherDataModel!.daily
//    static var previews: some View {
//        DailyWeatherView(day: day[0])
//    }
//}
