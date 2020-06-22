# Multi-Screen Data Entry Flow with SwiftUI and MVVM

I’ve recently been looking at the creation of a multi-screen onboarding flow for my next app and challenging myself to use SwiftUI completely. As with all mutli-screen data entry flows, they often represent an interesting problem of how to separate out data, view and navigation logic. I thought SwiftUI’s declarative nature and lean towards ViewModels would be a great opportunity.
Before we start what make’s a great multi-screen data entry flow? Here’s what I came up with. For want of a less grand term, I’ll call it my **“screen flow manifesto”**:

1. Screens should have no “parent” knowledge or be responsible for navigating in or out.
2. Individual ViewModels for every screen.
3. Overall flow control logic is separate to UI implementation and is testable without UI.
4. Flexible and allow for branching to different screens in the flow.
5. As simple as possible.

Read more

[part1](https://medium.com/@nicmcconn/flow-with-swiftui-and-mvvm-7cc394440ab8)

[part2](https://medium.com/@nicmcconn/flow-with-swiftui-and-mvvm-part-2-viewmodels-905ecc05f1c5)

### Branches

`master` - code for part 1 - Navigation

`part2` - code for part 2 - a more comprehensive implementation which includes Navigation and ViewModels
