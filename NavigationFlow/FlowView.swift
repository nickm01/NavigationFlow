//
//  FlowView.swift
//  NavigationFlow
//
//  Created by Nick McConnell on 6/7/20.
//  Copyright © 2020 Nick McConnell. All rights reserved.
//

import SwiftUI

struct FlowView: View {
    
    @StateObject var vm: FlowVM

    var body: some View {
        NavigationStack(path: $vm.navigationPath) {
            VStack() {
                Screen1Phone(vm: vm.makeScreen1PhoneVM())
            }
            .navigationDestination(for: Screen2VerificationVM.self) {vm in
                Screen2Verification(vm: vm)
            }
            .navigationDestination(for: Screen3NameEmailVM.self) {vm in
                Screen3NameEmail(vm: vm)
            }
            .navigationDestination(for: Screen4WorkInfoVM.self ) {vm in
                Screen4CompanyInfo(vm: vm)
            }
            .navigationDestination(for: Screen5FinalVM.self) {vm in
                Screen5Final(vm: vm)
            }                                   
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}
