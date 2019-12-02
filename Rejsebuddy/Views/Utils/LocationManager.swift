import Combine
import SwiftUI
import Foundation
import CoreLocation

protocol LocationChangedDelegate {
    func locationWasChanged(address: Address)
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var wasRequested = false
    
    @Published var address: Address?
    @Published var location: CLLocation?
    @Published var authorization: CLAuthorizationStatus?
    
    var delegate: LocationChangedDelegate?
    
    var geocoder = CLGeocoder()
    var manager = CLLocationManager()
    
    override init() {
        super.init()
        self.manager.delegate = self
    }
    
    deinit {
        self.stop()
    }
    
    /**
     Start updating location.
     */
    func start() {
        self.wasRequested = true
        self.manager.requestWhenInUseAuthorization()
        self.manager.startUpdatingLocation()
    }
    
    /**
     Stop updating location.
     */
    func stop() {
        self.manager.stopUpdatingLocation()
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
     Parse found location into address.
     */
    func parseLocation(completion: @escaping (Address) -> Void) {
        self.address = Address()
        self.address!.name = NSLocalizedString("Your current location", comment: "")
        self.address!.latitude = self.location!.coordinate.latitude
        self.address!.longitude = self.location!.coordinate.longitude
        
        self.lookupLocation(location: self.location!) { placemarker in
            if placemarker != nil && placemarker?.name != nil {
                self.address!.name = placemarker!.name!
            }
            
            completion(self.address!)
        }
    }
    
    /**
     Calculate distance between current and passed location.
     */
    func distanceTo(address: Address) -> Double {
        if self.location == nil {
            return 0
        }
        
        return self.location!.distance(from: CLLocation(
            latitude: address.latitude,
            longitude: address.longitude
        ))
    }
    
    /**
     Listen for location manager location updates.
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last!
        
        self.parseLocation() { address in
            self.delegate?.locationWasChanged(address: address)
        }
    }
    
    /**
     Listen for location manager authorization changes.
     */
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorization = status
        
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
    
    /**
     Lookup address for the passed location coordinates.
     */
    func lookupLocation(location: CLLocation, completion: @escaping (CLPlacemark?) -> Void) {
        self.geocoder.reverseGeocodeLocation(location) { (placemarkers, error) in
            completion(placemarkers?[0])
        }
    }
    
}
