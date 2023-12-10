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
        VStack(alignment: .leading, spacing: 5) {
            Text(formattedDate)
                .font(.body)
                .padding(.horizontal)
                .padding(.vertical)
                .foregroundColor(.black)

            Text("Add style & other elements")
                .frame(width: 125)
                .font(.body)
                .multilineTextAlignment(.leading)
                .lineLimit(nil) 
                .padding(.horizontal)
                .padding(.vertical)
                .foregroundColor(.black)
        }
        .background(Color.blue)
        .cornerRadius(5)    }
}




