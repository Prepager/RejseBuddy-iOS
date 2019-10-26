import SwiftUI

struct EditContact: View {
    var contact: Contact?
    
    var body: some View {
        Text("Viewing item: " + (contact?.name ?? "Creating"))
    }
}

struct EditContact_Previews: PreviewProvider {
    static var previews: some View {
        EditContact(contact: Contact(name: "Example"))
    }
}
