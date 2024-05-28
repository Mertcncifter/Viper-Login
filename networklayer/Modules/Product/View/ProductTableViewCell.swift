//
//  ProductTableViewCell.swift
//  networklayer
//
//  Created by mert can çifter on 27.05.2024.
//

import UIKit
import SnapKit
import SDWebImage

class ProductTableViewCell: UITableViewCell {

    static let identifier = String(describing: ProductTableViewCell.self)


    var model: Product? {
        didSet {
            
            guard let model = model else {
                return
            }
            
            self.titleLabel.text = model.name
            self.priceLabel.text = "Price: $\(model.price ?? 0)"
            let randomInt = Int.random(in: 0..<100)
            customImageView.sd_setImage(with: URL(string: "https://picsum.photos/\(randomInt)"))
                    
        }
    }
    
    private lazy var customImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        return label
    }()
        
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = ""
        self.priceLabel.text = ""
        self.customImageView.image = nil
    }

}

extension ProductTableViewCell {
    
    func configureSubviews() {
        
        contentView.addSubview(customImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)

        customImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(5)
            make.left.equalTo(contentView.snp.left).offset(5)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
            make.width.equalTo(150)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.left.equalTo(customImageView.snp.right).offset(5)
        }
    
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(customImageView.snp.right).offset(5)
        }
        
    }
}


extension ProductTableViewCell {
    func configure(model: Product) {
        self.model = model
    }
}
