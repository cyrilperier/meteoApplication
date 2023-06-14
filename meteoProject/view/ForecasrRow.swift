//
//  ForecasrRow.swift
//  meteoProject
//
//  Created by cyril perier on 13/06/2023.
//

import SwiftUI

struct ForecasrRow: View {
   var city: City
    var width: CGFloat = 320
    var height: CGFloat = 40
    @State var forecast = "☀️"
    var body: some View {
        RoundedRectangle(cornerRadius: height,style: .continuous)
            .frame(width:width,height: height)
            .foregroundColor(Color.blue.opacity(0.1))
            .overlay(
                HStack(){
                    Text(city.name)
                
            Text(forecast)
                .onAppear{
                    switch city.weather[0].main{
                    case "Rain" :
                        forecast = "🌧"
                    case "Clear" :
                        forecast = "☀️"
                    case "Clouds":
                        forecast = "☁️"
                    default :
                        forecast = ""
                    }
                
            }
            Text("\(city.main.temp.description) °c")
         
        })
    }
}

struct ForecasrRow_Previews: PreviewProvider {
    static var previews: some View {
        ForecasrRow(city: City(id: 1, name: "Londre", weather: [Weather(main: "Clear")], main: Main(temp: 10.0)))
    }
}
