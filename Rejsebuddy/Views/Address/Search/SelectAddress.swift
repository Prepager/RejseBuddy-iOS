import SwiftUI
import Combine

class LocationSearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @ObservedObject var consumer: SearchLocations = SearchLocations()
    
    private var cancellable: AnyCancellable? = nil
    private var nestedCancellable: AnyCancellable? = nil
    
    init() {
        // Handle nested obserable objects.
        self.nestedCancellable = AnyCancellable(
            self.consumer.objectWillChange
                .sink { _ in
                    self.objectWillChange.send()
                }
        )
        
        // Fetch on search text changed.
        self.cancellable = AnyCancellable(
            $searchText
                .removeDuplicates()
                .debounce(for: 0.25, scheduler: DispatchQueue.main)
                .sink { query in
                    self.consumer.fetch(search: query)
                }
        )
    }
    
    deinit {
        self.cancellable?.cancel()
        self.nestedCancellable?.cancel()
    }
}

struct SelectAddress: View {
    @Binding var show: Bool
    @ObservedObject var address: Address
    @ObservedObject var viewModel = LocationSearchViewModel()
    
    init(show: Binding<Bool>, address: Address) {
        self._show = show
        self.address = address
        self.viewModel.searchText = self.address.name
    }
    
    var body: some View {
        VStack {
            HStack {
                SearchBar(text: $viewModel.searchText)
                Button(action: { self.show.toggle() }) {
                    Text("Cancel")
                }.padding(.trailing, 15)
            }
            
            List(viewModel.consumer.locations, id: \.self) { location in
                Button(action: {
                    self.address.set(address: location.getAddress())
                    self.show.toggle()
                }) {
                    LocationRow(location: location)
                }
            }
        }
    }
}

struct SelectAddress_Previews: PreviewProvider {
    static var previews: some View {
        SelectAddress(show: .constant(true), address: Address())
    }
}
