//
//  ContentView.swift
//  meteoProject
//
//  Created by cyril perier on 12/06/2023.
//

import SwiftUI

struct ContentView: View {
    @State var isActive = false
    @State private var cities: [City] = []
    var body: some View {
        NavigationView {
            VStack {
                Text("Bonjour à vous")
                NavigationLink(destination: ForecastPage()) {
                    Label( "Voir la météo", systemImage: "weather")
                } .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



