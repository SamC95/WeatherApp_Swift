//
//  WeatherMapViewModel.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//  Project modified by Sam Clark, w1854525
//  Project last modified: 08/12/2023
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavBar()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(WeatherMapViewModel())
    }
}
