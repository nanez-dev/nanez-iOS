//
//  CustomPageControlView.swift
//  Na'nez
//
//  Created by 최지철 on 2023/12/04.
//

import UIKit
import SnapKit

class CustomPageControlView: UIView {
    private let numberOfPages: Int
    private var currentPage: Int = 0 {
        didSet {
            updateIndicators()
        }
    }
    
    private var indicatorViews: [UIView] = []
    private let indicatorWidth: CGFloat = 16
    private let indicatorHeight: CGFloat = 8
    private let indicatorSpacing: CGFloat = 6
    
    init(numberOfPages: Int) {
        self.numberOfPages = numberOfPages
        super.init(frame: .zero)
        setupIndicators()
        updateIndicators()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupIndicators() {
        for _ in 0..<numberOfPages {
            let indicatorView = UIView()
            indicatorView.layer.cornerRadius = indicatorHeight / 2
            indicatorView.backgroundColor = UIColor(hexString: "##D9D9D9")
            addSubview(indicatorView)
            indicatorViews.append(indicatorView)
        }
    }
    
    private func updateIndicators() {
        for (index, indicatorView) in indicatorViews.enumerated() {
            UIView.animate(withDuration: 0.4) {
                indicatorView.backgroundColor = (index == self.currentPage) ? UIColor(hexString: "#424242") : UIColor(hexString: "##D9D9D9")
                indicatorView.alpha = (index == self.currentPage) ? 1.0 : 0.5
                let width = (index == self.currentPage) ? self.indicatorWidth : self.indicatorHeight
                indicatorView.snp.remakeConstraints {
                    $0.centerY.equalToSuperview()
                    $0.height.equalTo(self.indicatorHeight)
                    $0.width.equalTo(width)
                    if index == 0 {
                        $0.leading.equalToSuperview()
                    } else {
                        $0.leading.equalTo(self.indicatorViews[index - 1].snp.trailing).offset(self.indicatorSpacing)
                    }
                    if index == self.numberOfPages - 1 {
                        $0.trailing.equalToSuperview()
                    }
                }
                self.layoutIfNeeded()
            }
        }
    }

    
    func setCurrentPage(_ currentPage: Int) {
        guard currentPage >= 0 && currentPage < numberOfPages else { return }
        self.currentPage = currentPage
    }
}

