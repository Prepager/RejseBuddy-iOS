import Foundation

struct RPStep: Decodable, Hashable {
    public var name: String
    public var type: String
    public var origin: RPLine
    public var destination: RPLine
    public var notes: RPNotes
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case type = "type"
        case origin = "Origin"
        case destination = "Destination"
        case notes = "Notes"
    }
    
    func getStops() -> Int {
        return Int(self.destination.routeIdx!)! - Int(self.origin.routeIdx!)!
    }
    
    func getDuration() -> TimeInterval {
        return self.destination.getDate().timeIntervalSince(self.origin.getDate())
    }
    
    func getLineDirection() -> String {
        let notes = self.notes.text.split(separator: ";")
        
        return notes.first { note -> Bool in
            return note.starts(with: "Retning")
        }!.replacingOccurrences(of: "Retning: ", with: "")
    }
}
