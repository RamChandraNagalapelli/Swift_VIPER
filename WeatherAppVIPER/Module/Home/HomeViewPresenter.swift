//
//  HomeViewPresenter.swift
//  WeatherAppVIPER
//
//  Created by ramchandra on 22/02/18.
//  Copyright © 2018 ramchandra. All rights reserved.
//

import UIKit

protocol HomeViewPresenterInput: HomeViewControllerOutput, HomeViewInteractorOutput {}

class HomeViewPresenter: HomeViewPresenterInput {

    weak var view: HomeViewControllerInput!
    var interactor: HomeViewInteractorInput!

    func getWeatherDataFor(latitude: Double, longitude: Double) {
        view.showLoader(true)
        interactor.getWeatherDataFor(latitude: latitude, longitude: longitude)
    }

    func fetchedWeatherData(weatherItems: [WeatherItem], cityName: String) {
        DispatchQueue.main.async {
            self.view.showLoader(false)
            self.view.dispalyWeatherData(weatherItems: weatherItems, cityname: cityName)
        }
    }

    func serviceError(message: String) {
        view.showAlert(title: "Error", message: message)
    }

    func dateString(fromDate date: Date) -> String {
        return interactor.dateFormatter.string(from: date)
    }

    func tempString(temp: Double, roundedUpTo place: Int) -> String {
        return temp.rounded(toPlaces: 2).string + "° C"
    }

}
