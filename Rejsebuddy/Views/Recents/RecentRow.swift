import SwiftUI

struct RecentRow: View {
    var recent: Recent
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "a.circle").foregroundColor(.gray)
                
                Text(recent.orig_address)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
            }
            
            HStack {
                Image(systemName: "b.circle").foregroundColor(.red)
                
                Text(recent.dest_address)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
            }
        }.padding(.vertical, 10)
    }
}

struct RecentRow_Previews: PreviewProvider {
    static var previews: some View {
        RecentRow(recent: Recent.example())
    }
}
