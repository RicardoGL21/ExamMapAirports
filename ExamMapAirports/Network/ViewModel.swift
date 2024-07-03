//
//  ViewModel.swift
//  ExamMapAirports
//
//  Created by Ricardo Garcia on 02/07/24.
//

import Foundation

class ViewModel:ObservableObject {
    @Published var responseAirports:[ResponseAirportSearch]? = nil
    
    func getAirports(latitude:Double, longitude:Double, radio:Int) async throws {
        
        let headers = ["x-rapidapi-key": "01188370d5msh13d14625b80aaf5p1299b1jsn1d1c16ef7053","x-rapidapi-host": "aviation-reference-data.p.rapidapi.com"]
        
        var request = URLRequest(url: URL(string: "https://aviation-reference-data.p.rapidapi.com/airports/search?lat=\(latitude)&lon=\(longitude)&radius=\(radio)")!)
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                self.responseAirports = nil
            } else {
                if let dataJson = data {
                    self.responseAirports = try! JSONDecoder().decode([ResponseAirportSearch].self, from: dataJson)
                }
                
            }
        }).resume()
        
    }
    
}

enum ErrorsOfService:Error {
    case ErrorService
}
