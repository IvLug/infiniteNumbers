//
//  FebonachiViewController.swift
//  InfinityNumbers
//
// 
//

import UIKit
import RxSwift

final class FebonachiViewController: BaseViewController {
    
    private let viewModel: FebonachiViewModelProtocol
    
    private lazy var collectionView: UICollectionView = {
        let layout = NumbersLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.registers(cellWithClass: NumberCollectionViewCell.self)
        view.backgroundColor = .white
        return view
    }()
    
    required init(viewModel: FebonachiViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.title = "Febonachi numbers"
    }
    
    private func configure() {
        addSubViews()
        setConstraints()
        bind()
    }
    
    private func addSubViews() {
        view.addSubview(collectionView)
    }
    
    private func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func bind() {
        collectionView.rx.didScroll.subscribe { [weak self] _ in
            guard let self = self else { return }
            let offSetY = self.collectionView.contentOffset.y
            let contentHeight = self.collectionView.contentSize.height
            
            if offSetY > (contentHeight - self.collectionView.frame.size.height - 100) {
                self.viewModel.fetchMoreDatas.on(.next(()))
            }
        }.disposed(by: bag)
        
        viewModel.numbers.asObservable()
            .bind(to: collectionView.rx.items) { (cv, row, item) -> UICollectionViewCell in
                let indexPath = IndexPath(row: row, section: 0)
                let cell: NumberCollectionViewCell = cv.dequeueCell(at: indexPath)
                cell.setData(num: item, row: row)
                return cell
            }.disposed(by: bag)
    }
}
