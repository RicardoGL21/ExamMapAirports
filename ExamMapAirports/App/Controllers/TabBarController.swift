//
//  TabBarController.swift
//  ExamMapAirports
//
//  Created by Ricardo Garcia on 02/07/24.
//

import Foundation
import UIKit

class TabBarController:UITabBarController {
    
    var numberOfRadio:Int?
    var userLatitude:Double?
    var userLongitude:Double?
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        
        let mapVC = self.viewControllers?[0] as! MapViewController
        mapVC.delegate = self
        
        let tableVC = self.viewControllers?[1] as! ListViewController
        tableVC.delegate = self
        
        Task {
            do {
                try await viewModel.getAirports(latitude: userLatitude ?? 0.0, longitude: userLongitude ?? 0.0, radio: numberOfRadio ?? 50)
            } catch {
                self.showAlert(message: "Lo sentimos, hubo un error al consumir el servicio.")
            }
        }

    }
    
    func showAlert(message:String) {
        let alert = UIAlertController(title: "Aviso", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
