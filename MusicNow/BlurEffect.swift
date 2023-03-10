//
//  BlurEffect.swift
//  MusicStreaming
//
//  Created by 안윤진 on 2023/03/09.
//
//blur effect 참고 https://medium.com/@edwurtle/blur-effect-inside-swiftui-a2e12e61e750
import SwiftUI
struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
