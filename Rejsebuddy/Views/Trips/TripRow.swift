import SwiftUI

struct TripRow: View {
    var trip: RPTrip
    
    var orig: RPLine
    var dest: RPLine
    
    var changes: Int
    var duration: TimeInterval
    
    init(trip: RPTrip) {
        // Save trip on instance.
        self.trip = trip
        
        // Create origin and destination shortcuts.
        self.orig = trip.originLine()
        self.dest = trip.destinationLine()
        
        // Calculate amount of transport changes.
        self.changes = trip.steps.filter({ step -> Bool in
            return step.type != "WALK"
        }).count - 1
        
        // Calculate the total trip duration.
        self.duration = dest.getDate().timeIntervalSince(orig.getDate())
    }
    
    var body: some View {
        VStack(spacing: 6) {
            HStack {
                VStack {
                    Text(self.orig.time)
                        .bold()
                        .foregroundColor(self.orig.rtTime == nil ? nil : Color.red)
                        .strikethrough(self.orig.rtTime != nil, color: Color.red)
                    
                    if self.orig.rtTime != nil {
                        Text(self.orig.rtTime!).bold()
                    }
                }.padding(.trailing, 10)
                
                HStack {
                    Rectangle()
                        .fill(Color(red: 0, green: 0, blue: 0, opacity: 0.25))
                        .frame(height: 4)
                }
                
                VStack {
                    Text(self.dest.time)
                        .bold()
                        .foregroundColor(self.orig.rtTime == nil ? nil : Color.red)
                        .strikethrough(self.dest.rtTime != nil, color: Color.red)
                    
                    if self.dest.rtTime != nil {
                        Text(self.dest.rtTime!).bold()
                    }
                }.padding(.leading, 10)
            }
            
            HStack {
                Image(systemName: "stopwatch").font(.footnote)
                Text(self.duration.prettyPrint()).font(.footnote).padding(.trailing, 8)
                
                Image(systemName: "shuffle").font(.footnote)
                Text(
                    String(self.changes) + " " +
                    NSLocalizedString("Changes", comment: "")
                ).font(.footnote)
            }
        }.padding(.vertical, 10)
    }
}

struct TripRow_Previews: PreviewProvider {
    static var previews: some View {
        Text("@wip")
        //TripRow(trip: RPTrip(steps: []))
    }
}
