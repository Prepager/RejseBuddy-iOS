import SwiftUI
import CoreData

struct ContactsView: View {
    @State var contacts: [Contact] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(contacts, id: \.self.objectID) { (contact) in
                    ContactRow(contact: contact)
                }
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
        }.onAppear(perform: fetch)
    }
    
    func fetch() {
        self.contacts = Contact.all()
    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView()
    }
}
