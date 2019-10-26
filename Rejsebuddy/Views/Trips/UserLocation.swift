import SwiftUI

struct UserLocation: View {
    @Binding var value: String

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
        UserLocation(value: .constant(""))
    }
}
