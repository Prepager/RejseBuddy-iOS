import SwiftUI

struct LocationRow: View {
    var location: RPLocation
    
    var body: some View {
        HStack {
            Image(systemName: location.getIcon())
                .frame(width: 24)
                .foregroundColor(.gray)
            
            Text(self.location.name)
                .font(.system(size: 14))
        }
    }
}

struct LocationRow_Previews: PreviewProvider {
    static var previews: some View {
        LocationRow(location: RPLocation(
            id: "000010845",
            name: "Hovedbanegården, Tivoli",
            type: RPLocation.LocationTypes.ADR,
            x: "12566488",
            y: "55672578"
        ))
    }
}
