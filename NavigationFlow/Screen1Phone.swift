//
//  Screen1Phone.swift
//  NavigationFlow
//
//  Created by Nick McConnell on 6/21/20.
//  Copyright © 2020 Nick McConnell. All rights reserved.
//

import SwiftUI
import Combine

final class Screen1PhoneVM: ObservableObject, Completeable {
    @Published var phoneNumber = ""
    
    // would be more complex
    var isValid: Bool {
        !phoneNumber.isEmpty
    }
    
    let didComplete = PassthroughSubject<Screen1PhoneVM, Never>()

    init(phoneNumber: String?) {
        self.phoneNumber = phoneNumber ?? ""
    }
    
    func didTapNext() {
        //do some network calls etc
        guard isValid else {
            return
        }
        
        didComplete.send(self)
    }
}

struct Screen1Phone: View {
    @StateObject var vm: Screen1PhoneVM

    var body: some View {
        VStack(alignment: .center) {
            Text("1: We need your phone number for verification")
            TextField("Phone Number", text: $vm.phoneNumber)
            Button(action: {
                self.vm.didTapNext()
            }, label: { Text("Next") })
            .disabled(!vm.isValid)
        }.padding()
    }
}
