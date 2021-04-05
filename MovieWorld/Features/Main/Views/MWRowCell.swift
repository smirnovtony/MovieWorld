//
//  MWRowCell.swift
//  MovieWorld
//
//  Created by Анастасия Корнеева on 5.04.21.
//

import UIKit

class MWRowCell: UITableViewCell {

    static let reuseIdentifier: String = "MWRowCell"

    var movies: [MWMovie] = [] {
        didSet {
            self.collectionView.reloadData()
            self.setNeedsUpdateConstraints()
        }
    }

    private let edgeInsets = UIEdgeInsets(top: 24, left: 16, bottom: 12, right: 7)

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(named: "mainTextColor")

        return label
    }()

    private lazy var allButton: UIButton = {
        let button = UIButton()
        button.setTitle("All ->", for: UIControl.State())
        button.backgroundColor = UIColor(named: "accentColor")
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 12, bottom: 2, right: 12)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true

        return button
    }()

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.createFlowLayout())
        view.backgroundColor = UIColor.clear
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never

        view.delegate = self
        view.dataSource = self

        view.register(MWMainMovieCell.self, forCellWithReuseIdentifier: MWMainMovieCell.reuseIdentifier)

        return view
    }()

    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 130, height: 237)
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)

        return layout
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.allButton)
        self.contentView.addSubview(self.collectionView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        self.titleLabel.snp.updateConstraints { (make) in
            make.top.left.equalToSuperview().inset(self.edgeInsets)
        }

        self.allButton.snp.updateConstraints { (make) in
            make.top.right.equalToSuperview().inset(self.edgeInsets)
            make.left.equalTo(self.titleLabel.snp.right)
        }

        self.collectionView.snp.updateConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(12)
            make.left.right.bottom.equalToSuperview()
        }

        super.updateConstraints()
    }

    func set(sectionName: String) {
        self.titleLabel.text = sectionName
    }
}

extension MWRowCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MWMainMovieCell.reuseIdentifier, for: indexPath) as? MWMainMovieCell ?? MWMainMovieCell()
        cell.set(movie: self.movies[indexPath.row])

        return cell
    }
}
