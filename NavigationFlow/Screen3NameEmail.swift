//
//  Screen3NameEmail.swift
//  NavigationFlow
//
//  Created by Nick McConnell on 6/21/20.
//  Copyright © 2020 Nick McConnell. All rights reserved.
//

import SwiftUI
import Combine

final class Screen3NameEmailVM: ObservableObject {
    @Published var name = ""
    @Published var personalEmail = ""
    
    let didComplete = PassthroughSubject<Screen3NameEmailVM, Never>()
    let skipRequested = PassthroughSubject<Screen3NameEmailVM, Never>()
    
    fileprivate func didTapNext() {
        //do some network calls etc
        didComplete.send(self)
    }
    
    fileprivate func didTapSkip() {
        skipRequested.send(self)
    }
}

struct Screen3NameEmail: View {
    @ObservedObject var vm: Screen3NameEmailVM

    var body: some View {
        VStack(alignment: .center) {
            Text("3: Enter personal details")
            TextField("Name", text: $vm.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Personal Email", text: $vm.personalEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Spacer()
                .frame(height: 12)
            Button(action: {
                self.vm.didTapNext()
            }, label: {
                Text("Enter Company Info")
            })
            Button(action: {
                self.vm.didTapSkip()
            }, label: {
                Text("Skip")
            })
            Spacer()
        }.padding()
    }
}
