//
//  Screen5Final.swift
//  NavigationFlow
//
//  Created by Nick McConnell on 6/21/20.
//  Copyright © 2020 Nick McConnell. All rights reserved.
//

import SwiftUI

class Screen5FinalVM: ObservableObject {
    let name: String

    init(name: String) {
        self.name = name
    }
}

struct Screen5Final: View {
    @ObservedObject var vm: Screen5FinalVM
    let didTapNext: () -> ()

    var body: some View {
        VStack(alignment: .center) {
            Text("Welcome to the app, \(vm.name)")
            Button(action: { self.didTapNext() }, label: { Text("Next") })
        }.padding()
    }
}
