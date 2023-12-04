//스위프트 패키지 메뉴얼
import UIKit

class BrandtubeViewController: BaseViewController {
    private let viewModel: BrandViewModel
    private let navibar: CustomNaviBar = CustomNaviBar(frame: .zero)
    private let scrollView = UIScrollView()
    private let brandCollectionView2 =  UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 7
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: 164, height: 116)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
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
    private let contentView = UIView().then{
        $0.backgroundColor = .white
    }
    
    init(_ viewModel: BrandViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.updateAllBrands()
    }
    
    override func configure(){
        self.view.backgroundColor = .white
        self.navibar.navititleLabel.text = "브랜드관"
        self.navibar.searchBtn.isHidden = true
        self.navibar.delegate = self
    }
    
    override func addview(){
       self.view.addSubview(navibar)
       self.view.addSubview(scrollView)
       self.scrollView.addSubview(contentView)
       self.contentView.addSubview(brandCollectionView2)
       self.contentView.addSubview(brandLabel2)
       self.contentView.addSubview(brandLabel)
       self.contentView.addSubview(brandCollectionView)
   }
  
    override func layout(){
        self.navibar.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.width.equalToSuperview().offset(0)
            $0.height.equalTo(52)
        }
        self.brandCollectionView2.snp.makeConstraints{
            $0.top.equalTo(brandLabel2.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
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
        self.contentView.snp.makeConstraints{
            $0.width.equalToSuperview().offset(0)
            $0.edges.equalToSuperview().offset(0)
            $0.height.equalTo(3350)
        }
        self.scrollView.snp.makeConstraints{
            $0.top.equalTo(self.navibar.snp.bottom).offset(0)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    override func binding() {
        
        viewModel.brands
            .bind(to: self.brandCollectionView2.rx
                .items(cellIdentifier: BrandCollectionViewCell.identifier , cellType: BrandCollectionViewCell.self))
        { index, item, cell in
            cell.configureCell(item)
        }
            .disposed(by: disposebag)

    }
}
extension BrandtubeViewController: CustomNaviBarDelegate {
    func backBtnClick(_ navibar: CustomNaviBar) {
        self.navigationController?.popViewController(animated: true)
    }
    func searchBtnClick(_ navibar: CustomNaviBar) {
        
    }
}


