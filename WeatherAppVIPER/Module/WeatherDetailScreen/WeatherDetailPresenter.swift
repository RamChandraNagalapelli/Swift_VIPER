//
//  WeatherDetailPresenter.swift
//  WeatherAppVIPER
//
//  Created by ramchandra on 28/02/18.
//  Copyright © 2018 ramchandra. All rights reserved.
//

import Foundation

protocol WeatherDetailPresenterInput: WeatherDetailViewOutput, WeatherDetailInteractorOutput { }

class WeatherDetailPresenter: WeatherDetailPresenterInput {

    weak var view: WeatherDetailViewInput!
    var interactor: WeatherDetailInteractorInput!

    func saveData(_ data: WeatherItem, city: String) {
        interactor.saveData(data, city: city)
    }

    func getWeatherData() {
        view.loadImage(withUrl: interactor.weatherIconUrl)
        view.setTitle(interactor.cityName)
        view.setWeatherDescription(interactor.weatherDescription)
        view.setTemp(interactor.tempString)
        view.setMinMaxtemp(min: interactor.mintempString, max: interactor.maxtempString)
    }
}
