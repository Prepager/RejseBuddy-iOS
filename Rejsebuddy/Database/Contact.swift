import CoreData
import Foundation

class Contact: Model {
    
    static var entity: String = "Contacts"
    
    @NSManaged var name: String
    @NSManaged var address: String
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    
    /**
     Returns all the contacts from database.
     */
    static func all() -> [Contact] {
        // Create request and fetch results.
        let request = self.request(entity: self.entity)
        return self.fetch(request: request) as! [Contact]
    }
    
    /**
     Creates new contact with passed data.
     */
    @discardableResult static func create(name: String, address: String, latitude: Double, longitude: Double) -> Contact {
        // Create contact and fill with passed data.
        let contact = Contact.instance(entity: self.entity) as! Contact
        contact.setValue(name, forKey: "name")
        contact.setValue(address, forKey: "address")
        contact.setValue(latitude, forKey: "latitude")
        contact.setValue(longitude, forKey: "longitude")
        
        // Save instance and return created.
        self.save()
        return contact
    }
    
    /**
     Updates passed contact instance with passed data.
     */
    @discardableResult func update(name: String, address: String, latitude: Double, longitude: Double) -> Contact {
        // Update values on passed instance.
        self.setValue(name, forKey: "name")
        self.setValue(address, forKey: "address")
        self.setValue(latitude, forKey: "latitude")
        self.setValue(longitude, forKey: "longitude")
        
        // Save instance and return updated.
        Contact.save()
        return self
    }
    
    /**
     Returns an address object instance.
     */
    func getAddress() -> Address {
        return Address(
            name: self.address,
            latitude: self.latitude,
            longitude: self.longitude
        )
    }
    
    /**
     Deletes the current contacts instance from the database.
     */
    func delete() {
        // Deletes contact instance.
        Contact.delete(instance: self);
    }
    
    /**
     Truncates the contacts table.
     */
    static func truncate() {
        for contact in Contact.all() {
            contact.delete()
        }
    }
    
    /**
     Returns contact example instance.
     */
    static func example() -> Contact {
        // Create contact with example data and return it.
        let contact = Contact.instance(entity: self.entity, context: nil) as! Contact
        contact.setValue("DTU Lyngby", forKey: "name")
        contact.setValue("Anker Engelunds Vej 1, 2800 Kgs. Lyngby", forKey: "address")
        contact.setValue(55.786489, forKey: "latitude")
        contact.setValue(12.5223509, forKey: "longitude")
        
        // Return the example instance.
        return contact
    }
    
}
