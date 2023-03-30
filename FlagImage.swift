//
//  FlagImage.swift
//  GuessTheFlagProject
//
//  Created by yulias on 11/03/2023.
//

import SwiftUI

struct FlagImage: View {
let name: String
    
    var body: some View {
        Image(name)
           .renderingMode(.original)
           .clipShape(Capsule())
           .shadow(radius: 5)
    }
   
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(name: "France")
    }
}
