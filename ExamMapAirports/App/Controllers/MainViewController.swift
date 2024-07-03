//
//  ViewController.swift
//  ExamMapAirports
//
//  Created by Ricardo Garcia on 02/07/24.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    @IBOutlet weak var lblRadioNumber: UILabel!
    @IBOutlet weak var sliderRadio: UISlider!

    let locationManager = CLLocationManager()
    var userLatitude:Double?
    var userLongitude:Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //We ask the user of permission
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()

        //We move this block of code because this will have errors in the main thread waiting the response of the user, so we move to another thread
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                self.locationManager.startUpdatingLocation()
            }
        }
        
    }
    
    func showAlert(message:String) {
        let alert = UIAlertController(title: "Aviso", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderChangeValue(_ sender: Any) {
        self.lblRadioNumber.text = "\(Int(self.sliderRadio.value))"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //We search the id of the segue and send the data
        if (segue.identifier == "searchAirports") {
            let vc = segue.destination as! TabBarController
            vc.numberOfRadio = Int(self.sliderRadio.value)
            vc.userLatitude = self.userLatitude
            vc.userLongitude = self.userLongitude
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        //If we don't have the latitude or longitude of the user it's because the user didn't accept the permission
        if let weHaveLatitude = userLatitude, let weHaveLongitude = userLongitude {
            return true
        }
        
        self.showAlert(message: "Lo sentimos, para poder continuar necesitas otorgarnos permisos de localizacion.")
        return false
    }

}

extension MainViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let locValue: CLLocationCoordinate2D = manager.location?.coordinate {
            print("locations = \(locValue.latitude) \(locValue.longitude)")
            self.userLongitude = locValue.longitude
            self.userLatitude = locValue.latitude
        }
    }
}

