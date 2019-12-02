import CoreData
import Foundation

class Recent: Model {
    
    static var entity: String = "Recents"
    
    @NSManaged var date: Date
    
    @NSManaged var orig_address: String
    @NSManaged var orig_latitude: Double
    @NSManaged var orig_longitude: Double
    
    @NSManaged var dest_address: String
    @NSManaged var dest_latitude: Double
    @NSManaged var dest_longitude: Double
    
    /**
     Returns all the recents from database.
     */
    static func all() -> [Recent] {
        // Create request and fetch results.
        let request = self.request(entity: self.entity)
        return self.fetch(request: request) as! [Recent]
    }
    
    /**
     Creates new recent with passed data.
     */
    @discardableResult static func create(origin: Address, destination: Address) -> Recent {
        // Create recent and fill with passed data.
        let recent = Recent.instance(entity: self.entity) as! Recent
        recent.setValue(Date(), forKey: "date")
        
        recent.setValue(origin.name, forKey: "orig_address")
        recent.setValue(origin.latitude, forKey: "orig_latitude")
        recent.setValue(origin.longitude, forKey: "orig_longitude")
        
        recent.setValue(destination.name, forKey: "dest_address")
        recent.setValue(destination.latitude, forKey: "dest_latitude")
        recent.setValue(destination.longitude, forKey: "dest_longitude")
        
        // Save instance and return created.
        self.save()
        return recent
    }
    
    /**
     Updates passed recent instance with passed data.
     */
    @discardableResult func update(origin: Address, destination: Address) -> Recent {
        // Update values on passed instance.
        self.setValue(origin.name, forKey: "orig_address")
        self.setValue(origin.latitude, forKey: "orig_latitude")
        self.setValue(origin.longitude, forKey: "orig_longitude")
        
        self.setValue(destination.name, forKey: "dest_address")
        self.setValue(destination.latitude, forKey: "dest_latitude")
        self.setValue(destination.longitude, forKey: "dest_longitude")
        
        // Save instance and return updated.
        Recent.save()
        return self
    }
    
    /**
     Returns an origin address object instance.
     */
    func getOriginAddress() -> Address {
        return Address(
            name: self.orig_address,
            latitude: self.orig_latitude,
            longitude: self.orig_longitude
        )
    }
    
    /**
     Returns an destination address object instance.
     */
    func getDestinationAddress() -> Address {
        return Address(
            name: self.dest_address,
            latitude: self.dest_latitude,
            longitude: self.dest_longitude
        )
    }
    
    /**
     Deletes the current recents instance from the database.
     */
    func delete() {
        // Deletes recent instance.
        Recent.delete(instance: self);
    }
    
    /**
     Truncates the recents table.
     */
    static func truncate() {
        for recent in Recent.all() {
            recent.delete()
        }
    }
    
    /**
     Returns recent example instance.
     */
    static func example() -> Recent {
        // Create recent with example data and return it.
        let recent = Recent.instance(entity: self.entity, context: nil) as! Recent
        
        recent.setValue("Anker Engelunds Vej 1, 2800 Kgs. Lyngby", forKey: "orig_address")
        recent.setValue(55.786489, forKey: "orig_latitude")
        recent.setValue(12.5223509, forKey: "orig_longitude")
        
        recent.setValue("Lautrupvang 15, 2750 Ballerup", forKey: "dest_address")
        recent.setValue(55.7310935, forKey: "dest_latitude")
        recent.setValue(12.3948206, forKey: "dest_longitude")
        
        // Return the example instance.
        return recent
    }
    
}
