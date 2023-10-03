//
//  WishListView.swift
//  Na'nez
//
//  Created by 최지철 on 2023/08/26.
//

import UIKit

class WishListView: BaseView {
    public let segment = SegmentController(frame: .zero).then {
        $0.insertSegment(withTitle: "위시리스트", at: 0, animated: false)
        $0.insertSegment(withTitle: "보유리스트", at: 1, animated: false)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        $0.setTitleTextAttributes(
        [
            NSAttributedString.Key.foregroundColor: UIColor.mainturquoise,
            .font: UIFont.pretendard(.SemiBold, size: 16)
        ], for: .selected
        )
    }
    public let tableView = UITableView().then{
        $0.backgroundColor = .white
        $0.register(PerfumeListTableViewCell.self, forCellReuseIdentifier: PerfumeListTableViewCell.identifier)
    }
    override func layout() {
        self.segment.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        self.tableView.snp.makeConstraints{
            $0.top.equalTo(segment.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
    override func addview() {
        self.addSubview(segment)
        self.addSubview(tableView)
    }
    override func configure() {
        self.segment.selectedSegmentIndex = 0
    }
}
