//
//  SelectAddress.swift
//  Rejsebuddy
//
//  Created by Andreas on 25/11/2019.
//  Copyright © 2019 Prepager. All rights reserved.
//

import SwiftUI

struct SelectAddress: View {
    @Binding var show: Bool
    @State var search: String = ""
    
    @ObservedObject var address: Address
    
    var body: some View {
        VStack {
            HStack {
                SearchBar(text: $search)
                Button(action: { self.show.toggle() }) {
                    Text("Cancel")
                }.padding(.trailing, 15)
            }
            
            // @wip - list
            Spacer()
        }
    }
}

struct SelectAddress_Previews: PreviewProvider {
    static var previews: some View {
        SelectAddress(show: .constant(true), address: Address())
    }
}
