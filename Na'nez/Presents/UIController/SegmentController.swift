//
//  SegmentController.swift
//  Na'nez
//
//  Created by 최지철 on 2023/08/26.
//

import UIKit

class SegmentController: UISegmentedControl {
    private func removeBackgroundAndDivider() {
      let image = UIImage()
      self.setBackgroundImage(image, for: .normal, barMetrics: .default)
      self.setBackgroundImage(image, for: .selected, barMetrics: .default)
      self.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
      self.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
    private lazy var underlineView: UIView = {
      let width = self.bounds.size.width / CGFloat(self.numberOfSegments)
      let height = 2.0
      let xPosition = CGFloat(self.selectedSegmentIndex * Int(width))
      let yPosition = self.bounds.size.height - 1.0
      let frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
      let view = UIView(frame: frame)
        view.backgroundColor = .mainturquoise
      self.addSubview(view)
      return view
    }()
    
    override func layoutSubviews() {
      super.layoutSubviews()
      let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(self.selectedSegmentIndex)
      UIView.animate(
        withDuration: 0.2,
        animations: {
          self.underlineView.frame.origin.x = underlineFinalXPosition
        }
      )
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.removeBackgroundAndDivider()
    }
    override init(items: [Any]?) {
      super.init(items: items)
      self.removeBackgroundAndDivider()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
