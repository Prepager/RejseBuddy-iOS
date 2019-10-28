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
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 25))
                    
                    Text("Trips")
                }
            }
            
            ContactsView().tag(1).tabItem {
                VStack {
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 25))
                    
                    Text("Contacts")
                }
            }
                
            SettingsView().tag(2).tabItem {
                VStack {
                    Image(systemName: "gear")
                        .font(.system(size: 25))
                    
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
