import SwiftUI

struct UserLocation: View {
    @Binding var address: String
    @Binding var latitude: Int
    @Binding var longitude: Int

    var body: some View {
        Button(action: getLocation) {
            Image("location")
        }
    }
    
    func getLocation() {
        print("Get location")
    }
}

struct UserLocation_Previews: PreviewProvider {
    static var previews: some View {
        UserLocation(
            address: .constant(""),
            latitude: .constant(0),
            longitude: .constant(0)
        )
    }
}
