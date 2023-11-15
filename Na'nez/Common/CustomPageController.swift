//
//  CustomPageController.swift
//  Na'nez
//
//  Created by 최지철 on 2023/10/13.
//

import UIKit

class CustomPageController: UIPageControl {
    let activeImage = UIImage(named: "activeDot")
    let inactiveImage = UIImage(named: "inactiveDot")

    override var numberOfPages: Int {
        didSet {
            updateDots()
        }
    }

    override var currentPage: Int {
        didSet {
            updateDots()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateDots()
    }

    func updateDots() {
        for (index, dotView) in subviews.enumerated() {
            if let dotImageView = dotView as? UIImageView {
                dotImageView.image = (index == currentPage) ? activeImage : inactiveImage
            } else {
                dotView.clipsToBounds = false
                let dotImageView = UIImageView(image: (index == currentPage) ? activeImage : inactiveImage)
                dotView.addSubview(dotImageView)
            }
        }
    }
}
