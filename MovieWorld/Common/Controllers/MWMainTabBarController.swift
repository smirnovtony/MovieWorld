//
//  MWMainTabBarController.swift
//  MovieWorld
//
//  Created by Анастасия Корнеева on 5.04.21.
//

import UIKit

class MWMainTabBarController: UITabBarController {

    private lazy var mainTabBarItem: UITabBarItem = {
        let view = UITabBarItem(title: "Main",
                                image: UIImage(systemName: "house"),
                                selectedImage: UIImage(systemName: "house.fill"))

        return view
    }()

    private lazy var moviesTabBarItem = UITabBarItem(title: "Movies",
                                                       image: UIImage(systemName: "film"),
                                                       selectedImage: UIImage(systemName: "film.fill"))


    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpTabBar()
        self.setupTabBarAppearance()
    }


    private func setUpTabBar() {
        let mainController = MWMainViewController()
        mainController.tabBarItem = self.mainTabBarItem

        let moviesController = MWMoviesController()
        moviesController.tabBarItem = self.moviesTabBarItem

        let controllers = [mainController, moviesController]
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0) }
    }

    private func setupTabBarAppearance() {
        self.tabBar.tintColor = UIColor(named: "accentColor")
        self.tabBar.unselectedItemTintColor = UIColor(named: "mainTextColor")
        self.tabBar.backgroundColor = .white
    }
}

