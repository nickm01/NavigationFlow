//
//  OnboardingModel.swift
//  NavigationFlow
//
//  Created by Nick McConnell on 6/21/20.
//  Copyright © 2020 Nick McConnell. All rights reserved.
//

import Foundation

class OnboardingModel {
    var phoneNumber: String?
    var name: String?
    var personalEmail: String?
    var workEmail: String?
}

// ViewModel Generation
extension OnboardingModel {
    func make() -> Screen1PhoneVM {
        return Screen1PhoneVM()
    }

    func make() -> Screen2VerificationVM {
        return Screen2VerificationVM(phoneNumber: phoneNumber ?? "")
    }

    func make() -> Screen3NameEmailVM {
        return Screen3NameEmailVM()
    }

    func make() -> Screen4WorkInfoVM {
        return Screen4WorkInfoVM()
    }

    func make() -> Screen5FinalVM {
        return Screen5FinalVM(name: name ?? "")
    }
}

// Model updates from ViewModels
extension OnboardingModel {
    func update(with vm: Screen1PhoneVM) {
        phoneNumber = vm.phoneNumber
    }

    func update(with vm: Screen3NameEmailVM) {
        name = vm.name
        personalEmail = vm.personalEmail
    }

    func update(with vm: Screen4WorkInfoVM) {
        workEmail = vm.workEmail
    }
}
