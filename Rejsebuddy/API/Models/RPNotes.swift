import Foundation

struct RPNotes: Decodable, Hashable {
    public var text: String
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
    }
}
