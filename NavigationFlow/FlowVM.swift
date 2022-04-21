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
    // and is makes the views dependant on something that is external to the view.
    private let model: Model
    var subscription = Set<AnyCancellable>()
    
    let screen1PhoneVM: Screen1PhoneVM
    let screen2VerificationVM: Screen2VerificationVM
    let screen3NameEmailVM: Screen3NameEmailVM
    let screen4WorkInfoVM: Screen4WorkInfoVM
    let screen5FinalVM: Screen5FinalVM
    
    @Published var navigateTo2: Bool = false
    @Published var navigateTo3: Bool = false
    @Published var navigateTo4: Bool = false
    @Published var navigateToFinalFrom3: Bool = false
    @Published var navigateToFinalFrom4: Bool = false
    
    init() {
        self.model = Model()
        screen1PhoneVM = Screen1PhoneVM()
        screen2VerificationVM = Screen2VerificationVM()
        screen3NameEmailVM = Screen3NameEmailVM()
        screen4WorkInfoVM = Screen4WorkInfoVM()
        screen5FinalVM = Screen5FinalVM()
        
        bindEvents()
    }
    
    func bindEvents() {
        screen1PhoneVM.didComplete
            .sink(receiveValue: didComplete1)
            .store(in: &subscription)
        
        screen2VerificationVM.didComplete
            .sink(receiveValue: didComplete2)
            .store(in: &subscription)
        
        screen3NameEmailVM.didComplete
            .sink(receiveValue: didComplete3)
            .store(in: &subscription)
        
        screen3NameEmailVM.skipRequested
            .sink(receiveValue: skipRequested)
            .store(in: &subscription)
        
        screen4WorkInfoVM.didComplete
            .sink(receiveValue: didComplete4)
            .store(in: &subscription)
        
        screen4WorkInfoVM.goToRootRequested
            .sink(receiveValue: goToRootRequested)
            .store(in: &subscription)
        
        screen4WorkInfoVM.goTo2Requested
            .sink(receiveValue: goTo2Requested)
            .store(in: &subscription)
        
        screen4WorkInfoVM.goTo3Requested
            .sink(receiveValue: goTo3Requested)
            .store(in: &subscription)
        
        screen5FinalVM.didComplete
            .sink(receiveValue: didComplete5)
            .store(in: &subscription)
    }
    
    func didComplete1(vm: Screen1PhoneVM) {
        // Additional logic inc. updating model
        model.phoneNumber = vm.phoneNumber
        screen2VerificationVM.phoneNumber = vm.phoneNumber
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
        screen3NameEmailVM.name = "back"
        navigateTo4 = false
    }
    
    func didComplete5(vm: Screen5FinalVM) {
        // Switch out navigation.  Model now complete.
        print("Complete")
        print(model)
    }
}
