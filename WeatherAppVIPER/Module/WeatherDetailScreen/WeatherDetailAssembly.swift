//
//  WeatherDetailAssembly.swift
//  WeatherAppVIPER
//
//  Created by ramchandra on 28/02/18.
//  Copyright © 2018 ramchandra. All rights reserved.
//

import UIKit

class WeatherDetailAssembly {
    
    class func configure(_ vc: WeatherDetailViewController) {
        let presenter = WeatherDetailPresenter()
        let interactor = WeatherDetailInteractor()

        presenter.view = vc
        presenter.interactor = interactor
        interactor.presenter = presenter
        vc.presenter = presenter
    }
}
