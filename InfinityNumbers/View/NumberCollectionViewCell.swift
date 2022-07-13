//
//  NumberCollectionViewCell.swift
//  InfinityNumbers
//
//  
//

import UIKit

class NumberCollectionViewCell: UICollectionViewCell {
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        numberLabel.text = ""
        backgroundColor = .clear
    }
    
    private func configure() {
        addSubViews()
        setConstrains()
    }
    
    private func addSubViews() {
        contentView.addSubview(numberLabel)
    }
    
    private func setConstrains() {
        numberLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setData(num: Int, row: Int) {
        numberLabel.text = num.description
        setColor(row)
        
    }
    
    private func setColor(_ index: Int) {
        let rowNum = index / 2
        if rowNum % 2 == 0 {
            if index % 2 == 0 {
                backgroundColor = .white
            } else{
                backgroundColor = .systemGray4
            }
        } else {
            if index % 2 == 0 {
                backgroundColor = .systemGray4
            } else{
                backgroundColor = .white
            }
        }
    }
}
