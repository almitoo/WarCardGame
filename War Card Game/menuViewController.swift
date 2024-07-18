//
//  ViewController.swift
//  War Card Game
//
//  Created by Student14 on 24/06/2024.
//
import CoreLocation
import UIKit

class menuViewController: UIViewController , CLLocationManagerDelegate {
    
    @IBOutlet weak var eastImageView: UIImageView!
    
    @IBOutlet weak var westImageView: UIImageView!
    
   
    @IBOutlet weak var inputFueld: UITextField!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    let locationManager = CLLocationManager()
    let referenceLongitude = 34.817549168324334
    var isEastLocation: Bool = false
        
    
    override func viewDidLoad() {
           super.viewDidLoad()
           
           // Initial setup
           setupNameLabelAndInputField()
           
           // Setup location manager
           locationManager.delegate = self
           locationManager.requestWhenInUseAuthorization()
           locationManager.startUpdatingLocation()
       }

       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           // Hide input field if the name is already set
           if UserDefaults.standard.string(forKey: "myDataName") != nil {
               inputFueld.isHidden = true
           }
       }

       private func setupNameLabelAndInputField() {
           if let storedName = UserDefaults.standard.string(forKey: "myDataName") {
               nameLabel.text = storedName
           } else {
               nameLabel.text = "Insert name"
           }
       }

    @IBAction func startButton(_ sender: Any) {
        // Get the name from the text field, default to "Player" if empty
        let name = inputFueld.text?.isEmpty == true ?  UserDefaults.standard.string(forKey: "myDataName") : inputFueld.text!
        nameLabel.text = name
        UserDefaults.standard.set(name, forKey: "myDataName")
        
        
        
        inputFueld.isHidden = true

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            vc.playerName = name // Pass the player's name to the next view controller
            vc.isEastLocation = isEastLocation
            self.present(vc, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let location = locations.last else { return }
           let longitude = location.coordinate.longitude
           
           if longitude > referenceLongitude {
               isEastLocation = true
               eastImageView.isHidden = false
               westImageView.isHidden = true
           } else {
               isEastLocation = false
               eastImageView.isHidden = true
               westImageView.isHidden = false
           }
           
           // Stop updating location to save battery
           locationManager.stopUpdatingLocation()
       }
       
       // Handle authorization status changes
       func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           if status == .authorizedWhenInUse || status == .authorizedAlways {
               locationManager.startUpdatingLocation()
           }
       }
       
       // Handle location manager errors
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
        
        
    }
    
    
    
}


