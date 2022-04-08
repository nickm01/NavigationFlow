//
//  Screen5Final.swift
//  NavigationFlow
//
//  Created by Nick McConnell on 6/21/20.
//  Copyright © 2020 Nick McConnell. All rights reserved.
//

import SwiftUI
import Combine

final class Screen5FinalVM: ObservableObject, Completeable {
    let name: String

    let didComplete = PassthroughSubject<Screen5FinalVM, Never>()
    
    init(name: String) {
        self.name = name
    }
    
    fileprivate func didTapNext() {
        //do some network calls etc
        sleep(1)
        didComplete.send(self)
    }
}

struct Screen5Final: View {
    @ObservedObject var vm: Screen5FinalVM

    var body: some View {
        VStack(alignment: .center) {
            Text("Welcome to the app, \(vm.name)")
            Button(action: { self.vm.didTapNext() }, label: { Text("Next") })
        }.padding()
    }
}
