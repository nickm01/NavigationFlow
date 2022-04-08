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

    var screen1Phone: LazyView<Screen1Phone> {
        return LazyView(Screen1Phone(
            vm: self.vm.screen1PhoneVM
        ))
    }

    var screen2Verification: LazyView<Screen2Verification> {
        return LazyView(Screen2Verification(
            vm: self.vm.screen2VerificationVM
        ))
    }

    var screen3NameEmail: LazyView<Screen3NameEmail> {
        return LazyView(Screen3NameEmail(
            vm: self.vm.screen3NameEmailVM
        ))
    }

    var screen4CompanyInfo: LazyView<Screen4CompanyInfo> {
        return LazyView(Screen4CompanyInfo(
            vm: self.vm.screen4WorkInfoVM
        ))
    }

    var screen5Final: LazyView<Screen5Final> {
        return LazyView(Screen5Final(
            vm: self.vm.screen5FinalVM
        ))
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
