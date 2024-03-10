//
//  UIImageView+.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 2/28/24.
//

import UIKit
import Alamofire

extension UIImageView {
    func loadImage(from url: URL) {
        AF.request(url, method: .get).responseData { response in
            switch response.result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
