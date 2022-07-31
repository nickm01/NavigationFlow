# Multi-Screen Data Entry Flow with SwiftUI

I’ve been looking at the creation of a multi-screen onboarding flow for my next app and challenging myself to use SwiftUI completely. As with all mutli-screen data entry flows, they often represent an interesting problem of how to separate out data, view and navigation logic. I thought SwiftUI’s declarative nature and lean towards view models would be a great opportunity.
Before we start what make’s a great multi-screen data entry flow? Here’s what I came up with. For want of a less grand term, I’ll call it my **“screen flow manifesto”**:

1. Screens should have no “parent” knowledge or be responsible for navigating in or out.
2. Individual ViewModels for every screen.
3. Overall flow control logic is separate to UI implementation and is testable without UI.
4. Flexible and allow for branching to different screens in the flow.
5. As simple as possible but scalable.

Note: This has been updated for SwiftUI 4 / Xcode 14.

Read more [here](https://betterprogramming.pub/flow-navigation-with-swiftui-4-e006882c5efa)

For SwiftUI 3: Read more [here](https://betterprogramming.pub/flow-navigation-with-swiftui-revisited-791f89421923), `swiftui3` branch

For SwiftUI 1: Read more [here](https://medium.com/swlh/flow-with-swiftui-and-mvvm-7cc394440ab8), `swiftui1.part1` and `swiftui1.part2` branches
