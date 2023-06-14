//
//  ForecastPage.swift
//  meteoProject
//
//  Created by cyril perier on 12/06/2023.
//

import SwiftUI

struct ForecastPage: View {
    @State private var cities: [City] = []
    @State var percent: CGFloat = 0
    @State var timeout: Double = 0
    @State private var showData = false
    @State var waitingMessage = "Nous téléchargeons les données"
    @State private var timer: Timer?
    @State private var error : Error? = nil
    @State private var isDisabled = true
    
    let interval: Double = 10
    let intervalMessage: Double = 6
    
    let choosenCities = ["rennes","paris","nantes","bordeaux","Lyon"]
    let waitingMessages = ["Nous téléchargeons les données","C’est presque fini","Plus que quelques secondes avant d’avoir le résultat"]
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.vertical,showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    if showData {
                        ForEach(cities) { city in
                            ForecasrRow(city: city)
                        }
                    }
                }
                .frame(height: 185)
                .padding(.top, 40) 
            }
            VStack {
                if !showData  && error == nil {
                    Text(waitingMessage).onAppear {
                        choosenCities.forEach { city in
                            DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
                                fetchData(city: city)
                            }
                            timeout += interval
                        }
                        timer = Timer.scheduledTimer(withTimeInterval: intervalMessage, repeats: true) { timer in
                            if let index = waitingMessages.firstIndex(of: waitingMessage) {
                                let nextIndex = (index + 1) % waitingMessages.count
                                waitingMessage = waitingMessages[nextIndex]
                            }
                            if showData {
                                self.timer?.invalidate()
                                self.timer = nil
                            }
                        }
                    }.disabled(isDisabled)
                    ProgressBar(width: 300,height: 30, percent: percent,color1: Color.blue,color2:Color.purple ).animation(.spring())
                } else {
                    Text(error?.localizedDescription ?? "")
                    Button(action: {
                        showData = false
                        cities = []
                        percent = 0
                        timeout = 0
                        error = nil
                        isDisabled.toggle()
                               }) {
                                   Text("Recommencer")
                                       .font(.headline)
                                           .foregroundColor(.white)
                                           .padding()
                                           .background(Color.blue)
                                           .cornerRadius(10)
                               }
                }
            }
        }
    }
    
    
    private func fetchData(city: String) {
        //Parse URL
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=a29a7e69a4cc6c3db1ee9f0fa482e1bf&units=metric") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    //Parse JSON
                    let decodedData = try JSONDecoder().decode(City.self, from: data)
                    self.cities.append(decodedData)
                    self.percent = Double(self.cities.count) * (100/(Double(choosenCities.count)))
                    if percent  == 100 {
                        showData = true
                    }
                } catch {
                    //Print JSON decoding error
                    self.error = error
                    print("Error decoding JSON: \(error)")
                }
            } else if let error = error {
                //Print API call error
                self.error = error
                print("Error fetching data: \(error.localizedDescription)")
            }
        }.resume()
    }
}

struct ForecastPage_Previews: PreviewProvider {
    static var previews: some View {
        ForecastPage()
    }
}

