import SwiftUI

struct TripsView: View {
    @ObservedObject var from: Address = Address()
    @ObservedObject var to: Address = Address()
    
    // Hidden state cannot be changed from child views.
    // @see https://stackoverflow.com/a/57518324
    @State var isNavbarHidden: Bool = true
    
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
                        
                        NavigationLink(destination: ConnectionsList(isNavbarHidden: $isNavbarHidden)) {
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
                    color: Color(white: 0, opacity: 0.1),
                    radius: 6, y: 4
                )
                
                Rectangle().fill(Color.white)
            }
            .navigationBarHidden(isNavbarHidden)
            .navigationBarTitle(Text("Trips"))
            .onAppear {
                self.isNavbarHidden = true
            }
        }
    }
}

struct TripsView_Previews: PreviewProvider {
    static var previews: some View {
        TripsView()
    }
}
