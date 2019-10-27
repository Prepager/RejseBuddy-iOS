import SwiftUI

struct SettingsView: View {
    var body: some View {
        Button(action: self.importExampleData) {
            Text("TODO")
        }
    }
    
    func importExampleData() {
        Contact.create(
            name: "DTU Lyngby",
            address: "Anker Engelunds Vej 1, 2800 Kgs. Lyngby",
            latitude: Int(55.786489 * 1000000),
            longitude: Int(12.5223509 * 1000000)
        )
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
