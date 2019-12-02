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
    
    func locationWasChanged(address: Address) {
        self.address.set(address: address)
    }
}

struct UserLocation_Previews: PreviewProvider {
    static var previews: some View {
        UserLocation(
            address: Address()
        )
    }
}
