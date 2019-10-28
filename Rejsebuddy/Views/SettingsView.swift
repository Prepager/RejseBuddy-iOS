import SwiftUI

struct SettingsView: View {
    @State var imported: Bool = false
    @State var truncated: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                // Import
                Button(action: self.importExampleData) {
                    HStack(spacing: 16) {
                        Image(systemName: "square.and.arrow.down.fill")
                            .font(.system(size: 36))
                            .foregroundColor(Color.blue)
                        
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
                            .font(.system(size: 36))
                            .foregroundColor(Color.red)
                        
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
     Imports example contacts and recent trips.
     */
    func importExampleData() {
        ContactsSeeder.populate()
        self.imported.toggle()
    }
    
    /**
     Deletes all application data.
     */
    func deleteAppData() {
        Contact.truncate()
        self.truncated.toggle()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
