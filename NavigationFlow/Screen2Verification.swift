//
//  Screen2Verification.swift
//  NavigationFlow
//
//  Created by Nick McConnell on 6/21/20.
//  Copyright © 2020 Nick McConnell. All rights reserved.
//

import SwiftUI

class Screen2VerificationVM: ObservableObject {
    @Published var verification = ""
    let phoneNumber: String

    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
}

struct Screen2Verification: View {
    @ObservedObject var vm: Screen2VerificationVM
    let didTapNext: (Screen2VerificationVM) -> ()

    var body: some View {
        VStack(alignment: .center) {
            Text("Verification sent to \(vm.phoneNumber)")
            TextField("Verfication Number", text: $vm.verification)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: { self.didTapNext(self.vm) }, label: { Text("Next") })
        }.padding()
    }
}
