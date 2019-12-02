import SwiftUI

struct TripsView: View {
    @ObservedObject var from: Address = Address()
    @ObservedObject var to: Address = Address()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack(spacing: 18) {
                    VStack(alignment: .leading) {
                        InputLabel(text: "FROM")
                        HStack(spacing: 14) {
                            AddressInput(address: from)
                            UserLocation(address: from)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        InputLabel(text: "TO")
                        AddressInput(address: to).padding(.top, 8)
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(!from.valid() || !to.valid()
                                ? Color(red: 0, green: 0, blue: 0, opacity: 0.25)
                                : Color.blue
                            )
                        
                        NavigationLink(destination: TripsList(
                            origin: self.from,
                            destination: self.to
                        )) {
                            HStack {
                                Spacer()
                                
                                Text("Start Trip")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                                
                                Spacer()
                            }
                        }
                        .padding(10)
                        .layoutPriority(1)
                        .disabled(!from.valid() || !to.valid())
                    }
                }
                .zIndex(1)
                .padding(16)
                .background(Color.white)
                .clipped()
                .shadow(
                    color: Color(white: 0, opacity: 0.05),
                    radius: 4, y: 3
                )
                
                RecentsList()
            }
            .navigationBarTitle(
                Text("Trips"),
                displayMode: .inline
            )
        }
    }
}

struct TripsView_Previews: PreviewProvider {
    static var previews: some View {
        TripsView()
    }
}
