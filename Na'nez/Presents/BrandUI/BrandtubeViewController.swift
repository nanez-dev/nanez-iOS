//스위프트 패키지 메뉴얼
import UIKit

class BrandtubeViewController: BaseViewController {
    private var brands: [Brand] = []
    private var popularBrands: [Brand] = []
    private let api = BrandService()
    private let brandtubeView: BrandtubeView = BrandtubeView(frame: .zero)
    private let navibar: CustomNaviBar = CustomNaviBar(frame: .zero)
    
    private let scrollView = UIScrollView()
  
    
    override func layout(){
        self.navibar.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.width.equalToSuperview().offset(0)
            $0.height.equalTo(52)
        }
        self.brandtubeView.snp.makeConstraints {
            $0.top.equalTo(self.navibar.snp.bottom)
            $0.bottom.trailing.leading.equalToSuperview()
        }
    }
    
    override func configure(){
        self.view.backgroundColor = .white
        brandtubeView.brandCollectionView.delegate = self
        brandtubeView.brandCollectionView.dataSource = self
        brandtubeView.brandCollectionView2.delegate = self
        brandtubeView.brandCollectionView2.dataSource = self
        self.navibar.delegate = self
        self.navibar.navititleLabel.text = "브랜드관"
        self.view.addSubview(navibar)
        self.view.addSubview(brandtubeView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.api.getPoularBrands { response in
            switch response {
            case .success(let brandList):
                self.popularBrands = brandList.brands
                DispatchQueue.main.async {
                    self.brandtubeView.brandCollectionView.reloadData()
                }
            case .failure(_):
                break
            }
        }
        self.api.getAllBrand { response in
            switch response {
            case .success(let brandList):
                self.brands = brandList.brands
                print(self.brands.count)
                DispatchQueue.main.async {
                    self.brandtubeView.brandCollectionView2.reloadData()
                }
            case .failure(_):
                break
            }
        }
    }
}
extension BrandtubeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == brandtubeView.brandCollectionView {
            return popularBrands.count
        }
        else{
            return brands.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == brandtubeView.brandCollectionView2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandCollectionViewCell.identifier, for: indexPath) as! BrandCollectionViewCell
            let brandinfo = self.brands[indexPath.row]
            cell.brandLabel.text = brandinfo.kor
            if let imageURL = URL(string: brandinfo.image ?? APIConstants.noImage) {
                cell.Img.kf.setImage(with: imageURL)
            }
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandCollectionViewCell.identifier, for: indexPath) as! BrandCollectionViewCell
            let brandinfo = self.popularBrands[indexPath.row]
            cell.brandLabel.text = brandinfo.kor
            if let imageURL = URL(string: brandinfo.image ?? APIConstants.noImage) {
                cell.Img.kf.setImage(with: imageURL)
            }
            return cell
        }

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == brandtubeView.brandCollectionView {
            self.api.getBrandDetail(brand_id:self.popularBrands[indexPath.row].id, limit: 3) { resonse in
                switch resonse{
                case .success(let result):
                    let vc = DetailBrandViewController()
                    vc.brandinfo = result
                    vc.modalPresentationStyle = .fullScreen
                     self.present(vc,animated: false,completion: nil)
                case .failure(_):
                    print("상세브랜드정보 오류")
                }
            }
        }
        else{
            self.api.getBrandDetail(brand_id:self.brands[indexPath.row].id, limit: 3) { resonse in
                switch resonse{
                case .success(let result):
                    let vc = DetailBrandViewController()
                    vc.brandinfo = result
                    vc.modalPresentationStyle = .fullScreen
                     self.present(vc,animated: false,completion: nil)
                case .failure(_):
                    print("상세브랜드정보 오류")
                }
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == brandtubeView.brandCollectionView {
            if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
                    let cellWidth: CGFloat = (collectionView.bounds.width - layout.minimumInteritemSpacing) / 2
                let cellHeight: CGFloat = (collectionView.bounds.height - layout.minimumLineSpacing) / 2 // 셀의 높이
                    return CGSize(width: cellWidth, height: cellHeight)
                }
            return CGSize(width: 0, height: 0)

        }else{
            if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
                    let cellWidth: CGFloat = (collectionView.bounds.width - layout.minimumInteritemSpacing) / 2
                let cellHeight: CGFloat = (collectionView.bounds.height - layout.minimumLineSpacing) / 24 // 셀의 높이
                    return CGSize(width: cellWidth, height: cellHeight)
                }
            return CGSize(width: 0, height: 0)

        }
    }
}
extension BrandtubeViewController: CustomNaviBarDelegate {
    func backBtnClick(_ navibar: CustomNaviBar) {
        self.dismiss(animated: false)
    }
    
    func searchBtnClick(_ navibar: CustomNaviBar) {
        
    }
    
    
}
