import Foundation

struct RPLocation: Decodable, Hashable {
    public var id: String?
    public var name: String
    public var x: String
    public var y: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
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
}
