//
//  AddressInput.swift
//  Rejsebuddy
//
//  Created by Andreas on 26/10/2019.
//  Copyright © 2019 Prepager. All rights reserved.
//

import SwiftUI

struct AddressInput: View {
    @Binding var value: String
    
    var body: some View {
        VStack {
            TextField("Press to select location", text: $value)
            Divider()
        }
    }
}

struct AddressInput_Previews: PreviewProvider {
    static var previews: some View {
        AddressInput(value: .constant(""))
    }
}
