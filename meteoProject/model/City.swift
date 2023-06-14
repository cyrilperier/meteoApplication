//
//  City.swift
//  meteoProject
//
//  Created by cyril perier on 12/06/2023.
//

import Foundation

struct City: Codable, Identifiable  {
    
    let id : Int
    let name: String
    let weather: [Weather]
    let main: Main
    
}

struct Main : Codable {
    let temp : Double
}

struct Weather : Codable {

    let main : String
    
 
}

