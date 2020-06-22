//
//  FlowController.swift
//  NavigationFlow
//
//  Created by Nick McConnell on 6/7/20.
//  Copyright © 2020 Nick McConnell. All rights reserved.
//

import Foundation

protocol FlowControllerViewProtocol {
    func navigate(to: NavigateTo)
}

class FlowController {
    let model: Model
    var view: FlowControllerViewProtocol?

    init(view: FlowControllerViewProtocol? = nil) {
        self.model = Model()
        self.view = view ?? FlowControllerView(modelDelegate: self)
    }
}

extension FlowController: FlowControllerViewDelegate {

    func didTapNext(vm: Screen1PhoneVM) {
        model.update(with: vm)
        // Network call to send verification number, then...
        view?.navigate(to: .screen2)
    }

    func didTapNext(vm: Screen2VerificationVM) {
        // Network call to check verification number, if success then...
        view?.navigate(to: .screen3)
    }

    func didTapCompanyInfo(vm: Screen3NameEmailVM) {
        model.update(with: vm)
        // Network call to save details
        view?.navigate(to: .screen4)
    }

    func didTapSkipCompanyInfo(vm: Screen3NameEmailVM) {
        model.update(with: vm)
        // Network call to save details
        view?.navigate(to: .finalFrom3)
    }

    func didTapNext(vm: Screen4WorkInfoVM) {
        // Do some network actions... then
        view?.navigate(to: .finalFrom4)
    }

    func didTapComplete() {
        // Launch main app
    }

    func make() -> Screen1PhoneVM {
        return model.make()
    }

    func make() -> Screen2VerificationVM {
        return model.make()
    }

    func make() -> Screen3NameEmailVM {
        return model.make()
    }

    func make() -> Screen4WorkInfoVM {
        return model.make()
    }

    func make() -> Screen5FinalVM {
        return model.make()
    }
}
