import SwiftUI
import Foundation

struct RPTripList: Decodable {
    public var trips: [RPTrip] = []

    enum CodingKeys: String, CodingKey {
        case list = "TripList"
        case inner = "Trip"
        case leg = "Leg"
    }
    
    init(from decoder: Decoder) throws {
        // Decode top level container and list.
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let list = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .list)
        
        // Decode inner list.
        var inner = try list.nestedUnkeyedContainer(forKey: .inner)
        
        // Prepare holder array.
        var trips: [RPTrip] = []
        
        // Loop through inner elements and parse trips.
        while !inner.isAtEnd {
            trips += [try inner.decode(RPTrip.self)]
        }
        
        // Save trips on instance.
        self.trips = trips
    }
}
