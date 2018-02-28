//
//  HomeViewAssembly.swift
//  WeatherAppVIPER
//
//  Created by ramchandra on 28/02/18.
//  Copyright © 2018 ramchandra. All rights reserved.
//

import UIKit

class HomeViewAssembly {
    
    class func configure(_ viewController: HomeViewController) {
        let presenter = HomeViewPresenter()
        let interactor = HomeViewInteractor()
        let router = HomeViewRouter()

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.view = viewController
        viewController.presenter = presenter
    }
}
