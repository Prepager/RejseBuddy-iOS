import Foundation

class Address: ObservableObject {
    @Published var name: String = ""
    @Published var latitude: Double = 0
    @Published var longitude: Double = 0
    
    init() {
        // Left blank intentionally.
    }
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func set(address: Address) {
        self.name = address.name
        self.latitude = address.latitude
        self.longitude = address.longitude
    }
    
    func valid() -> Bool {
        return self.latitude != 0 && self.longitude != 0
    }
}
