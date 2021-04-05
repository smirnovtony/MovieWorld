//
//  MWMoviesController.swift
//  MovieWorld
//
//  Created by Анастасия Корнеева on 1.04.21.
//

import UIKit

class MWMoviesController: MWViewController {

    private let cellsPerRow: CGFloat = 3
    private let contentInset = UIEdgeInsets(all: 5)
    private let spaceBetweenCells: CGFloat = 20

    private let imageUrls: [String] = [
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596449750_6002",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596449786_10224",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596449816_4994",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596449837_8094",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596449855_9294",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596449880_8311",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596449900_4583",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596449919_5720",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596449947_12069",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596449967_14631",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596449989_39059",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596450014_14191",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596450043_41074",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596450062_11754",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596450097_12993",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596450115_99828",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596450133_2710",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596450154_18007",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596450174_26808",
        "https://s3-eu-west-1.amazonaws.com/uploads.playbaamboozle.com/uploads/images/54999/1596450200_18730"
    ]

    private lazy var models: [MWMovieModel] = self.imageUrls.map { MWMovieModel(imageUrl: $0) }

    // MARK: - gui variables

    private lazy var collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = .zero

        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: self.collectionLayout)
        view.backgroundColor = .white
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.register(MWMovieCell.self,
                      forCellWithReuseIdentifier: MWMovieCell.reuseIdentifier)

    return view
    }()

// MARK:

    override func initController() {
        super.initController()

        self.controllerTitle = "Movies"

        self.setContentScrolling(isEnabled: false)
        self.mainView.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension MWMoviesController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.models.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MWMovieCell.reuseIdentifier, for: indexPath)
        if let cell = cell as? MWMovieCell {
            cell.set(title: "Movie # \(indexPath.row + 1)", date: Date())
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Swift.debugPrint(indexPath.row)
    }

}

extension MWMoviesController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 115, height: 115)
        let availableWidth = collectionView.bounds.width - self.contentInset.left - self.contentInset.right
        let width = ((availableWidth - self.spaceBetweenCells * (self.cellsPerRow - 1)) / self.cellsPerRow)
        return CGSize(width: width, height: width * 2)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(all: 5)
    }

}
