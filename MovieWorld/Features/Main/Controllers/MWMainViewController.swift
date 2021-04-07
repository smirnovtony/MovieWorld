//
//  MWMainViewController.swift
//  MovieWorld
//
//  Created by Анастасия Корнеева on 5.04.21.
//

import UIKit

class MWMainViewController: MWViewController {

    enum MovieCategory: String {
        case popular = "Popular"
        case upcoming = "Upcoming"
        case topRated = "Top rated"
    }

    private var movies: [MovieCategory: [MWMovie]] = [:]

    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = UIColor(named: "accentColor")
        control.addTarget(self, action: #selector(refreshPulled),
                          for: .valueChanged)

        return control
    }()

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.rowHeight = 305
        view.tableFooterView = UIView()
        view.separatorStyle = .none
        view.refreshControl = self.refreshControl // штука крутелка загрузки 

        view.register(MWRowCell.self, forCellReuseIdentifier: MWRowCell.reuseIdentifier)

        return view
    }()

    override func initController() {
        super.initController()

        self.controllerTitle = "Main"

        self.view.addSubview(self.tableView)

        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        self.sendPopularRequest()
        self.sendUpcomingRequest()
        self.sendTopRatedRequest()
    }

    @objc private func refreshPulled() {
        self.sendPopularRequest()
        self.sendUpcomingRequest()
        self.sendTopRatedRequest()
        // refresh logic
    }

    private func sendUpcomingRequest() {
        MWNetwork.sh.request(urlPath: MWUrlPaths.upcomingMovies) { [weak self] (upcomingMuviesModel: MWUpcomingResponseModel) in guard let self = self else { return } // принудительно прекращаем крутить штуку загрузки
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            self.movies[.upcoming] = upcomingMuviesModel.results
         // parse movie to table
            self.tableView.reloadData()

            upcomingMuviesModel.results.forEach {
                        Swift.debugPrint("id: \($0.id)")
                        Swift.debugPrint($0.title)
                        Swift.debugPrint($0.overview ?? "No overview")
                    }
        } errorHandler: {
            if self.refreshControl.isRefreshing { // принудительно прекращаем крутить штуку загрузки
                self.refreshControl.endRefreshing()
            }
            print("errorHandler")
            // доделать алерт
        }
    }

    private func sendPopularRequest() {
        MWNetwork.sh.request(urlPath: MWUrlPaths.popularMovies) { [weak self] (popularMoviesModel: MWPopularMoviesResponse) in
            guard let self = self else { return } // принудительно прекращаем крутить штуку загрузки
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            self.movies[.popular] = popularMoviesModel.results
            self.tableView.reloadData()

            popularMoviesModel.results.forEach {
                        Swift.debugPrint("id: \($0.id)")
                        Swift.debugPrint($0.title)
                        Swift.debugPrint($0.overview ?? "No overview")
                    }
        } errorHandler: {
            if self.refreshControl.isRefreshing { // принудительно прекращаем крутить штуку загрузки
                self.refreshControl.endRefreshing()
            }
            print("errorHandler")
            // доделать алерт
        }
    }

    private func sendTopRatedRequest() {
        MWNetwork.sh.request(urlPath: MWUrlPaths.topRatedMovies) { [weak self] (topRatedMoviesModel: MWTopRatedResponse) in
            guard let self = self else { return } // принудительно прекращаем крутить штуку загрузки
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            self.movies[.topRated] = topRatedMoviesModel.results
            self.tableView.reloadData()

            topRatedMoviesModel.results.forEach {
                Swift.debugPrint("id: \($0.id)")
                Swift.debugPrint($0.title)
                Swift.debugPrint($0.overview ?? "No overview")
            }
        } errorHandler: {
            if self.refreshControl.isRefreshing { // принудительно прекращаем крутить штуку загрузки
                self.refreshControl.endRefreshing()
            }
            print("errorHandler")
            // доделать алерт
        }
    }
}



extension MWMainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MWRowCell.reuseIdentifier, for: indexPath) as? MWRowCell ?? MWRowCell()
        let array = Array(self.movies)[indexPath.section]
        cell.movies = array.value
        cell.set(sectionName: array.key.rawValue)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Swift.debugPrint("user selected: \(indexPath)")
    }
}

