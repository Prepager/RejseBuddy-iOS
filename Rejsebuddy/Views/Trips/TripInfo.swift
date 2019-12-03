import SwiftUI
import Combine

struct TripInfo: View {
    var trip: RPTrip
    var manager = NotificationManager()
    
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
        .onAppear {
            // Request notification authorization.
            self.manager.request {
                // Loop through the trip steps.
                self.trip.steps.forEach { step in
                    
                    print(Calendar.current.date(
                        byAdding: .second,
                        value: (10 * ((self.trip.steps.firstIndex(of: step) ?? 0) + 1)),
                        to: Date()
                    )!)
                    
                    // Schedule change notification.
                    self.manager.schedule(
                        id: UUID().uuidString,
                        title: NSLocalizedString("Change Line", comment: "") + ": " + step.name,
                        text: step.origin.name,
                        date: step.origin.getDate().addingTimeInterval(-60.0)
                        
                        /* DEMO: date: Calendar.current.date(
                            byAdding: .second,
                            value: (5 * ((self.trip.steps.firstIndex(of: step) ?? 0) + 1)),
                            to: Date()
                        )!*/
                    )
                }
            }
        }
        .onDisappear {
            // Unschedule all pending notifications.
            self.manager.removeAll()
        }
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
