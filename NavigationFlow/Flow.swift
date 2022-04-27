//
//  Flow.swift
//  NavigationFlow
//
//  Created by Nick McConnell on 6/7/20.
//  Copyright © 2020 Nick McConnell. All rights reserved.
//

import SwiftUI

struct Flow<Content>: View where Content: View {
    @Binding var next: Bool
    var content: Content
    var body: some View {
        NavigationLink(
            destination: VStack() { content },
            isActive: $next
        ) {
            EmptyView()
        }
    }
    init(next: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._next = next
        self.content = content()
    }
}
