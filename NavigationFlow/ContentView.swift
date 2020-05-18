//
//  ContentView.swift
//  NavigationFlow
//
//  Created by Nick McConnell on 5/3/20.
//  Copyright © 2020 Nick McConnell. All rights reserved.
//

import SwiftUI

struct FlowLink<Content>: View where Content: View {
    var isActive: Binding<Bool>
    var content: Content
    var body: some View {
        NavigationLink(
            destination: ZStack(alignment: .center) { content },
            isActive: isActive
        ) {
            EmptyView()
        }
    }
    init(isActive: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.isActive = isActive
        self.content = content()
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            Text("Screen One")
                .navigationBarTitle(Text("Screen One"), displayMode: .inline)
                .navigationBarItems(trailing:
                    NavigationLink(destination: ScreenTwoView()) {
                        Text("Screen Two")
                    }
            )
        }
    }
}

class NavigationFlowModel: ObservableObject {
    @Published var navigateToScreen2 = false {
        didSet {
            navigationTag = 2
            print("-=- set 2:\(navigateToScreen2)")
        }
    }
    @Published var navigateToScreen3 = false {
        didSet {
            navigationTag = 3
            print("-=- set 3:\(navigateToScreen3)")
        }
    }
    @Published var navigateToScreen4 = false {
        didSet {
            navigationTag = 4
            print("-=- set 4:\(navigateToScreen4)")
        }
    }
    @Published var navigateToScreen5 = false {
        didSet {
            navigationTag = 5
            print("-=- set 5:\(navigateToScreen5)")
        }
    }
    @Published var navigateToScreen6 = false
    
    @Published var navigationTag: Int? = 1 {
        didSet {
            print("-=- set Tag:\(navigationTag ?? 0)")
        }
    }
}

struct FlowView: View {
    @ObservedObject var model: NavigationFlowModel
    var body: some View {
        
//FLOWLINK APPROACH
        
//        NavigationView {
//            ZStack(alignment: .center) {
//                FlowScreenView(title: "Screen 1", didComplete: self.$model.navigateToScreen2)
//                FlowLink(isActive: self.$model.navigateToScreen2) {
//                    FlowScreenView(title: "Screen 2", didComplete: self.$model.navigateToScreen3)
//                    FlowLink(isActive: self.$model.navigateToScreen3) {
//                        FlowScreenView(title: "Screen 3", didComplete: self.$model.navigateToScreen4)
//                        FlowLink(isActive: self.$model.navigateToScreen4) {
//                            FlowScreenView(title: "Screen 4", didComplete: self.$model.navigateToScreen5)
//                            FlowLink(isActive: self.$model.navigateToScreen5) {
//                                FlowScreenView(title: "Screen 5", didComplete: .constant(false))
//                            }
//                        }
//                    }
////                    FlowLink(isActive: self.$model.navigateToScreen4) {
////                        FlowScreenView(title: "Screen 4", didComplete: self.$model.navigateToScreen5)
////                        FlowLink(isActive: self.$model.navigateToScreen5) {
////                            FlowScreenView(title: "Screen 5", didComplete: .constant(false))
////                        }
////                    }
//                }
//            }
//        }.debug()
        
// NAVIGATION LINK APPROACH
        
//        NavigationView {
//            ZStack(alignment: .center) {
//                FlowScreenView(title: "Screen 1", didComplete: self.$model.navigateToScreen2)
//                NavigationLink(destination:
//                    LazyView(ZStack(alignment: .center) {
//                        FlowScreenView(title: "Screen 2", didComplete: self.$model.navigateToScreen3)
//                        NavigationLink(destination:
//                            LazyView(ZStack(alignment: .center) {
//                                FlowScreenView(title: "Screen 3", didComplete: self.$model.navigateToScreen4)
//                                NavigationLink(destination:
//                                    LazyView(ZStack(alignment: .center) {
//                                        FlowScreenView(title: "Screen 4", didComplete: self.$model.navigateToScreen5)
//                                        NavigationLink(destination:
//                                            LazyView(
//                                                FlowScreenView(title: "Screen 5", didComplete: self.$model.navigateToScreen6)
//                                            ),
//                                            isActive: self.$model.navigateToScreen5,
//                                            label: { EmptyView() }
//                                        )
//                                    }),
//                                    isActive: self.$model.navigateToScreen4,
//                                    label: { EmptyView() }
//                                )
//                            }),
//                            isActive: self.$model.navigateToScreen3,
//                            label: { EmptyView() }
//                        )
//                    }),
//                    isActive: self.$model.navigateToScreen2,
//                    label: { EmptyView() }
//                )
//            }
//        }//.debug()
        
// NAVIGATION TAG APPROACH
        
        NavigationView {
            ZStack(alignment: .center) {
                FlowScreenView(title: "Screen 1", didComplete: self.$model.navigateToScreen2)
                NavigationLink(destination:
                        ZStack(alignment: .center) {
                            FlowScreenView(title: "Screen 2", didComplete: self.$model.navigateToScreen3)
                        }
                    , tag: 2, selection: self.$model.navigationTag,
                    label: { EmptyView() }
                )
                NavigationLink(destination:
                    Text("new screen")
                    , tag: 3, selection: self.$model.navigationTag,
                      label: { EmptyView() }
                )
            }
        }
        
//        NavigationView {
//            ZStack(alignment: .center) {
//                FlowScreenView(title: "Screen 1", didComplete: self.$model.navigateToScreen2)
//                NavigationLink(destination:
//                    FlowScreenView(title: "Screen 2", didComplete: self.$model.navigateToScreen3),
//                    isActive: self.$model.navigateToScreen2,
//                    label: { EmptyView() }
//                )
//                NavigationLink(destination:
//                    FlowScreenView(title: "Screen 3", didComplete: self.$model.navigateToScreen4),
//                    isActive: self.$model.navigateToScreen3,
//                    label: { EmptyView() }
//                )
//                NavigationLink(destination:
//                    FlowScreenView(title: "Screen 4", didComplete: self.$model.navigateToScreen5),
//                    isActive: self.$model.navigateToScreen4,
//                    label: { EmptyView() }
//                )
//            }
//        } //.debug()
    }
}


struct FlowScreenView: View {
    let title: String
    let id = UUID()
    @Binding var didComplete: Bool
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(title)
            Button(action: {
                self.didComplete = true
            }, label: {
                Text("Next")
            })
        }
    }
}

struct FlowScreenView3: View {
    let title: String
    let id = UUID()
    @Binding var didComplete: Bool
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(title)
            Button(action: {
                self.didComplete = true
            }, label: {
                Text("Next")
            })
        }
    }
}

struct FlowScreenView4: View {
    let title: String
    let id = UUID()
    @Binding var didComplete: Bool
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(title)
            Button(action: {
                self.didComplete = true
            }, label: {
                Text("Next")
            })
        }
    }
}

struct FlowScreenView5: View {
    let title: String
    let id = UUID()
    @Binding var didComplete: Bool
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(title)
            Button(action: {
                self.didComplete = true
            }, label: {
                Text("Next")
            })
        }
    }
}


struct FlowChoiceScreenView: View {
    let title: String
    @Binding var didCompleteFirstPath: Bool
    @Binding var didCompleteSecondPath: Bool
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(title)
            Button(action: {
                self.didCompleteFirstPath = true
            }, label: {
                Text("Next1")
            })
            Button(action: {
                self.didCompleteSecondPath = true
            }, label: {
                Text("Next2")
            })

        }
    }
}

struct ScreenOneView: View {
    var body: some View {
        Text("Screen Two")
    }
}

struct ScreenTwoView: View {
    var body: some View {
        Text("Screen Two")
    }
}


struct ScreenThreeView: View {
    var body: some View {
        Text("Screen Two")
    }
}

struct ScreenFourView: View {
    var body: some View {
        Text("Screen Four")
    }
}

struct ScreenFiveView: View {
    var body: some View {
        Text("Screen Five")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// see https://gist.github.com/chriseidhof/d2fcafb53843df343fe07f3c0dac41d5
// https://medium.com/better-programming/swiftui-navigation-links-and-the-common-pitfalls-faced-505cbfd8029b

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}
