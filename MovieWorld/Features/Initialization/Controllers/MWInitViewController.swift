//
//  MWInitViewController.swift
//  MovieWorld
//
//  Created by Анастасия Корнеева on 1.04.21.
//

import UIKit

class MWInitViewController: MWViewController {

    private lazy var indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = UIColor(named: "accentColor")

        return view
    }()

    override func initController() {
        super.initController()

        self.setContentScrolling(isEnabled: false)

        self.mainView.addSubview(self.indicator)

        self.indicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: false)

        self.indicator.startAnimating()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.indicator.stopAnimating()

            MWI.sh.setTabBar()
        }
    }
}
