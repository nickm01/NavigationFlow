//
//  Flow.swift
//  NavigationFlow
//
//  Created by Nick McConnell on 6/7/20.
//  Copyright © 2020 Nick McConnell. All rights reserved.
//

import SwiftUI

class FlowState: ObservableObject {
    @Published var next: Bool = false
}

struct Flow<Content>: View where Content: View {
    @ObservedObject var state: FlowState
    var content: Content
    var body: some View {
        NavigationLink(
            destination: VStack() { content },
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

// see https://gist.github.com/chriseidhof/d2fcafb53843df343fe07f3c0dac41d5
struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
