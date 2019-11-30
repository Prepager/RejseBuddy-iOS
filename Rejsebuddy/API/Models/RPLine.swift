import Foundation

struct RPLine: Decodable, Hashable {
    public var name: String
    public var type: String
    public var routeIdx: String?
    
    // Expected
    public var time: String
    public var date: String
    public var track: String?
    
    // Real-time
    public var rtTime: String?
    public var rtDate: String?
    public var rtTrack: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case type = "type"
        case routeIdx = "routeIdx"
        
        case time = "time"
        case date = "date"
        case track = "track"
        
        case rtTime = "rtTime"
        case rtDate = "rtDate"
        case rtTrack = "rtTrack"
    }
    
    func getDate() -> Date {
        // Create date formatter and define settings.
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy HH:mm"
        formatter.timeZone = TimeZone.init(identifier: "Europe/Copenhagen")
        formatter.locale = Locale.current
        
        // Parse the instance date and time.
        return formatter.date(from: self.date + " " + self.time)!
    }
}
