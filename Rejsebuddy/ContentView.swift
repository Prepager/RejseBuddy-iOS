import SwiftUI

struct ContentView: View {
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection){
            Text("First view")
                .tag(0)
                .font(.title)
                .tabItem {
                    VStack {
                        Image("trips")
                        Text("Trips")
                    }
                }
            
            Text("Second view")
                .tag(1)
                .font(.title)
                .tabItem {
                    VStack {
                        Image("contacts")
                        Text("Contacts")
                    }
                }
                
            Text("Third view")
                .tag(2)
                .font(.title)
                .tabItem {
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
