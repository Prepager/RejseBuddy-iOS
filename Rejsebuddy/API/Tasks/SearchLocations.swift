import SwiftUI
import Foundation

public class SearchLocations: ObservableObject {
    @Published var locations = [RPLocation]()
    
    func fetch(search: String) {
        // Generate URL for locations endpoint.
        let query = search != "" ? search : "Danmark"
        let url = Consumer.build(endpoint: "/location?input=" + query)
        
        // Request the generated endpoint.
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Skip if has no data.
            if error != nil || data == nil {
                return
            }
            
            // Attempt to aprse data.
            do {
                // Decode data into locations list object.
                let decoded = try JSONDecoder().decode(RPLocationList.self, from: data!)
                
                // Update locations on instance.
                DispatchQueue.main.async {
                    self.locations = decoded.locations
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
