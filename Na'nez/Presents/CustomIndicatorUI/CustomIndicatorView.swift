//
//  CustomIndicatorView.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 1/12/24.
//

import UIKit
import Lottie

class CustomIndicatorView: UIView {
    let animationView: LottieAnimationView = .init(name: "loading")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAnimation() {
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        addSubview(animationView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        animationView.frame = bounds
    }
    
    func startAnimating() {
        animationView.play()
    }
    
    func stopAnimating() {
        animationView.stop()
    }
}
