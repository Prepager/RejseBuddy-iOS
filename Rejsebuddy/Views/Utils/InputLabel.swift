//
//  InputLabel.swift
//  Rejsebuddy
//
//  Created by Andreas on 26/10/2019.
//  Copyright © 2019 Prepager. All rights reserved.
//

import SwiftUI

struct InputLabel: View {
    var text: LocalizedStringKey
    
    var body: some View {
        Text(text)
            .font(.caption)
            .kerning(0.6)
            .fontWeight(.heavy)
            .foregroundColor(Color.blue)
    }
}

struct InputLabel_Previews: PreviewProvider {
    static var previews: some View {
        InputLabel(text: "FROM")
    }
}
