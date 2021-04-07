//
//  MWNetwork.swift
//  MovieWorld
//
//  Created by Антон Смирнов on 5.04.21.
//

import Foundation

class MWNetwork {
    static let sh = MWNetwork()

    private let baseUrl: String = "https://api.themoviedb.org/3/"
    private let apiKey: String = "79d5894567be5b76ab7434fc12879584"

    // alamofire

    private lazy var parameters: [String: String] = [ // для авторизации
        "api_key": self.apiKey
    ]

    private let session = URLSession(configuration: .default)

    private init() {}

    // MARK: - UrlSession

    func request<T: Decodable>(urlPath: String, // <T: Decodable> - дженерик <ИМЯ: ТИП>
                 parameters: [String: String]? = nil,
                 okHandler: @escaping (T) -> Void,
                 errorHandler: @escaping () -> Void) {
    var urlParameters = self.parameters

        parameters?.forEach {
            urlParameters[$0.key] = $0.value
        }

        guard let url = URL(urlString: self.baseUrl,
                            path: urlPath,
                            params: urlParameters) else {
            return
        }
        let request = URLRequest(url: url)

        let dataTask = self.session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                Swift.debugPrint(error.localizedDescription)
                DispatchQueue.main.async {
                    errorHandler()
                }
            } else if let data = data,
                 let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200...300:
                    do {
                        let model = try JSONDecoder().decode(T.self, from: data)
                        DispatchQueue.main.async {
                            okHandler(model)
                        }
                    } catch let error {
                        Swift.debugPrint(error.localizedDescription)
                        DispatchQueue.main.async { // для отрисофки интерфейса пользователя и только для этого.
                            errorHandler()
                        }
                    }
                case 401, 404:
                    Swift.debugPrint(String(decoding: data, as: UTF8.self))
                    DispatchQueue.main.async {
                        errorHandler()
                    }
                default:
                    DispatchQueue.main.async {
                        errorHandler()
                    }
                }
            }
        }
        dataTask.resume() // обязательно
    }
}
