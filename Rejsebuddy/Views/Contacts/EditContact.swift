import UIKit
import SwiftUI

struct EditContact: View {
    @Environment(\.presentationMode) var presenter
    @ObservedObject var keyboard: Keyboard = Keyboard()
    
    var contact: Contact?
    
    @State var name: String = ""
    @ObservedObject var address: Address = Address()

    var body: some View {
        HStack {
            VStack(spacing: 18) {
                // Name
                VStack(alignment: .leading) {
                    InputLabel(text: "NAME")
                    Input(placeholder: "TODO", value: $name)
                }
                
                // Address
                VStack(alignment: .leading) {
                    InputLabel(text: "ADDRESS")
                    AddressInput(address: address).padding(.top, 8)
                }
                
                // Spacer
                Spacer()
                
                // Actions
                HStack {
                    // Delete
                    if contact != nil {
                        Button(action: deleteContact) {
                            Image(systemName: "trash")
                                .font(.system(size: 25))
                                .foregroundColor(Color.red)
                        }
                        .padding(10)
                    }
                    
                    // Save/Create
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.blue)
                            
                            Button(action: saveContact) {
                                HStack {
                                    Spacer()
                                    
                                    Text(contact != nil ? "Save Contact" : "Create Contact")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.white)
                                    
                                    Spacer()
                                }
                            }
                            .padding(10)
                            .layoutPriority(1)
                    }
                }
            }
        }
        .padding(16)
        .padding(.bottom, self.keyboard.height)
        .onAppear(perform: self.bind)
        .navigationBarTitle(
            self.contact != nil
                ? Text(self.contact!.name)
                : Text("Create Contact"),

            displayMode: .inline
        )
        .navigationBarItems(trailing: (
            Button(action: { self.saveContact() }) {
                Text("Save")
            }
        ))
    }
    
    /**
     Bind the contact instance values to the view.
     */
    func bind() {
        // Skip if has no instance.
        if (self.contact == nil) {
            return
        }
        
        // Set contact values on instance.
        self.name = self.contact!.name
        self.address.set(address: self.contact!.getAddress())
    }
    
    /**
     Saves existing or creates new contact with view data.
     */
    func saveContact() {
        // Check if contact is available.
        if (self.contact != nil) {
            // Update current contact.
            self.contact?.update(
                name: self.name,
                address: self.address.name,
                latitude: self.address.latitude,
                longitude: self.address.longitude
            )
        } else {
            // Create new contact.
            Contact.create(
                name: self.name,
                address: self.address.name,
                latitude: self.address.latitude,
                longitude: self.address.longitude
            )
        }
        
        // Return back to contacts list.
        self.goBack()
    }
    
    /**
     Deletes current contact form database.
     */
    func deleteContact() {
        // Delete contact from database.
        self.contact?.delete()
        
        // Return back to contacts list.
        self.goBack()
    }
    
    /**
     Returns to the contacts list.
     */
    func goBack() {
        self.presenter.wrappedValue.dismiss()
    }
}

struct EditContact_Previews: PreviewProvider {
    static var previews: some View {
        EditContact(contact: Contact.example())
    }
}
