import SwiftUI

struct TripsView: View {
    @State var from: String = ""
    @State var to: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 18) {
                // From
                VStack(alignment: .leading) {
                    InputLabel(text: "FROM")
                    HStack(spacing: 14) {
                        AddressInput(value: $from)
                        UserLocation(value: $from)
                    }
                }
                
                // To
                VStack(alignment: .leading) {
                    InputLabel(text: "TO")
                    AddressInput(value: $to)
                }
                
                // Start
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.blue)
                    
                    Button(action: startTrip) {
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
                }
                
                
                /*VStack {
                    RoundedRectangle(cornerRadius: 10) {
                        Button(action: startTrip) {
                            
                        }
                    }
                    
                        HStack {
                            Spacer()
                            Text("Start Trip")
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(10)
                    }
                }*/
            }
            .zIndex(1)
            .padding(16)
            .background(Color.white)
            .clipped()
            .shadow(
                color: Color(white: 0, opacity: 0.1),
                radius: 6, y: 4
            )
            
            // List
            Rectangle().fill(Color.white)
        }
    }
    
    func startTrip() {
        print("Start trip")
    }
}

struct TripsView_Previews: PreviewProvider {
    static var previews: some View {
        TripsView()
    }
}
