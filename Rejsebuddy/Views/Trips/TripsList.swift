import SwiftUI
import Combine

class TripsListViewModel: ObservableObject {
    private var consumer = FetchTrips()
    private var cancellable: AnyCancellable? = nil
    
    @Published var trips = [RPTrip]()
    
    @ObservedObject var origin: Address
    @ObservedObject var destination: Address
    
    init(origin: Address, destination: Address) {
        self.origin = origin
        self.destination = destination
    }
    
    deinit {
        self.cancellable?.cancel()
    }
    
    func fetch() {
        self.cancellable = AnyCancellable(
            self.consumer
                .fetch(origin: self.origin, destination: self.destination)
                .sink(receiveCompletion: { c in
                    if case let .failure(error) = c {
                        dump(error)
                    }
                }, receiveValue: { list in
                    self.trips = list.trips
                })
        )
    }
}

struct TripsList: View {
    @ObservedObject var viewModel: TripsListViewModel
    
    init(origin: Address, destination: Address) {
        self.viewModel = TripsListViewModel(origin: origin, destination: destination)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack {
                HStack {
                    Image(systemName: "stop.circle").foregroundColor(.gray)
                    Text(viewModel.origin.name)
                    Spacer()
                }
                
                HStack {
                    Image(systemName: "stop.circle").foregroundColor(.gray)
                    Text(viewModel.destination.name)
                    Spacer()
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
            
            List(self.viewModel.trips, id: \.self) { trip in
                ZStack {
                    NavigationLink(destination: TripInfo(trip: trip)) {
                        EmptyView()
                    }
                    
                    TripRow(trip: trip)
                }
            }
        }
        .navigationBarTitle(
            Text("Connections"),
            displayMode: .inline
        )
        .onAppear {
            self.viewModel.fetch()
        }
    }
}

struct TripsList_Previews: PreviewProvider {
    static var previews: some View {
        TripsList(
            origin: Address(),
            destination: Address()
        )
    }
}
