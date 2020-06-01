//
//  CleanView.swift
//  NavigationFlow
//
//  Created by Nick McConnell on 5/31/20.
//  Copyright © 2020 Nick McConnell. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class NextState: ObservableObject {
    @Published var next: Bool = false
}

struct Flow: View {
    let content: AnyView
    let nextView: AnyView
    @ObservedObject private var nextState = NextState()
    var next: Bool = false {
        didSet {
            nextState.next = next
        }
    }

    init(_ content: AnyView, nextView: AnyView) {
        self.content = content
        self.nextView = nextView
    }

    var body: some View {
        VStack(alignment: .center) {
            content
            NavigationLink(destination: nextView, isActive: self.$nextState.next) {//self.$model.navToView3) {
                EmptyView()
            }
        }
    }
}

class FlowController: ObservableObject {

    var view: FlowControllerView!

    func didTapNextFromScreen1() {
        // Do some network actions before
        view.view1.next = true
    }

    func didTapNextFromScreen2() {
        // Do some network actions before
        view.view2.next = true
    }

    func didTapNextFromScreen3() {
        // Do some network actions before
        view.view3.next = true
    }

    init() {
        let view5 = Screen5().any
        let view4 = Screen4().any
        let view3 = Screen3(didTapNext: didTapNextFromScreen3).next(view4.any)
        let view2 = Screen2(didTapNext: didTapNextFromScreen2).next(view3.any)
        let view1 = Screen1(didTapNext: didTapNextFromScreen1).next(view2.any)
        view = FlowControllerView(
            view1: view1,
            view2: view2,
            view3: view3,
            view4: view4
        )
    }
}

extension View {
    func next(_ nextView: AnyView) -> Flow {
        return Flow(self.any, nextView: nextView)
    }
}


struct FlowControllerView: View {

    var view1: Flow!
    var view2: Flow!
    var view3: Flow!
    var view4: AnyView!
    var view5: AnyView!

    var body: some View {
        NavigationView {
            view1
        }
    }
}

struct Screen1: View {
    let didTapNext: () -> ()
    //let controller: FlowController
    var body: some View {
        VStack(alignment: .center) {
            Text("Screen 1")
            Button(action: { self.didTapNext() }, label: { Text("Next") })
        }
    }
}

struct Screen2: View {
    let didTapNext: () -> ()
    var body: some View {
        VStack(alignment: .center) {
            Text("Screen 2")
            Button(action: { self.didTapNext() }, label: { Text("Next") })
        }
    }
}

struct Screen3: View {
    let didTapNext: () -> ()
//    let didTapNext4: () -> ()
//    let didTapBranch5: () -> ()
    var body: some View {
        VStack(alignment: .center) {
            Text("Screen 3")
            Button(action: { self.didTapNext() }, label: { Text("Next") })
//            Button(action: { self.didTapNext4() }, label: { Text("Next") })
//            Button(action: { self.didTapBranch5() }, label: { Text("Next") })
        }
    }
}

struct Screen4: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("Screen 4")
        }
    }
}

struct Screen5: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("Screen 5")
        }
    }
}

extension View {
    var any: AnyView {
        return AnyView(self)
    }
}
