import Foundation

struct RPLocation: Decodable, Hashable {
    public var id: String?
    public var name: String
    public var type: LocationTypes? = LocationTypes.STP
    public var x: String
    public var y: String
    
    enum LocationTypes: String, Decodable {
        case STP // Stop
        case ADR // Address
        case POI // Point of interest
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case type = "type"
        case x = "x"
        case y = "y"
    }

    func getAddress() -> Address {
        return Address(
            name: self.name,
            latitude: Double(self.x)! / 1000000,
            longitude: Double(self.y)! / 1000000
        )
    }
    
    func getIcon() -> String {
        if self.type == nil {
            return "largecircle.fill.circle"
        }
        
        switch self.type! {
            case .ADR: return "house"
            case .POI: return "pin"
            default: return "largecircle.fill.circle"
        }
    }
}
