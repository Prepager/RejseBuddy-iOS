import SwiftUI
import CoreData

struct ContactsView: View {
    let contacts: [Contact] = Contact.all()
    
    var body: some View {
        NavigationView {
            ForEach(contacts, id: \.self.objectID) { (contact) in
                ContactRow(contact: contact)
            }
            .navigationBarTitle("Contacts")
            .navigationBarItems(trailing:
                NavigationLink(destination: EditContact()) {
                    HStack {
                        Image("plus")
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
