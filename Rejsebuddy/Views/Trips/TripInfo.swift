import SwiftUI
import Combine

struct TripInfo: View {
    var trip: RPTrip
    
    var body: some View {
        VStack(spacing: 0) {
            TripRow(trip: self.trip)
                .zIndex(1)
                .padding(16)
                .background(Color.white)
                .clipped()
                .shadow(
                    color: Color(white: 0, opacity: 0.05),
                    radius: 4, y: 3
                )
            
            List(self.trip.steps, id: \.self) { step in
                StepRow(step: step).listRowInsets(EdgeInsets())
            }
        }
        .navigationBarTitle(
            Text("Trip"),
            displayMode: .inline
        )
    }
}

struct TripInfo_Previews: PreviewProvider {
    static var previews: some View {
        Text("@wip")
        /*TripsList(
            origin: Address(),
            destination: Address()
        )*/
    }
}
