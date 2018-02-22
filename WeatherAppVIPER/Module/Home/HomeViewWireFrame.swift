//
//  HomeViewWireFrame.swift
//  WeatherAppVIPER
//
//  Created by ramchandra on 22/02/18.
//  Copyright © 2018 ramchandra. All rights reserved.
//

import UIKit

class HomeViewWireFrame {

    class func configure(_ viewController: HomeViewController) {
        let presenter = HomeViewPresenter()
        let interactor = HomeViewInteractor()

        presenter.view = viewController
        presenter.interactor = interactor
        interactor.presenter = presenter
        viewController.presenter = presenter
    }
}
