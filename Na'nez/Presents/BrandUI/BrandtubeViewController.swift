//스위프트 패키지 메뉴얼
import UIKit

class BrandtubeViewController: UIViewController {
    private var brands:[Brand] = []
    private var popularBrands:[Brand] = []
    private let api = BrandService()
    private let scrollView = UIScrollView()
    private let brandCollectionView2 =  UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout = UICollectionViewFlowLayout()
        $0.register(BrandCollectionViewCell.self, forCellWithReuseIdentifier: BrandCollectionViewCell.identifier)
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    private let brandCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout = UICollectionViewFlowLayout()
        $0.register(BrandCollectionViewCell.self, forCellWithReuseIdentifier: BrandCollectionViewCell.identifier)
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    private let brandLabel2 = UILabel().then{
        $0.text = "모든 브랜드"
        $0.font = .pretendard(.Bold, size: 20)
        $0.textColor = UIColor(rgb: 0x333333)
        $0.backgroundColor = .clear
    }
    private let brandLabel = UILabel().then{
        $0.text = "지금, 사랑받고 있는 브랜드"
        $0.font = .pretendard(.Bold, size: 20)
        $0.textColor = UIColor(rgb: 0x333333)
        $0.backgroundColor = .clear
    }
    private let navititleLabel = UILabel().then{
        $0.text = "브랜드관"
        $0.font = .pretendard(.Bold, size: 18)
        $0.textColor = UIColor(rgb: 0x333333)
    }
    private let backBtn = UIButton().then{
        $0.setImage(UIImage(named: "Nan'Nez_Back"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.tintColor = UIColor(rgb: 0x333333)
    }
    private let customNaviBar = UIView().then{
        $0.backgroundColor = .white
    }
    private let contentView = UIView().then{
        $0.backgroundColor = .white
    }
    
    
    private func layout(){
        self.brandCollectionView2.snp.makeConstraints{
            $0.top.equalTo(brandLabel2.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.bottom.equalToSuperview().offset(-20)
        }
        self.brandLabel2.snp.makeConstraints{
            $0.top.equalTo(brandCollectionView.snp.bottom).offset(26)
            $0.leading.equalToSuperview().offset(24)
            
        }
        self.brandCollectionView.snp.makeConstraints{
            $0.top.equalTo(brandLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(280)
        }
        self.brandLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(26)
            $0.leading.equalToSuperview().offset(24)
        }
        self.navititleLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        self.backBtn.snp.makeConstraints{
            $0.top.equalToSuperview().offset(14)
            $0.leading.equalToSuperview().offset(24)
            $0.height.equalTo(24)
            
        }
        self.contentView.snp.makeConstraints{
            $0.width.equalToSuperview().offset(0)
            $0.edges.equalToSuperview().offset(0)
            $0.height.equalTo(3500)
        }
        self.scrollView.snp.makeConstraints{
            $0.top.equalTo(customNaviBar.snp.bottom).offset(0)
            $0.left.right.bottom.equalToSuperview()
        }
        self.customNaviBar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            $0.width.equalToSuperview().offset(0)
            $0.height.equalTo(52)
        }
    }
    
    
    private func addsubview(){
        self.contentView.addSubview(brandCollectionView2)
        self.contentView.addSubview(brandLabel2)
        self.contentView.addSubview(brandLabel)
        self.contentView.addSubview(brandCollectionView)
        self.view.addSubview(customNaviBar)
        self.customNaviBar.addSubview(backBtn)
        self.customNaviBar.addSubview(navititleLabel)
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)

    }
    
    
    private func configure(){
        self.view.backgroundColor = .white
        self.backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        self.brandCollectionView.delegate = self
        self.brandCollectionView.dataSource = self
        self.brandCollectionView2.delegate = self
        self.brandCollectionView2.dataSource = self
    }
    @objc private func backBtnClick(){
        self.dismiss(animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.addsubview()
        self.layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.api.getPoularBrands { response in
            switch response {
            case .success(let brandList):
                self.popularBrands = brandList.brands
                DispatchQueue.main.async {
                    self.brandCollectionView.reloadData()
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
                    self.brandCollectionView2.reloadData()
                }
            case .failure(_):
                break
            }
        }
    }
}
extension BrandtubeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == brandCollectionView {
            return popularBrands.count
        }
        else{
            return brands.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == brandCollectionView2 {
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
        if collectionView == brandCollectionView {
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
        if collectionView == brandCollectionView {
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
