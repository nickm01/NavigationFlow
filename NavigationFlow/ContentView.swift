//
//  ContentView.swift
//  NavigationFlow
//
//  Created by Nick McConnell on 5/3/20.
//  Copyright © 2020 Nick McConnell. All rights reserved.
//

import SwiftUI

struct FlowLink<Content>: View where Content: View {
    var isActive: Binding<Bool> {
        didSet {
            if isActive.wrappedValue {
                _isActive = true
            }
        }
    }
    @State private var _isActive: Bool = false {
        didSet {
            print("-=- _isActive:\(_isActive)")
            if !_isActive {
                _isActive = true
            }
        }
    }
    var content: Content
    var body: some View {
        NavigationLink(
            destination: ZStack(alignment: .center) { content },
            isActive: $_isActive
        ) {
            EmptyView()
        }
    }
    init(isActive: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.isActive = isActive
        self.content = content()
    }
}
//
//struct ContentView: View {
//    var body: some View {
//        NavigationView {
//            Text("Screen One")
//                .navigationBarTitle(Text("Screen One"), displayMode: .inline)
//                .navigationBarItems(trailing:
//                    NavigationLink(destination: ScreenTwoView()) {
//                        Text("Screen Two")
//                    }
//            )
//        }
//    }
//}

class NavigationFlowModel2: ObservableObject {
    @Published var navToView2 = false
    @Published var navToView2B = false
    @Published var navToView3 = false
    @Published var navToView4 = false
    @Published var navToView5 = false
}

//    func didView2RequestNext() {
//        navToView2B = true
//    }
//
//    func didView3RequestNext() {
//        navToView2B = true
//    }
//
//    func didView4RequestNext() {
//        navToView2B = true
//    }
//
//    func didView5RequestNext() {
//        navToView2B = true
//    }
//}

typealias NavigationBinding = (next: Binding<Bool>, nextView: AnyView)

//struct NavigationBinding {
//    var next: Bool
//    let nextView: AnyView
//}

/*
TODOs:
1. Don't need the navigation model.  Instead switch to using @State instead of binding and use a FlowController and an enum
*/

struct ContentView2: View {

    var view2: View2!
    var view2B: View2B!
    var view3: View3!
    var view4: View4!
    var view5: View5!
    @ObservedObject var model: NavigationFlowModel2
    //@State private var navigateToScreen2 = false

    init() {
        model = NavigationFlowModel2()
        view5 = View5()
        view4 = View4()
        view3 = View3(model: model, view4: view4, view5: view5, next4: $model.navToView4, next5: $model.navToView5)
        view2B = View2B(model: model, view3: view3, next: $model.navToView3)
        //view2 = AnyView(SingleFlowView(content: AnyView(Screen2(model: model)), nextView: AnyView(view2B)))
        view2 = View2(model: model,view2B: view2B, next: $model.navToView2B)
        self.model = model
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text("View")
                Button(action: { self.model.navToView2 = true }, label: { Text("Next") })
                NavigationLink(destination: view2, isActive: self.$model.navToView2) {//$navigateToScreen2) {
                    EmptyView() //Text("View1")
                }
            }
        }
    }
}

struct View2: View {
    //@State private var navigateToScreen3 = false
    //@State var navToView3: Bool = false
    @ObservedObject var model: NavigationFlowModel2
    let view2B: View2B
    @Binding var next: Bool
    //var nav: NavigationBinding

    var body: some View {
        VStack(alignment: .center) {
            Text("View2")
            //Button(action: { self.navigateToScreen3 = true }, label: { Text("Next") })
            Button(action: { self.model.navToView2B = true }, label: { Text("Next") })
            NavigationLink(destination: view2B, isActive: self.$next) {//self.$model.navToView3) {
                EmptyView()
                //Text("View2")
            }
        }
    }
}

struct View2B: View {
    //@State private var navigateToScreen3 = false
    @ObservedObject var model: NavigationFlowModel2
    //@State var navToView3: Bool = false
    let view3: View3
    @Binding var next: Bool

    var body: some View {
        VStack(alignment: .center) {
            Text("View2B")
            //Button(action: { self.navigateToScreen3 = true }, label: { Text("Next") })
            Button(action: { self.model.navToView3 = true }, label: { Text("Next") })
            NavigationLink(destination: view3, isActive: self.$next) {//self.$model.navToView3) {
                EmptyView()
                //Text("View2")
            }
        }
    }
}

struct View3: View {
    //@State private var navigateToScreen4 = false
    @ObservedObject var model: NavigationFlowModel2
    let view4: View4
    let view5: View5
    @Binding var next4: Bool
    @Binding var next5: Bool

    var body: some View {
        VStack(alignment: .center) {
            Text("View3")
            //Button(action: { self.navigateToScreen4 = true }, label: { Text("Next") })
            Button(action: { self.model.navToView4 = true }, label: { Text("Next4") })
            NavigationLink(destination: view4, isActive: self.$next4) {//self.$model.navToView4) {//$navigateToScreen4) {
                EmptyView() //Text("View3")
            }
            Button(action: { self.model.navToView5 = true }, label: { Text("Next5") })
            NavigationLink(destination: view5, isActive: self.$next5) {//$model.navToView5) {//$navigateToScreen4) {
                EmptyView() //Text("View3")
            }
        }
    }
}

struct View4: View {
    var body: some View {
        Text("View4")
    }
}

struct View5: View {
    var body: some View {
        Text("View5")
    }
}

//class NavigationFlowModel: ObservableObject {
//    @Published var navigateToScreen2 = false {
//        didSet {
//            navigationTag = 2
//            print("-=---- set 2:\(navigateToScreen2)")
//            printStatus()
//        }
//    }
//    @Published var navigateToScreen3 = false {
//        didSet {
//            navigationTag = 3
//            print("-=---- set 3:\(navigateToScreen3)")
//            printStatus()
//        }
//    }
//    @Published var navigateToScreen4 = false {
//        didSet {
//            if navigateToScreen4 {
//                navigateToScreen3 = false
//            }
//            navigationTag = 4
//            print("-=---- set 4:\(navigateToScreen4)")
//            printStatus()
//        }
//    }
//    @Published var navigateToScreen5 = false {
//        didSet {
//            navigationTag = 5
//            print("-=---- set 5:\(navigateToScreen5)")
//            printStatus()
//        }
//    }
//    @Published var navigateToScreen6 = false
//
//    @Published var navigationTag: Int? = 1 {
//        didSet {
//            //print("-=- set Tag:\(navigationTag ?? 0)")
//        }
//    }
//
//    func printStatus() {
//        print("-=- 2:\(navigateToScreen2)")
//        print("-=- 3:\(navigateToScreen3)")
//        print("-=- 4:\(navigateToScreen4)")
//        print("-=- 5:\(navigateToScreen5)")
//
//    }
//}

//struct FlowView: View {
//    @State var navigateToScreen2 = false
//    @State var navigateToScreen3 = false
//    @State var navigateToScreen4 = false
//    var body: some View {
//        NavigationView {
//            VStack {
//                Text("Screen 1")
//                Button(action: { self.navigateToScreen2 = true }, label: { Text("Next") })
//                NavigationLink(destination:
//                    VStack {
//                        Text("Screen 2")
//                        Button(action: { self.navigateToScreen3 = true }, label: { Text("Next") })
//                        NavigationLink(destination:
//                           VStack {
//                                Text("Screen 3")
//                                Button(action: { self.navigateToScreen4 = true}, label: { Text("Next") })
//                                NavigationLink(destination:
//                                    Text("Screen 4"),
//                                    isActive: .constant(self.navigateToScreen4),
//                                    label: { EmptyView() }
//                                )
//                            },
//                            isActive: .constant(self.navigateToScreen3),
//                            label: { EmptyView() }
//                        )
//                    },
//                    isActive: .constant(self.navigateToScreen2),
//                    label: { EmptyView() }
//                )
//            }
//        }
//    }
//}

//struct FlowView2: View {
//    @ObservedObject var model: NavigationFlowModel
//    var body: some View {
//        NavigationView {
//            ZStack(alignment: .center) {
//                Text("Screen 1")
//                Button(action: { self.model.navigateToScreen2 = true }, label: { Text("Next") })
//                NavigationLink(destination:
//                    ZStack(alignment: .center) {
//                        Text("Screen 2")
//                        Button(action: { self.model.navigateToScreen3 = true }, label: { Text("Next") })
//                        NavigationLink(destination:
//                            ZStack(alignment: .center) {
//                                Text("Screen 2")
//                                Button(action: { self.model.navigateToScreen4 = true }, label: { Text("Next") })
//                                NavigationLink(destination:
//                                    Text("Screen 4"),
//                                    isActive: self.$model.navigateToScreen4,
//                                    label: { EmptyView() }
//                                )
//                            },
//                            isActive: self.$model.navigateToScreen3,
//                            label: { EmptyView() }
//                        )
//                    },
//                    isActive: self.$model.navigateToScreen2,
//                    label: { EmptyView() }
//                )
//            }
//        }
    
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
//                    ZStack(alignment: .center) {
//                        FlowScreenView(title: "Screen 2", didComplete: self.$model.navigateToScreen3)
//                        NavigationLink(destination:
//                            ZStack(alignment: .center) {
//                                FlowScreenView(title: "Screen 3", didComplete: self.$model.navigateToScreen4)
//                                NavigationLink(destination:
//                                    Text("Screen 4"),
//                                    isActive: self.$model.navigateToScreen4,
//                                    label: { EmptyView() }
//                                )
//                            },
//                            isActive: self.$model.navigateToScreen3,
//                            label: { EmptyView() }
//                        )
//                    },
//                    isActive: self.$model.navigateToScreen2,
//                    label: { EmptyView() }
//                )
//            }
//        }//.debug()
        
// NAVIGATION TAG APPROACH
        
//        NavigationView {
//            ZStack(alignment: .center) {
//                FlowScreenView(title: "Screen 1", didComplete: self.$model.navigateToScreen2)
//                NavigationLink(destination:
//                        ZStack(alignment: .center) {
//                            FlowScreenView(title: "Screen 2", didComplete: self.$model.navigateToScreen3)
//                        }
//                    , tag: 2, selection: self.$model.navigationTag,
//                    label: { EmptyView() }
//                )
//                NavigationLink(destination:
//                    Text("new screen")
//                    , tag: 3, selection: self.$model.navigationTag,
//                      label: { EmptyView() }
//                )
//            }
//        }
        
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
//    }
//}




//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

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
