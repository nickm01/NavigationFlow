# Multi-Screen Data Entry Flow with SwiftUI and MVVM

I’ve recently been looking at the creation of a multi-screen onboarding flow for my next app and challenging myself to use SwiftUI completely. As with all mutli-screen data entry flows, they often represent an interesting problem of how to separate out data, view and navigation logic. I thought SwiftUI’s declarative nature and lean towards ViewModels would be a great opportunity.
Before we start what make’s a great multi-screen data entry flow? Here’s what I came up with. For want of a less grand term, I’ll call it my **“screen flow manifesto”**:

1. Screens should have no “parent” knowledge or be responsible for navigating in or out.
2. Individual ViewModels for every screen.
3. Overall flow control logic is separate to UI implementation and is testable without UI.
4. Flexible and allow for branching to different screens in the flow.
5. As simple as possible.

SwiftUI’s ObjectObservable and @ObservedObject pair seem to work well for ViewModels giving us the 2-way binding that has previously been missing in UIKit. There are obviously alot of approaches to ViewModels but I like to think of them as data interfaces to the view code— the view represented simply as data where the only way for the rest of the app to talk to the view is through the view model.

But ViewModel implementation will be discussed in part 2. This is part 1 - Navigation.

Reade more [here](https://medium.com/@nicmcconn/flow-with-swiftui-and-mvvm-7cc394440ab8)
