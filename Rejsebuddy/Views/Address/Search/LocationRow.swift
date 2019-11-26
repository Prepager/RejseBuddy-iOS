import SwiftUI

struct LocationRow: View {
    var location: RPLocation
    
    var body: some View {
        Text(self.location.name)
    }
}

struct LocationRow_Previews: PreviewProvider {
    static var previews: some View {
        LocationRow(location: RPLocation(
            id: "000010845",
            name: "Hovedbanegården, Tivoli",
            x: "12566488",
            y: "55672578"
        ))
    }
}
