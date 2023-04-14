//
//  LottieView.swift
//  BitReal
//
//  Created by Ali Al-Adhami on 4/13/23.
//

//import Foundation
//import SwiftUI
//import Lottie
//
//struct LottieView: UIViewRepresentable {
//    var name = "floating-woman"
//    var loopMode: LottieLoopMode = .loop
//    var onAnimationFinished: (() -> Void)?
//    @State var finished = false
//
//    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
//        let view = UIView(frame: .zero)
//
//        let animationView = LottieAnimationView()
//        let animation = LottieAnimation.named(name)
//        animationView.animation = animation
//        animationView.contentMode = .scaleAspectFit
//        animationView.loopMode = loopMode
//        animationView.play { (finished) in
//            self.finished = true
//        }
//
//        animationView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(animationView)
//        NSLayoutConstraint.activate([
//            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
//            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
//        ])
//
//        return view
//    }
//
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//    }
//}


import Foundation
import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var name = "floating-woman"
    var loopMode: LottieLoopMode = .loop
    var onAnimationFinished: (() -> Void)?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)

        let animationView = LottieAnimationView()
        let animation = LottieAnimation.named(name)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        if context.coordinator.isAnimationPlaying == false {
            context.coordinator.isAnimationPlaying = true
            animationView.play { _ in
                context.coordinator.isAnimationPlaying = false
                onAnimationFinished?()
            }
        }

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }

    class Coordinator: NSObject {
        var parent: LottieView
        var isAnimationPlaying = false

        init(_ animationView: LottieView) {
            self.parent = animationView
        }

        // Implement other delegate methods if needed
    }
}

