import SwiftUI
import Foundation

struct RPLocationList: Decodable {
    public var locations: [RPLocation] = []
    
    public var stops: UnkeyedDecodingContainer?
    public var coords: UnkeyedDecodingContainer?
    
    enum CodingKeys: String, CodingKey {
        case list = "LocationList"
        case stops = "StopLocation"
        case coords = "CoordLocation"
    }
    
    init(from decoder: Decoder) throws {
        // Decode top level container and list.
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let list = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .list)
        
        // Decode stop locations.
        if list.contains(.stops) {
            self.stops = try list.nestedUnkeyedContainer(forKey: .stops)
        }
        
        // Decode coordinate locations.
        if list.contains(.coords) {
            self.coords = try list.nestedUnkeyedContainer(forKey: .coords)
        }
        
        // Prepare holder array.
        var locations: [RPLocation] = []
        
        // Parse stop nodes into locations.
        while (self.stops != nil && !self.stops!.isAtEnd) {
            locations += [try self.stops!.decode(RPLocation.self)]
        }
        
        // Parse coords nodes into locations.
        while (self.coords != nil && !self.coords!.isAtEnd) {
            locations += [try self.coords!.decode(RPLocation.self)]
        }
        
        // Update locations list.
        self.locations = locations
    }
}
