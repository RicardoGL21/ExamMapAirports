//
//  ResponseAirportSearch.swift
//  ExamMapAirports
//
//  Created by Ricardo Garcia on 02/07/24.
//

import Foundation

struct ResponseAirportSearch:Codable{
    let iataCode:String?
    let icaoCode:String?
    let name:String?
    let alpha2countryCode:String?
    let latitude:Double?
    let longitude:Double?
}
