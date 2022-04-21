//
//  FlowVM.swift
//  NavigationFlow
//
//  Created by Nick McConnell on 6/7/20.
//  Copyright © 2020 Nick McConnell. All rights reserved.
//

import Foundation
import Combine

protocol Completeable {
    var didComplete: PassthroughSubject<Self, Never> { get }
}

class FlowVM: ObservableObject {
    
    // Note the final model is manually "bound" to the view models here.
    // Automatic binding would be possible with combine or even a single VM.
    // However this may not scale well
    // and the views become dependant on something that is external to the view.
    private let model: Model
    var subscription = Set<AnyCancellable>()
    
    @Published var navigateTo2: Bool = false
    @Published var navigateTo3: Bool = false
    @Published var navigateTo4: Bool = false
    @Published var navigateToFinalFrom3: Bool = false
    @Published var navigateToFinalFrom4: Bool = false
    
    init() {
        self.model = Model()
    }

    func makeScreen1PhoneVM() -> Screen1PhoneVM {
        let vm = Screen1PhoneVM(phoneNumber: model.phoneNumber)
        vm.didComplete
            .sink(receiveValue: didComplete1)
            .store(in: &subscription)
        return vm
    }
    
    func makeScreen2VerificationVM() -> Screen2VerificationVM {
        let vm = Screen2VerificationVM(phoneNumber: model.phoneNumber)
        vm.didComplete
            .sink(receiveValue: didComplete2)
            .store(in: &subscription)
        return vm
    }
    
    func makeScreen3NameEmailVM() -> Screen3NameEmailVM {
        let vm = Screen3NameEmailVM(
            name: model.name,
            personalEmail: model.workEmail
        )
        vm.didComplete
            .sink(receiveValue: didComplete3)
            .store(in: &subscription)
        vm.skipRequested
            .sink(receiveValue: skipRequested)
            .store(in: &subscription)
        return vm
    }
    
    func makeScreen4WorkInfoVM() -> Screen4WorkInfoVM {
        let vm = Screen4WorkInfoVM(workEmail: model.workEmail)
        vm.didComplete
            .sink(receiveValue: didComplete4)
            .store(in: &subscription)
        vm.goToRootRequested
            .sink(receiveValue: goToRootRequested)
            .store(in: &subscription)
        vm.goTo2Requested
            .sink(receiveValue: goTo2Requested)
            .store(in: &subscription)
        vm.goTo3Requested
            .sink(receiveValue: goTo3Requested)
            .store(in: &subscription)
        return vm
    }
    
    func makeScreen5FinalVM() -> Screen5FinalVM {
        let vm = Screen5FinalVM(name: model.name)
        vm.didComplete
            .sink(receiveValue: didComplete5)
            .store(in: &subscription)
        return vm
    }
    
    func didComplete1(vm: Screen1PhoneVM) {
        // Additional logic inc. updating model
        model.phoneNumber = vm.phoneNumber
        navigateTo2 = true
    }
    
    func didComplete2(vm: Screen2VerificationVM) {
        // Additional logic
        navigateTo3 = true
    }
    
    func didComplete3(vm: Screen3NameEmailVM) {
        // Additional logic inc. updating model
        updateModel(vm: vm)
        navigateTo4 = true
    }
    
    func skipRequested(vm: Screen3NameEmailVM) {
        // Additional logic inc. updating model
        updateModel(vm: vm)
        navigateToFinalFrom3 = true
    }
    
    func updateModel(vm: Screen3NameEmailVM) {
        model.name = vm.name
        model.personalEmail = vm.personalEmail
    }
    
    func didComplete4(vm: Screen4WorkInfoVM) {
        // Additional logic inc. updating model
        model.workEmail = vm.workEmail
        navigateToFinalFrom4 = true
    }
    
    func goToRootRequested(vm: Screen4WorkInfoVM) {
        // Additional logic
        navigateTo2 = false
    }

    func goTo2Requested(vm: Screen4WorkInfoVM) {
        // Additional logic
        navigateTo3 = false
    }

    func goTo3Requested(vm: Screen4WorkInfoVM) {
        // Additional logic
        navigateTo4 = false
    }
    
    func didComplete5(vm: Screen5FinalVM) {
        // Switch out navigation.  Model now complete.
        print("Complete")
        print(model)
    }
}
