import SwiftUI
import CoreData

struct ContactsView: View {
    var manager = LocationManager()
    @State var editing: Bool = false
    
    @FetchRequest(
        entity: Contact.entity(),
        sortDescriptors: [
            NSSortDescriptor(key: "name", ascending: true)
        ]
    ) var contacts: FetchedResults<Contact>
    
    init() {
        self.manager.start()
    }
    
    var body: some View {
        NavigationView {
            List(contacts, id: \.self) { contact in
                if self.editing || self.manager.address == nil {
                    NavigationLink(destination: EditContact(contact: contact)) {
                        ContactRow(contact: contact)
                    }
                } else {
                    NavigationLink(destination: TripsList(
                        origin: self.manager.address!,
                        destination: contact.getAddress()
                    )) {
                        ContactRow(contact: contact)
                    }
                }
            }
            .navigationBarTitle("Contacts")
            .navigationBarItems(
                leading:
                    Button(action: { self.editing.toggle() }) {
                        if self.editing {
                            Text("Show")
                        } else {
                            Text("Edit")
                        }
                    },
                
                trailing:
                    NavigationLink(destination: EditContact()) {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add")
                        }
                    }
            )
        }
    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView()
    }
}
