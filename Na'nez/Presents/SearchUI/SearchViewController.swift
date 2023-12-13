//
//  SearchViewController.swift
//  Na'nez
//
//  Created by 최지철 on 2023/12/13.
//

import UIKit

import RxSwift
import RxCocoa

class SearchViewController: BaseViewController {
    
    private let viewModel: SearchViewModel
    
    private let naviBar: CustomNaviBar = CustomNaviBar(frame: .zero)
    
    private let searchBar = UITextField().then {
        $0.backgroundColor = .clear
        $0.text = ""
    }
    
    private let searchTableView = UITableView().then{
        $0.backgroundColor = .white
        $0.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        naviBar.navititleLabel.isHidden = true
        self.naviBar.delegate = self
    }
    
    override func addview() {
        self.view.addSubview(naviBar)
        self.naviBar.addSubview(searchBar)
        self.view.addSubview(searchTableView)
    }
    
    override func layout() {
        self.naviBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.width.equalToSuperview()
            $0.height.equalTo(52)
        }
        self.searchBar.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.horizontalEdges.equalToSuperview().inset(65)
            $0.verticalEdges.equalToSuperview().inset(14)
        }
        self.searchTableView.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    override func binding() {
        
        let input = SearchViewModel.Input(searchText: searchBar.rx.text.orEmpty.asObservable(),
                                          updateSearchList: { [weak self] name in
                                              self?.viewModel.updateSearchList(name: name, offset: 0, limit: 1)
                                          })
        let output = viewModel.transform(input: input)

        output.searchResult
            .bind(to: self.searchTableView.rx.items(cellIdentifier: SearchTableViewCell.identifier,
                                                    cellType: SearchTableViewCell.self))
        { index, item, cell  in
            cell.configureCell(item)
        }
        .disposed(by: disposebag)
    }
}
extension SearchViewController: CustomNaviBarDelegate {
    func backBtnClick(_ navibar: CustomNaviBar) {
        
    }
    
    func searchBtnClick(_ navibar: CustomNaviBar) {
        
    }
}
