import SwiftUI
import Combine

class LocationSearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @ObservedObject var manager = LocationManager()
    @ObservedObject var consumer = SearchLocations()
    
    @Published var locations = [RPLocation]()
    
    private var cancellable: AnyCancellable? = nil
    
    init() {
        // Start location watcher.
        self.manager.start()
        
        // Fetch on search text changed.
        self.cancellable = AnyCancellable(
            $searchText
                .removeDuplicates()
                .debounce(for: 0.25, scheduler: DispatchQueue.main)
                .sink { query in
                    self.fetch(search: query)
                }
        )
    }
    
    deinit {
        self.cancellable?.cancel()
    }
    
    func fetch(search: String) {
        self.consumer
            .fetch(search: search)
            .sink(receiveCompletion: { c in
                if case let .failure(error) = c {
                    dump(error)
                }
            }, receiveValue: { list in
                // Find distances for locations and sort.
                self.locations = list.locations.map({ instance -> RPLocation in
                    var location = instance
                    location.distance = self.manager.distanceTo(
                        address: location.getAddress()
                    )
                    
                    return location
                }).sorted(by: { (a, b) -> Bool in
                    return a.distance! < b.distance!
                })
            })
    }
}

struct SelectAddress: View {
    @Binding var show: Bool
    @ObservedObject var address: Address
    @ObservedObject var keyboard = Keyboard(hasTabbar: false)
    @ObservedObject var viewModel = LocationSearchViewModel()
    
    init(show: Binding<Bool>, address: Address) {
        self._show = show
        self.address = address
        self.viewModel.searchText = self.address.name
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                SearchBar(text: $viewModel.searchText)
                Button(action: { self.show.toggle() }) {
                    Text("Cancel")
                }.padding(.trailing, 15)
            }
            
            List(viewModel.locations, id: \.self) { location in
                Button(action: {
                    self.address.set(address: location.getAddress())
                    self.show.toggle()
                }) {
                    LocationRow(location: location)
                }
            }.padding(.bottom, self.keyboard.height)
        }
    }
}

struct SelectAddress_Previews: PreviewProvider {
    static var previews: some View {
        SelectAddress(show: .constant(true), address: Address())
    }
}
