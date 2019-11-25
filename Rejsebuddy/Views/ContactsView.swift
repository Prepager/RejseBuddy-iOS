import SwiftUI
import CoreData

struct ContactsView: View {
    @FetchRequest(
        entity: Contact.entity(),
        sortDescriptors: [
            NSSortDescriptor(key: "name", ascending: true)
        ]
    ) var contacts: FetchedResults<Contact>
    
    var body: some View {
        NavigationView {
            List(contacts, id: \.self) { contact in
                ContactRow(contact: contact)
            }
            .navigationBarTitle("Contacts")
            .navigationBarItems(trailing:
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
