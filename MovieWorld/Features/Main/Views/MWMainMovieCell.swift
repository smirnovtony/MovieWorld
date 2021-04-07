//
//  MWMainMovieCell.swift
//  MovieWorld
//
//  Created by Анастасия Корнеева on 5.04.21.
//

import UIKit
import SnapKit

class MWMainMovieCell: UICollectionViewCell {

    static let reuseIdentifier: String = "MWMovieCell"

    private let imageSize = CGSize(width: 130, height: 185)

    private lazy var logoView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.layer.masksToBounds = true

        return image
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor(named: "mainTextColor")

        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(named: "mainTextColor")

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear

        self.contentView.addSubview(self.logoView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.descriptionLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        self.logoView.snp.updateConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.size.equalTo(self.imageSize)
        }

        self.titleLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.logoView.snp.bottom).offset(12)
            make.left.right.equalToSuperview()
        }

        self.descriptionLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }

        super.updateConstraints()
    }

    func set(movie: MWMovie) {
        self.logoView.image = UIImage(named: "movieStub")
        self.titleLabel.text = movie.title
        self.descriptionLabel.text = movie.overview

        self.setNeedsUpdateConstraints()
    }
}
