import SwiftUI
import Combine
import Foundation

public class SearchLocations: ObservableObject {
    func fetch(search: String) -> AnyPublisher<RPLocationList, Error> {
        // Generate URL for locations endpoint.
        let query = search != "" ? search : "Danmark"
        let url = Consumer.build(endpoint: "/location?input=" + query)
        
        // Request the generated endpoint.
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: RPLocationList.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
