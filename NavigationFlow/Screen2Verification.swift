//
//  Screen2Verification.swift
//  NavigationFlow
//
//  Created by Nick McConnell on 6/21/20.
//  Copyright © 2020 Nick McConnell. All rights reserved.
//

import SwiftUI
import Combine

final class Screen2VerificationVM: ObservableObject, Completeable {
    @Published var verification = ""
    var phoneNumber: String

    let didComplete = PassthroughSubject<Screen2VerificationVM, Never>()
    
    init(phoneNumber: String?) {
        self.phoneNumber = phoneNumber ?? ""
    }
    
    func didTapNext() {
        //do some network calls etc
        didComplete.send(self)
    }
}

struct Screen2Verification: View {
    @StateObject var vm: Screen2VerificationVM

    var body: some View {
        VStack(alignment: .center) {
            Text("2: Verification sent to \(vm.phoneNumber)")
            TextField("Verfication Number", text: $vm.verification)
            Button(action: {
                self.vm.didTapNext()
            }, label: {
                Text("Next")
            })
        }.padding()
    }
}
