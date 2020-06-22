//
//  Screen3NameEmail.swift
//  NavigationFlow
//
//  Created by Nick McConnell on 6/21/20.
//  Copyright © 2020 Nick McConnell. All rights reserved.
//

import SwiftUI

class Screen3NameEmailVM: ObservableObject {
    @Published var name = ""
    @Published var personalEmail = ""
}

struct Screen3NameEmail: View {
    @ObservedObject var vm: Screen3NameEmailVM
    let didTapCompanyInfo: (Screen3NameEmailVM) -> ()
    let didTapSkip: (Screen3NameEmailVM) -> ()

    var body: some View {
        VStack(alignment: .center) {
            Text("Enter personal details")
            TextField("Name", text: $vm.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Personal Email", text: $vm.personalEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Spacer()
                .frame(height: 12)
            Button(action: { self.didTapCompanyInfo(self.vm) }, label: { Text("Enter Company Info") })
            Button(action: { self.didTapSkip(self.vm) }, label: { Text("Skip") })
            Spacer()
        }.padding()
    }
}
