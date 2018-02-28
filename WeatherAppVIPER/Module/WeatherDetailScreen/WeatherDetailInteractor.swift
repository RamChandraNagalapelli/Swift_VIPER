//
//  WeatherDetailInteractor.swift
//  WeatherAppVIPER
//
//  Created by ramchandra on 28/02/18.
//  Copyright © 2018 ramchandra. All rights reserved.
//

import Foundation

protocol WeatherDetailInteractorInput {
    func saveData(_ data: WeatherItem, city: String)
    var weatherIconUrl: URL { get }
    var cityName: String { get }
    var tempString: String { get }
    var mintempString: String { get }
    var maxtempString: String { get }
    var weatherDescription: String { get }
}

protocol WeatherDetailInteractorOutput: class {
}

class WeatherDetailInteractor: WeatherDetailInteractorInput {
    
    weak var presenter: WeatherDetailInteractorOutput!
    fileprivate var weatherData: WeatherItem?
    var cityName: String = ""
    fileprivate lazy var dtFormatter = DateFormatter()

    init() {
        dtFormatter.amSymbol = "am"
        dtFormatter.pmSymbol = "pm"
        dtFormatter.dateFormat = "EEEE, hh:mma"
    }

    var weatherIconUrl: URL {
        return (weatherData?.imageUrl ?? URL(string: ""))!
    }

    var tempString: String {
        return tempString(temp: weatherData?.temp ?? 0 , roundedUpTo: 2)
    }

    var mintempString: String {
        return tempString(temp: weatherData?.minTemp ?? 0 , roundedUpTo: 0)
    }

    var maxtempString: String {
        return tempString(temp: weatherData?.maxTemp ?? 0 , roundedUpTo: 0)
    }

    var weatherDescription: String {
        return weatherData?.descripton ?? ""
    }

    func saveData(_ data: WeatherItem, city: String) {
        self.weatherData = data
        self.cityName = city
    }

    // MARK: - Healper Methods
    fileprivate func tempString(temp: Double, roundedUpTo place: Int) -> String {
        return temp.rounded(toPlaces: 2).string + "° C"
    }
}
