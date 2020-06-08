//
//  Screen.swift
//  NavigationFlow
//
//  Created by Nick McConnell on 5/31/20.
//  Copyright © 2020 Nick McConnell. All rights reserved.
//

import SwiftUI

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
