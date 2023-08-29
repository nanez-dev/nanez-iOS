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

    override func layout() {
        navibar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            $0.width.equalToSuperview().offset(0)
            $0.height.equalTo(52)
        }
        wishlistView.snp.makeConstraints {
            $0.top.equalTo(navibar.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
    override func configure() {
        self.view.addSubview(navibar)
        self.view.addSubview(wishlistView)
        self.navibar.delegate = self
        self.navibar.backBtn.isHidden = true
        self.navibar.navititleLabel.text = "보관함"
        self.wishlistView.tableView.delegate = self
        self.wishlistView.tableView.dataSource = self
    }
}
extension WishListViewController: CustomNaviBarDelegate{
    func backBtnClick(_ navibar: CustomNaviBar) {
        
    }
    func searchBtnClick(_ navibar: CustomNaviBar) {
        
    }
}
extension WishListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PerfumeListTableViewCell.identifier, for: indexPath) as! PerfumeListTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
}
