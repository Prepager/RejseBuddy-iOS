import Combine
import SwiftUI
import Foundation
import CoreLocation

protocol LocationChangedDelegate {
    func locationWasChanged(location: CLLocation)
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var wasRequested = false
    
    var delegate: LocationChangedDelegate?
    var manager: CLLocationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.manager.delegate = self
    }
    
    /**
     Request permissionn when in app and request current location.
     */
    func request() {
        self.wasRequested = true
        self.manager.requestWhenInUseAuthorization()
        self.manager.requestLocation()
    }
    
    /**
     Listen for location manager location updates.
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.delegate?.locationWasChanged(location: locations.last!)
    }
    
    /**
     Listen for location manager authorization changes.
     */
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if self.wasRequested {
            self.request()
        }
    }
    
    /**
     Listen for location manager failure errors.
     */
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Swift.Error) {
        dump(error)
    }
    
}
