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
        self.navController.pushViewController(vc, animated: true)
    }

    func popVС() {
        self.navController.popViewController(animated: true)
    }

    func set(vc: UIViewController) {
        self.navController.setViewControllers([vc], animated: true)
    }
}
