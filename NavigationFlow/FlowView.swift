//
//  FlowView.swift
//  NavigationFlow
//
//  Created by Nick McConnell on 6/7/20.
//  Copyright © 2020 Nick McConnell. All rights reserved.
//

import SwiftUI

struct FlowView: View {
    
    @ObservedObject var vm: FlowVM

    let screen1Phone: Screen1Phone
    let screen2Verification: Screen2Verification
    let screen3NameEmail: Screen3NameEmail
    let screen4CompanyInfo: Screen4CompanyInfo
    let screen5Final: Screen5Final

    init(vm: FlowVM) {
        self.vm = vm
        screen1Phone = Screen1Phone(vm: vm.screen1PhoneVM)
        screen2Verification = Screen2Verification(vm: vm.screen2VerificationVM)
        screen3NameEmail = Screen3NameEmail(vm: vm.screen3NameEmailVM)
        screen4CompanyInfo = Screen4CompanyInfo(vm: vm.screen4WorkInfoVM)
        screen5Final = Screen5Final(vm: vm.screen5FinalVM)
    }

    var body: some View {
        NavigationView {
            VStack() {
                screen1Phone
                Flow(next: $vm.navigateTo2) {
                    screen2Verification
                    Flow(next: $vm.navigateTo3) {
                        screen3NameEmail
                        Flow(next: $vm.navigateTo4) {
                            screen4CompanyInfo
                            Flow(next: $vm.navigateToFinalFrom4) {
                                screen5Final
                            }
                        }
                        Flow(next: $vm.navigateToFinalFrom3) {
                            screen5Final
                        }
                    }
                }
            }
        }.navigationViewStyle(.stack)
    }
}
