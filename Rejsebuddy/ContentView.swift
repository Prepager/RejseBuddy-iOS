import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    
    init() {
        // Make navigation bar opaque white.
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        // Set appearance as standard theme.
        UINavigationBar.appearance().standardAppearance = appearance
    }
 
    var body: some View {
        TabView(selection: $selection){
            TripsView().tag(0).tabItem {
                VStack {
                    Image("trips")
                    Text("Trips")
                }
            }
            
            ContactsView().tag(1).tabItem {
                VStack {
                    Image("contacts")
                    Text("Contacts")
                }
            }
                
            SettingsView().tag(2).tabItem {
                VStack {
                    Image("settings")
                    Text("Settings")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
