//
//  HomeViewRouter.swift
//  WeatherAppVIPER
//
//  Created by ramchandra on 28/02/18.
//  Copyright © 2018 ramchandra. All rights reserved.
//

import UIKit

protocol HomeViewRouterinput {
    func showDetailScreenWithData(atIndex index: Int)
}

class HomeViewRouter: HomeViewRouterinput {
    weak var view: HomeViewController!

    func showDetailScreenWithData(atIndex index: Int) {
        if let detailVc = view.storyboard?.instantiateViewController(withIdentifier: "WeatherDetailViewController") as? WeatherDetailViewController {
            detailVc.presenter.saveData(view.arrWeatherItems[index], city: view.cityname)
            view.navigationController?.pushViewController(detailVc, animated: true)
        }
    }
}
