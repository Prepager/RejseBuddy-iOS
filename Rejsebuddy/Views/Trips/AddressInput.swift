import SwiftUI

struct AddressInput: View {
    @Binding var address: String
    @Binding var latitude: Int
    @Binding var longitude: Int
    
    var body: some View {
        VStack {
            TextField("Press to select location", text: $address)
            Divider()
        }
    }
}

struct AddressInput_Previews: PreviewProvider {
    static var previews: some View {
        AddressInput(
            address: .constant("DTU Lyngby"),
            latitude: .constant(Int(55.786489 * 1000000)),
            longitude: .constant(Int(12.5223509 * 1000000))
        )
    }
}
