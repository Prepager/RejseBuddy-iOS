import Foundation

class ContactsSeeder {
    
    /**
     Populate app with contact entries.
     */
    static func populate() {
        Contact.create(
            name: "Hjem",
            address: "Købmagergade 52A, 1150 København",
            latitude: 55.681368,
            longitude: 12.5735938
        )

        Contact.create(
            name: "DTU Lyngby",
            address: "Anker Engelunds Vej 101A, 2800 Kgs. Lyngby",
            latitude: 55.7861137,
            longitude: 12.5230307
        )

        Contact.create(
            name: "DTU Ballerup",
            address: "Lautrupvang 15, 2750 Ballerup",
            latitude: 55.7310935,
            longitude: 12.3948206
        )

        Contact.create(
            name: "Roskilde",
            address: "Rådhusbuen 1, 4000 Roskilde",
            latitude: 55.6338374,
            longitude: 12.0863721
        )
    }
    
}
