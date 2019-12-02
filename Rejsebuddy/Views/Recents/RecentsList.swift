import SwiftUI
import CoreData

struct RecentsList: View {
    @FetchRequest(
        entity: Recent.entity(),
        sortDescriptors: [
            NSSortDescriptor(key: "date", ascending: false)
        ]
    ) var recents: FetchedResults<Recent>
    
    var body: some View {
        List(recents, id: \.self) { recent in
            NavigationLink(destination: TripsList(
                origin: recent.getOriginAddress(),
                destination: recent.getDestinationAddress()
            )) {
                RecentRow(recent: recent)
            }
        }
    }
}

struct RecentsView_Previews: PreviewProvider {
    static var previews: some View {
        RecentsList()
    }
}
