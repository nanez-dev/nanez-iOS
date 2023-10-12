//
//  WishListViewController.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/13.
//

import UIKit

final class WishListViewController: BaseViewController {
    private let wishlistView:WishListView = WishListView(frame: .zero)
    private var navibar: CustomNaviBar = CustomNaviBar(frame: .zero)
    private let havelistView:HaveListView = HaveListView(frame: .zero)

    public let segment = SegmentController(frame: .zero).then {
        $0.insertSegment(withTitle: "위시리스트", at: 0, animated: false)
        $0.insertSegment(withTitle: "보유리스트", at: 1, animated: false)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray,
        .font: UIFont.pretendard(.Regular, size: 16)
        ], for: .normal)
        $0.setTitleTextAttributes(
        [
            NSAttributedString.Key.foregroundColor: UIColor.mainturquoise,
            .font: UIFont.pretendard(.Regular, size: 16)
        ], for: .selected
        )
    }
    
    override func layout() {
        navibar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            $0.width.equalToSuperview().offset(0)
            $0.height.equalTo(52)
        }
        self.segment.snp.makeConstraints{
            $0.top.equalTo(navibar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        self.havelistView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        self.wishlistView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    override func configure() {
        self.view.addSubview(navibar)
        self.view.addSubview(segment)
        self.view.addSubview(wishlistView)
        self.view.addSubview(havelistView)
        self.havelistView.isHidden = true
        self.wishlistView.isHidden = false
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        self.navibar.delegate = self
        self.navibar.backBtn.isHidden = true
        self.navibar.navititleLabel.text = "보관함"
    }
    
    @objc private func segmentValueChanged() {
            // Segment 선택에 따라 뷰 전환
            if segment.selectedSegmentIndex == 0 {
                wishlistView.isHidden = false
                havelistView.isHidden = true
            } else {
                wishlistView.isHidden = true
                havelistView.isHidden = false
            }
        }
}
extension WishListViewController: CustomNaviBarDelegate{
    func backBtnClick(_ navibar: CustomNaviBar) {
        
    }
    func searchBtnClick(_ navibar: CustomNaviBar) {
        
    }
}

