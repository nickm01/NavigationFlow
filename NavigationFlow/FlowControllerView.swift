//
//  FlowControllerView.swift
//  NavigationFlow
//
//  Created by Nick McConnell on 6/7/20.
//  Copyright © 2020 Nick McConnell. All rights reserved.
//

import SwiftUI

protocol FlowControllerViewDelegate: class {
    func didTapNextFromScreen1()
    func didTapNextFromScreen2()
    func didTapNextAFromScreen3()
    func didTapNextBFromScreen3()
    func didTapNextFromScreen4()
}

struct FlowControllerView: View {

    weak var modelDelegate: FlowControllerViewDelegate!

    private let navigateTo2 = FlowState()
    private let navigateTo3 = FlowState()
    private let navigateTo4 = FlowState()
    private let navigateToFinalFrom3 = FlowState()
    private let navigateToFinalFrom4 = FlowState()

    enum NavigateTo {
        case screen1
        case screen2
        case screen3
        case screen4
        case finalFrom3
        case finalFrom4
    }

    init(modelDelegate: FlowControllerViewDelegate) {
        self.modelDelegate = modelDelegate
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

    var body: some View {
        NavigationView {
            VStack() {
                Screen(title: "Screen 1", didTapNext: self.modelDelegate.didTapNextFromScreen1)
                Flow(state: navigateTo2) {
                    Screen(title: "Screen 2", didTapNext: self.modelDelegate.didTapNextFromScreen2)
                    Flow(state: navigateTo3) {
                        BranchedScreen(
                            title: "Screen 3",
                            didTapNextA: self.modelDelegate.didTapNextAFromScreen3,
                            didTapNextB: self.modelDelegate.didTapNextBFromScreen3
                        )
                        Flow(state: navigateTo4) {
                            Screen(title: "Screen 4", didTapNext: self.modelDelegate.didTapNextFromScreen4)
                            Flow(state: navigateToFinalFrom4) {
                                FinalScreen()
                            }
                        }
                        Flow(state: navigateToFinalFrom3) {
                            FinalScreen()
                        }
                    }
                }
            }
        }
    }
}
