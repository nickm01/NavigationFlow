//
//  Screen1Email.swift
//  NavigationFlow
//
//  Created by Nick McConnell on 6/21/20.
//  Copyright © 2020 Nick McConnell. All rights reserved.
//

import SwiftUI

class Screen1PhoneVM: ObservableObject {
    @Published var phoneNumber = ""
}

struct Screen1Phone: View {
    @ObservedObject var vm: Screen1PhoneVM
    let didTapNext: (Screen1PhoneVM) -> ()

    var body: some View {
        VStack(alignment: .center) {
            Text("We need your phone number for verification")
            TextField("Phone Number", text: $vm.phoneNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: { self.didTapNext(self.vm) }, label: { Text("Next") })
        }.padding()
    }
}
