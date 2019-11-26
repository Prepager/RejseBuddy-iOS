import SwiftUI

struct ConnectionsList: View {
    @Binding var isNavbarHidden: Bool
    
    var body: some View {
        VStack {
            Text("@wip")
        }
        .navigationBarTitle(
            Text("Connections"),
            displayMode: .inline
        )
        .onAppear {
            self.isNavbarHidden = false
        }
    }
}

struct ConnectionsList_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionsList(isNavbarHidden: .constant(false))
    }
}
