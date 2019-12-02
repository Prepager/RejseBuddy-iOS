import SwiftUI
import Contacts
import CoreLocation

struct SettingsView: View {
    @State var contactsList = [CNContact]()
    
    @State var contacts: Bool = false
    @State var imported: Bool = false
    @State var truncated: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                // Contacts
                Button(action: self.importContacts) {
                    HStack(spacing: 16) {
                        Image(systemName: "person.crop.circle.badge.plus")
                            .font(.system(size: 34))
                            .foregroundColor(Color.green)
                            .frame(width: 40)
                        
                        VStack(alignment: .leading) {
                            Text("Import contacts")
                                .bold()
                            
                            Text("Imports all your contacts with an address")
                                .font(.caption)
                                .foregroundColor(Color.gray)
                        }
                    }.padding(.vertical, 8)
                }
                .alert(isPresented: $contacts) {
                    Alert(title: Text("Data Imported"))
                }
                
                // Import
                Button(action: self.importExampleData) {
                    HStack(spacing: 16) {
                        Image(systemName: "square.and.arrow.down.fill")
                            .font(.system(size: 34))
                            .foregroundColor(Color.blue)
                            .frame(width: 40)
                        
                        VStack(alignment: .leading) {
                            Text("Import example data")
                                .bold()
                            
                            Text("Imports example contacts and recent trips")
                                .font(.caption)
                                .foregroundColor(Color.gray)
                        }
                    }.padding(.vertical, 8)
                }
                .alert(isPresented: $imported) {
                    Alert(title: Text("Data Imported"))
                }
                
                // Delete
                Button(action: self.deleteAppData) {
                    HStack(spacing: 16) {
                        Image(systemName: "trash.fill")
                            .font(.system(size: 34))
                            .foregroundColor(Color.red)
                            .frame(width: 40)
                        
                        VStack(alignment: .leading) {
                            Text("Delete application data")
                                .bold()
                            
                            Text("This action is irreversible once completed")
                                .font(.caption)
                                .foregroundColor(Color.gray)
                        }
                    }.padding(.vertical, 16)
                }
                .alert(isPresented: $truncated) {
                    Alert(title: Text("Data Deleted"))
                }
            }.navigationBarTitle("Settings")
        }
    }
    
    /**
     Parse a phone contact into app contact format.
     */
    func parseContact(contact: CNContact) {
        // Get contact postal address.
        let value = contact.postalAddresses[0].value
        let address = "\(value.street), \(value.city) \(value.postalCode), \(value.country)"
        
        // Request coordinates for found address.
        CLGeocoder().geocodeAddressString(address) { (placemarks, error) in
            // Create contact if place was found.
            if error == nil && placemarks != nil && placemarks?.first != nil {
                Contact.create(
                    name: CNContactFormatter.string(from: contact, style: .fullName)!,
                    address: address,
                    latitude: placemarks!.first!.location!.coordinate.latitude,
                    longitude: placemarks!.first!.location!.coordinate.longitude
                )
            }
            
            // Continue to next element if has items or show success.
            if self.contactsList.count > 1 {
                self.contactsList.removeFirst()
                self.parseContact(contact: self.contactsList.first!)
            } else {
                self.contactsList.removeAll()
                self.contacts.toggle()
            }
        }
    }
    
    /**
     Attempt to import contacts
     */
    func importContacts() {
        // Create contact store instance.
        let store = CNContactStore()
        
        // Request contacts access from user.
        store.requestAccess(for: .contacts) { (granted, error) in
            // Skip if not granted.
            if !granted {
                print("Permission Denied")
                return
            }
            
            // Define request keys.
            let keys = [
                CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
                CNContactPostalAddressesKey as CNKeyDescriptor
            ]
            
            // Define holder variable and create fetch rquest.
            var contacts = [CNContact]()
            let request = CNContactFetchRequest(keysToFetch: keys)
            
            // Attempt to fetch contacts.
            do {
                try store.enumerateContacts(with: request) { (contact, stop) in
                    // Skip if has no postal address.
                    if contact.postalAddresses.count == 0 {
                        return
                    }
                    
                    // Append the contact to the list.
                    contacts.append(contact)
                }
            } catch {
                dump(error)
            }
            
            // Show finished if empty.
            if contacts.count == 0 {
                self.contacts.toggle()
                return
            }
            
            // Save contacts and start parser.
            self.contactsList = contacts
            self.parseContact(contact: contacts.first!)
        }
    }
    
    /**
     Imports example contacts and recent trips.
     */
    func importExampleData() {
        ContactsSeeder.populate()
        RecentsSeeder.populate()
        
        self.imported.toggle()
    }
    
    /**
     Deletes all application data.
     */
    func deleteAppData() {
        Contact.truncate()
        Recent.truncate()
        
        self.truncated.toggle()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
