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

    init(vm: FlowVM) {
        self.vm = vm
    }

    var body: some View {
        NavigationView {
            VStack() {
                Screen1Phone(vm: vm.screen1PhoneVM)
                Flow(next: $vm.navigateTo2) {
                    Screen2Verification(vm: vm.screen2VerificationVM)
                    Flow(next: $vm.navigateTo3) {
                        Screen3NameEmail(vm: vm.screen3NameEmailVM)
                        Flow(next: $vm.navigateTo4) {
                            Screen4CompanyInfo(vm: vm.screen4WorkInfoVM)
                            Flow(next: $vm.navigateToFinalFrom4) {
                                Screen5Final(vm: vm.screen5FinalVM)
                            }
                        }
                        Flow(next: $vm.navigateToFinalFrom3) {
                            Screen5Final(vm: vm.screen5FinalVM)
                        }
                    }
                }
            }
        }.navigationViewStyle(.stack)
    }
}
