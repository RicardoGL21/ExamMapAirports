//
//  ListViewController.swift
//  ExamMapAirports
//
//  Created by Ricardo Garcia on 02/07/24.
//

import Foundation
import UIKit
import Combine

class ListViewController:UIViewController {
    
    @IBOutlet weak var tableViewAirports: UITableView!
    
    var delegate:TabBarController?
    var airports:[ResponseAirportSearch] = []
    var cancellable: AnyCancellable!
    
    override func viewDidLoad() {
        
        self.tableViewAirports.delegate = self
        self.tableViewAirports.dataSource = self
        self.tableViewAirports.register(UINib(nibName: "ItemAirportsTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemAirportsTableViewCell")
        
        //Here we observe changes in the variable responseAirports
        cancellable = delegate?.viewModel.$responseAirports.sink(receiveValue: {
            results in
            if let dataLocations = results {
                for location in dataLocations{
                    self.airports.append(location)
                }
                //We make this part in the thread main because we update the UI and UIKit isn't thread-safe and we don't want inconsistencies updating the UI
                DispatchQueue.main.async {
                    self.tableViewAirports.reloadData()
                }
            }
        })
        
    }
    
}

extension ListViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewAirports.dequeueReusableCell(withIdentifier: "ItemAirportsTableViewCell", for: indexPath) as? ItemAirportsTableViewCell
        
        cell?.lblAirportName.text = airports[indexPath.row].name
        cell?.lblLatitude.text = "Latitud: \(airports[indexPath.row].latitude ?? 0.0)"
        cell?.lblLongitude.text = "Longitud: \(airports[indexPath.row].longitude ?? 0.0)"
        
        return cell!
    }
    
    
}
