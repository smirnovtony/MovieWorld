//
//  MWInterface.swift
//  MovieWorld
//
//  Created by Анастасия Корнеева on 1.04.21.
//

import UIKit

typealias MWI = MWInterface

class MWInterface {

    static let sh = MWInterface()

    weak var window: UIWindow?

    private var currentNavController: UINavigationController {
        (self.tabBarController.selectedViewController as? UINavigationController) ?? self.navController
    }

    private lazy var tabBarController = MWMainTabBarController()

    private lazy var navController = UINavigationController(rootViewController: MWInitViewController())

    private init() {}

    func setup(window: UIWindow) {

        self.window = window

        self.setUpNavigationBarStyle()

        window.rootViewController = self.navController
        window.makeKeyAndVisible()
    }

    private func setUpNavigationBarStyle() {
        let standartNavBar = UINavigationBar.appearance()
        standartNavBar.backgroundColor = .white
        standartNavBar.tintColor = UIColor(named: "accentColor")
        standartNavBar.prefersLargeTitles = true

        let newNavBar = UINavigationBarAppearance()
        newNavBar.configureWithDefaultBackground()

        standartNavBar.scrollEdgeAppearance = newNavBar
        standartNavBar.standardAppearance = newNavBar
    }

    func push(vc: UIViewController) {
        self.currentNavController.pushViewController(vc, animated: true)
    }

    func popVС() {
        self.currentNavController.popViewController(animated: true)
    }

    func set(vc: UIViewController) {
        self.currentNavController.setViewControllers([vc], animated: true)
    }

    func setTabBar() {
        guard let window = self.window else { return }

        window.rootViewController = self.tabBarController

        UIView.transition(with: window,
                          duration: 0.5,
                          options: .transitionFlipFromLeft,
                          animations: nil)
    }
}
