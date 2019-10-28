import SwiftUI
import CoreData

struct ContactsView: View {
    @State var contacts: [Contact] = Contact.all()
    
    var body: some View {
        NavigationView {
            ForEach(contacts, id: \.self.objectID) { (contact) in
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
