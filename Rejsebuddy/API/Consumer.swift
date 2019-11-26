import Foundation

struct Consumer {
    
    static var base: String = "http://xmlopen.rejseplanen.dk/bin/rest.exe"
    
    /**
     Build endpoint from base and force JSON format.
     */
    static func buildAddress(endpoint: String) -> String {
        return (Consumer.base + endpoint + "&format=json").addingPercentEncoding(
            withAllowedCharacters: CharacterSet.urlQueryAllowed
        )!
    }
    
    /**
     Build and return URL endpoint.
     */
    static func build(endpoint: String) -> URL {
        return URL.init(string: Consumer.buildAddress(endpoint: endpoint))!
    }
    
}
