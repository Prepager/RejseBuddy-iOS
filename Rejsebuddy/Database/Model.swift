import UIKit
import CoreData
import Foundation

class Model: NSManagedObject {
    
    /**
     Returns the current application context.
     */
    static func getContext() -> NSManagedObjectContext {
        // Attempts to retrieve the application delegate.
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Couldn't get context")
        }
        
        // Returns the container view context.
        return delegate.persistentContainer.viewContext
    }
    
    /**
     Initiates and returns a fetch request instance.
     */
    static func request(entity: String) -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest.init(entityName: entity);
    }
    
    /**
     Returns a entity descriptor for the passed entity.
     */
    static func entity(entity: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entity, in: self.getContext())!
    }
    
    /**
     Returns an initialized entity instance for a configurable application context.
     */
    static func instance(entity: String, context: NSManagedObjectContext?) -> Model {
        return Model(entity: self.entity(entity: entity), insertInto: context)
    }
    
    /**
     Returns an initialized entity instance for the default application context.
     */
    static func instance(entity: String) -> Model {
        return self.instance(entity: entity, context: self.getContext())
    }
    
    /**
     Deletes the passed instance from the default application context.
     */
    static func delete(instance: Model) {
        self.getContext().delete(instance)
    }
    
    /**
     Attempts to save the default application context.
     */
    static func save() {
        do {
            try self.getContext().save()
        } catch {
            print(error)
            fatalError("Couldn't save model")
        }
    }
    
    /**
     Attempts to execute the passed request on the default application context.
     */
    static func execute(request: NSPersistentStoreRequest) {
        do {
            try self.getContext().execute(request)
        } catch {
            print(error)
            fatalError("Couldn't save model")
        }
    }
    
    /**
     Attempts to fetch and return the passed fetch request.
     */
    static func fetch(request: NSFetchRequest<NSFetchRequestResult>) -> [Any] {
        do {
            return try self.getContext().fetch(request)
        } catch {
            print(error)
            fatalError("Couldn't query model")
        }
    }
    
    /**
     Fix manged object not sending observed object changes.
     @see https://twitter.com/konstantinbe/status/1166423609348427778
     */
    override public func willChangeValue(forKey key: String) {
        super.willChangeValue(forKey: key);
        self.objectWillChange.send();
    }
    
}
