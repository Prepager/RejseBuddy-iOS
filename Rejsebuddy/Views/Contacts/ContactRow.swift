import SwiftUI

struct ContactRow: View {
    @ObservedObject var contact: Contact
    
    var body: some View {
        NavigationLink(destination: EditContact(contact: contact)) {
            HStack(spacing: 16) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 36))
                    .foregroundColor(Color.blue)
                
                VStack(alignment: .leading) {
                    Text(contact.name)
                        .bold()
                    
                    Text(contact.address)
                        .font(.caption)
                        .foregroundColor(Color.gray)
                }
            }.padding(.vertical, 8)
        }
    }
}

struct ContactRow_Previews: PreviewProvider {
    static var previews: some View {
        ContactRow(contact: Contact.example())
    }
}
