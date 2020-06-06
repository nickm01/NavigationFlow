//
//  CleanView.swift
//  NavigationFlow
//
//  Created by Nick McConnell on 5/31/20.
//  Copyright © 2020 Nick McConnell. All rights reserved.
//

import Foundation
import SwiftUI

class FlowState: ObservableObject {
    @Published var next: Bool = false
}

struct FlowLink<Content>: View where Content: View {
    @ObservedObject var state: FlowState
    var content: Content
    var body: some View {
        NavigationLink(
            destination: ZStack(alignment: .center) { content },
            isActive: $state.next
        ) {
            EmptyView()
        }
    }
    init(state: FlowState, @ViewBuilder content: () -> Content) {
        self.state = state
        self.content = content()
    }
}


class FlowController: ObservableObject {

    var view: FlowControllerView?

    init() {
        self.view = FlowControllerView(modelDelegate: self)
    }
}

extension FlowController: FlowControllerViewDelegate {
    func didTapNextFromScreen1() {
        // Do some network actions... then
        view?.navigate(to: .screen2)
    }

    func didTapNextFromScreen2() {
        // Do some network actions... then
        view?.navigate(to: .screen3)
    }

    func didTapNextAFromScreen3() {
        // Do some network actions... then
        view?.navigate(to: .screen4)
    }

    func didTapNextBFromScreen3() {
        // Do some network actions... then
        view?.navigate(to: .finalFrom3)
    }

    func didTapNextFromScreen4() {
        // Do some network actions... then
        view?.navigate(to: .finalFrom4)
    }
}


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
            ZStack(alignment: .center) {
                Screen(title: "Screen 1", didTapNext: self.modelDelegate.didTapNextFromScreen1)
                FlowLink(state: navigateTo2) {
                    Screen(title: "Screen 2", didTapNext: self.modelDelegate.didTapNextFromScreen2)
                    FlowLink(state: navigateTo3) {
                        BranchedScreen(
                            title: "Screen 3",
                            didTapNextA: self.modelDelegate.didTapNextAFromScreen3,
                            didTapNextB: self.modelDelegate.didTapNextBFromScreen3
                        )
                        FlowLink(state: navigateTo4) {
                            Screen(title: "Screen 4", didTapNext: self.modelDelegate.didTapNextFromScreen4)
                            FlowLink(state: navigateToFinalFrom4) {
                                FinalScreen()
                            }
                        }
                        FlowLink(state: navigateToFinalFrom3) {
                            FinalScreen()
                        }
                    }
                }
            }
        }
    }
}

struct Screen: View {
    let title: String
    let didTapNext: () -> ()
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
            Button(action: { self.didTapNext() }, label: { Text("Next") })
        }
    }
}

struct BranchedScreen: View {
    let title: String
    let didTapNextA: () -> ()
    let didTapNextB: () -> ()
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
            Button(action: { self.didTapNextA() }, label: { Text("Next-A") })
            Button(action: { self.didTapNextB() }, label: { Text("Next-B") })
        }
    }
}

struct FinalScreen: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("Final")
        }
    }
}
