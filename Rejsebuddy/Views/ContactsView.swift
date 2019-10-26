import SwiftUI

struct ContactsView: View {
    var body: some View {
        NavigationView {
            List(0..<30) { (item) in
                ContactRow(contact: Contact(name: "Index \(item)"))
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
