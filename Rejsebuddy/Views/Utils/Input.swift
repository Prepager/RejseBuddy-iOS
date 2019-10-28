import SwiftUI

struct Input: View {
    var placeholder: String
    @Binding var value: String
    
    var body: some View {
        VStack {
            TextField(placeholder, text: $value)
            Divider()
        }
    }
}

struct Input_Previews: PreviewProvider {
    static var previews: some View {
        Input(placeholder: "Some text", value: .constant(""))
    }
}
