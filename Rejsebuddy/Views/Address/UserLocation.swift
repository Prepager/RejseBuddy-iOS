import SwiftUI
import CoreLocation

struct UserLocation: View, LocationChangedDelegate {
    var address: Address
    var manager: LocationManager
    
    init(address: Address) {
        self.address = address
        
        self.manager = LocationManager()
        self.manager.delegate = self
    }

    var body: some View {
        Button(action: { self.manager.request() }) {
            Image(systemName: "location.fill")
                .font(.system(size: 20))
        }
    }
    
    func locationWasChanged(location: CLLocation) {
        self.address.name = NSLocalizedString("Your current location", comment: "")
        self.address.latitude = location.coordinate.latitude
        self.address.longitude = location.coordinate.longitude
    }
}

struct UserLocation_Previews: PreviewProvider {
    static var previews: some View {
        UserLocation(
            address: Address()
        )
    }
}
