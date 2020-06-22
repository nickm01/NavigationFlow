//
//  FlowControllerView.swift
//  NavigationFlow
//
//  Created by Nick McConnell on 6/7/20.
//  Copyright © 2020 Nick McConnell. All rights reserved.
//

import SwiftUI

protocol FlowControllerViewDelegate: class {
    func didTapNext(vm: Screen1PhoneVM)
    func didTapNext(vm: Screen2VerificationVM)
    func didTapCompanyInfo(vm: Screen3NameEmailVM)
    func didTapSkipCompanyInfo(vm: Screen3NameEmailVM)
    func didTapNext(vm: Screen4WorkInfoVM)
    func didTapComplete()
    func make() -> Screen1PhoneVM
    func make() -> Screen2VerificationVM
    func make() -> Screen3NameEmailVM
    func make() -> Screen4WorkInfoVM
    func make() -> Screen5FinalVM
}

enum NavigateTo {
    case screen1
    case screen2
    case screen3
    case screen4
    case finalFrom3
    case finalFrom4
}

struct FlowControllerView: View, FlowControllerViewProtocol {

    weak var delegate: FlowControllerViewDelegate!

    private let navigateTo2 = FlowState()
    private let navigateTo3 = FlowState()
    private let navigateTo4 = FlowState()
    private let navigateToFinalFrom3 = FlowState()
    private let navigateToFinalFrom4 = FlowState()

    init(modelDelegate: FlowControllerViewDelegate) {
        self.delegate = modelDelegate
    }

    func navigate(to navigateTo: NavigateTo) {
        switch navigateTo {
        case .screen1:
            break
        case .screen2:
            navigateTo2.next = true
        case .screen3:
            navigateTo3.next = true
        case .screen4:
            navigateTo4.next = true
        case .finalFrom3:
            navigateToFinalFrom3 .next = true
        case .finalFrom4:
            navigateToFinalFrom4.next = true
        }
    }

    var screen1Phone: LazyView<Screen1Phone> {
        return LazyView(Screen1Phone(
            vm: self.delegate.make(),
            didTapNext: self.delegate.didTapNext
        ))
    }

    var screen2Verification: LazyView<Screen2Verification> {
        return LazyView(Screen2Verification(
            vm: self.delegate.make(),
            didTapNext: self.delegate.didTapNext
        ))
    }

    var screen3NameEmail: LazyView<Screen3NameEmail> {
        return LazyView(Screen3NameEmail(
            vm: self.delegate.make(),
            didTapCompanyInfo: self.delegate.didTapCompanyInfo,
            didTapSkip: self.delegate.didTapSkipCompanyInfo
        ))
    }

    var screen4CompanyInfo: LazyView<Screen4CompanyInfo> {
        return LazyView(Screen4CompanyInfo(
            vm: self.delegate.make(),
            didTapNext: self.delegate.didTapNext
        ))
    }

    var screen5Final: LazyView<Screen5Final> {
        return LazyView(Screen5Final(
            vm: self.delegate.make(),
            didTapNext: self.delegate.didTapComplete
        ))
    }

    var body: some View {
        NavigationView {
            VStack() {
                screen1Phone
                Flow(state: navigateTo2) {
                    screen2Verification
                    Flow(state: navigateTo3) {
                        screen3NameEmail
                        Flow(state: navigateTo4) {
                            screen4CompanyInfo
                            Flow(state: navigateToFinalFrom4) {
                                screen5Final
                            }
                        }
                        Flow(state: navigateToFinalFrom3) {
                            screen5Final
                        }
                    }
                }
            }
        }
    }
}
