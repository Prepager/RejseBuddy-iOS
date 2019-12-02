import Foundation

class RecentsSeeder {
    
    /**
     Populate app with recent entries.
     */
    static func populate() {
        Recent.create(
            origin: Address(
                name: "Købmagergade 52A, 1150 København",
                latitude: 55.681368,
                longitude: 12.5735938
            ),
            
            destination: Address(
                name: "Rådhusbuen 1, 4000 Roskilde",
                latitude: 55.6338374,
                longitude: 12.0863721
            )
        )

        Recent.create(
            origin: Address(
                name: "Anker Engelunds Vej 101A, 2800 Kgs. Lyngby",
                latitude: 55.7861137,
                longitude: 12.5230307
            ),
            
            destination: Address(
                name: "Lautrupvang 15, 2750 Ballerup",
                latitude: 55.7310935,
                longitude: 12.3948206
            )
        )
    }
    
}
