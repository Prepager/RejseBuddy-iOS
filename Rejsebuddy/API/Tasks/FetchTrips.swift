import SwiftUI
import Combine
import Foundation

public class FetchTrips {
    func fetch(origin: Address, destination: Address) -> AnyPublisher<RPTripList, Error> {
        // Build endpoint from origin and destination address.
        var endpoint = "/trip"
        endpoint += "?originCoordY=" + (origin.latitude * 1000000).clean
        endpoint += "&originCoordX=" + (origin.longitude * 1000000).clean
        endpoint += "&originCoordName=" + origin.name
        endpoint += "&destCoordY=" + (destination.latitude * 1000000).clean
        endpoint += "&destCoordX=" + (destination.longitude * 1000000).clean
        endpoint += "&destCoordName=" + destination.name

        // Generate URL for trips endpoint.
        let url = Consumer.build(endpoint: endpoint)
        
        // Request the generated endpoint.
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: RPTripList.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
