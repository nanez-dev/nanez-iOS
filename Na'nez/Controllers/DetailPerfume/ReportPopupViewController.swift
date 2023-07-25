//
//  ReportPopupViewController.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/17.
//

import UIKit

class ReportPopupViewController: UIViewController {
    private let reportLabel = UILabel().then{
    $0.text = "신고하기"
        $0.font = .pretendard(.Bold, size: 16)
        $0.textColor = UIColor(rgb: 0x111111)
    }
    private func layout(){
        
    }
    private func addsubView(){
        
    }
    private func configure(){
        self.view.layer.cornerRadius = 12
        self.view.backgroundColor = .white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layout()
        self.addsubView()
    }

}
