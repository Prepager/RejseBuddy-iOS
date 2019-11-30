import Foundation

struct RPTrip: Decodable, Hashable {
    public var steps = [RPStep]()
    
    enum CodingKeys: String, CodingKey {
        case steps = "Leg"
    }
    
    func originLine() -> RPLine {
        return steps.first!.origin
    }
    
    func destinationLine() -> RPLine {
        return steps.last!.destination
    }
}
