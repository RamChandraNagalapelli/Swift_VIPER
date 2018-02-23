//
//  HomeViewInteractor.swift
//  WeatherAppVIPER
//
//  Created by ramchandra on 22/02/18.
//  Copyright © 2018 ramchandra. All rights reserved.
//

import Foundation

protocol HomeViewInteractorInput {
    func getWeatherDataFor(latitude: Double, longitude: Double)
    var dateFormatter: DateFormatter { get }
}

protocol HomeViewInteractorOutput {
    func fetchedWeatherData(weatherItems: [WeatherItem], cityName: String)
    func serviceError(message: String)
}

class HomeViewInteractor: HomeViewInteractorInput {
    
    let baseUrl = "http://api.openweathermap.org/data/2.5/forecast"
    let appId = "1fa136797a15633a60b2ec78f34a1179"
    let sww = "Oops... Something went wrong!\nPlease try again."

    var presenter: HomeViewInteractorOutput!
    fileprivate lazy var dtFormatter = DateFormatter()

    init() {
        dtFormatter.amSymbol = "am"
        dtFormatter.pmSymbol = "pm"
        dtFormatter.dateFormat = "EEEE, hh:mma"
    }

    var dateFormatter: DateFormatter {
        return dtFormatter
    }

    func getWeatherDataFor(latitude: Double, longitude: Double) {
        let urlString = baseUrl + "?lat=\(latitude)&lon=\(longitude)" + "&appid=\(appId)" + "&units=metric"
        NetworkManager.requestForURL(reqUrl: URL(string: urlString)!, method: .get, parameters: nil, success: { response in
            if let code = response.value(forKey: "cod") as? String, code == "200" {
                if let arrData = response.value(forKey: "list") as? [NSDictionary] {
                    self.presenter.fetchedWeatherData(weatherItems: arrData.map { WeatherItem($0) }, cityName: response.value(forKeyPath: "city.name") as? String ?? "NA")
                } else {
                    self.presenter.serviceError(message: response.value(forKey: "message") as? String ?? self.sww)
                }
            } else {
                self.presenter.serviceError(message: response.value(forKey: "message") as? String ?? self.sww)
            }
        }, failure: { error in
            self.presenter.serviceError(message: error?.localizedDescription ?? self.sww)
        })
    }
}
