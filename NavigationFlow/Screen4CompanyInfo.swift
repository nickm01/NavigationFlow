//
//  Screen4CompanyInfo.swift
//  NavigationFlow
//
//  Created by Nick McConnell on 6/21/20.
//  Copyright © 2020 Nick McConnell. All rights reserved.
//

import SwiftUI


class Screen4WorkInfoVM: ObservableObject {
    @Published var workEmail = ""
}

struct Screen4CompanyInfo: View {
    @ObservedObject var vm: Screen4WorkInfoVM
    let didTapNext: (Screen4WorkInfoVM) -> ()

    var body: some View {
        VStack(alignment: .center) {
            Text("Enter Work Details")
            TextField("Work Email", text: $vm.workEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: { self.didTapNext(self.vm) }, label: { Text("Next") })
        }.padding()
    }
}
