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

    // Note the generation of view models here is only done once
    // as long as the view models are referenced as @StateObject and not @ObservedObject
    
    var body: some View {
        NavigationView {
            VStack() {
                Screen1Phone(vm: vm.makeScreen1PhoneVM())
                Flow(next: $vm.navigateTo2) {
                    Screen2Verification(vm: vm.makeScreen2VerificationVM())
                    Flow(next: $vm.navigateTo3) {
                        Screen3NameEmail(vm: vm.makeScreen3NameEmailVM())
                        Flow(next: $vm.navigateTo4) {
                            Screen4CompanyInfo(vm: vm.makeScreen4WorkInfoVM())
                            Flow(next: $vm.navigateToFinalFrom4) {
                                Screen5Final(vm: vm.makeScreen5FinalVM())
                            }
                        }
                        Flow(next: $vm.navigateToFinalFrom3) {
                            Screen5Final(vm: vm.makeScreen5FinalVM())
                        }
                    }
                }
            }
        }.navigationViewStyle(.stack)
    }
}
