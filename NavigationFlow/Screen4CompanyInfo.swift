//
//  Screen4CompanyInfo.swift
//  NavigationFlow
//
//  Created by Nick McConnell on 6/21/20.
//  Copyright © 2020 Nick McConnell. All rights reserved.
//

import SwiftUI
import Combine

final class Screen4WorkInfoVM: ObservableObject, Completeable {
    @Published var workEmail = ""
    
    let didComplete = PassthroughSubject<Screen4WorkInfoVM, Never>()
    let goToRootRequested = PassthroughSubject<Screen4WorkInfoVM, Never>()
    let goTo2Requested = PassthroughSubject<Screen4WorkInfoVM, Never>()
    let goTo3Requested = PassthroughSubject<Screen4WorkInfoVM, Never>()

    fileprivate func didTapNext() {
        //do some network calls etc
        sleep(1)
        didComplete.send(self)
    }
    
    fileprivate func didTapGoBackToRoot() {
        goToRootRequested.send(self)
    }
    
    fileprivate func didTapGoBack2() {
        goTo2Requested.send(self)
    }
    
    fileprivate func didTapGoBack3() {
        goTo3Requested.send(self)
    }
}

struct Screen4CompanyInfo: View {
    @ObservedObject var vm: Screen4WorkInfoVM

    var body: some View {
        VStack(alignment: .center) {
            Text("4: Enter Work Details")
            TextField("Work Email", text: $vm.workEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: { self.vm.didTapNext() }, label: { Text("Next") })
            Text("")
            Text("Test other programmatic navigation")
            Button(action: { self.vm.didTapGoBackToRoot() }, label: { Text("Go back to root") })
            Button(action: { self.vm.didTapGoBack2() }, label: { Text("Go back to 2") })
            Button(action: { self.vm.didTapGoBack3() }, label: { Text("Go back to 3, change name") })
        }.padding()
    }
}