import Foundation

class ContactsSeeder {
    
    /**
     Populate app with contact entries.
     */
    static func populate() {
        Contact.create(
            name: "Hjem",
            address: "Købmagergade 52A, 1150 København",
            latitude: 12575711,
            longitude: 55681279
        )

        Contact.create(
            name: "DTU Lyngby",
            address: "Anker Engelunds Vej 101A, 2800 Kgs. Lyngby",
            latitude: 12523277,
            longitude: 55785878
        )

        Contact.create(
            name: "DTU Ballerup",
            address: "Lautrupvang 15, 2750 Ballerup",
            latitude: 12396430,
            longitude: 55731197
        )

        Contact.create(
            name: "Roskilde",
            address: "Rådhusbuen 1, 4000 Roskilde",
            latitude: 12089197,
            longitude: 55633816
        )
    }
    
}
