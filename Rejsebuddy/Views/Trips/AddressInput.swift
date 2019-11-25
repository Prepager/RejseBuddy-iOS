import SwiftUI

struct AddressInput: View {
    @State var todo: String = ""
    @ObservedObject var address: Address
    
    var body: some View {
        VStack {
            Button(action: { /* @wip */ }) {
                if address.name == "" {
                    Text("Press to select location")
                        .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.25))
                } else {
                    Text(self.address.name)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            
            Divider()
        }
    }
}

struct AddressInput_Previews: PreviewProvider {
    static var previews: some View {
        AddressInput(
            address: Address(
                name: "Anker Engelunds Vej 101A, 2800 Kgs. Lyngby",
                latitude: 12523277,
                longitude: 55785878
            )
        )
    }
}
