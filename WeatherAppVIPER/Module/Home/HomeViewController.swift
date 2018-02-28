//
//  HomeViewController.swift
//  WeatherAppVIPER
//
//  Created by ramchandra on 22/02/18.
//  Copyright © 2018 ramchandra. All rights reserved.
//

import UIKit

protocol HomeViewControllerInput: class {
    func showLoader(_ show: Bool)
    func showAlert(title: String, message: String)
    func dispalyWeatherData(weatherItems: [WeatherItem], cityname: String)
}

protocol HomeViewControllerOutput {
    func getWeatherDataFor(latitude: Double, longitude: Double)
    func dateString(fromDate date: Date) -> String
    func tempString(temp: Double, roundedUpTo place: Int) -> String
    func showDetailScreenWithData(atIndex index: Int)
}

class HomeViewController: UIViewController, HomeViewControllerInput {

    let latitude = 23.0170775
    let longitude = 72.5263869
    var arrWeatherItems: [WeatherItem] = []
    var cityname: String = ""

    var presenter: HomeViewControllerOutput!

    @IBOutlet weak var tableViewWeather: UITableView!
    @IBOutlet weak var dayView: DayView!

    override func awakeFromNib() {
        super.awakeFromNib()
        HomeViewAssembly.configure(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewWeather.dataSource = self
        tableViewWeather.delegate = self
        tableViewWeather.tableFooterView = UIView()
        tableViewWeather.rowHeight = UITableViewAutomaticDimension
        tableViewWeather.estimatedRowHeight = 60
        getWeatherData()
    }

    func getWeatherData() {
        presenter.getWeatherDataFor(latitude: latitude, longitude: longitude)
    }

    func showLoader(_ show: Bool) {
        if show {
            showWaitingView()
        } else {
            hideWaitingView()
        }
    }

    func showAlert(title: String, message: String) {
        showAlert(title: title, message: message, buttons: ["Ok"], actions: nil)
    }

    func dispalyWeatherData(weatherItems: [WeatherItem], cityname: String) {
        arrWeatherItems = weatherItems
        self.cityname = cityname
        reloadDayView()
        tableViewWeather.reloadData()
    }

    func reloadDayView() {
        dayView.labelCity.text = cityname
        dayView.labelTemp.text = presenter.tempString(temp: arrWeatherItems.first?.temp ?? 0, roundedUpTo: 2)
        dayView.labelDescription.text = arrWeatherItems.first?.descripton ?? ""
        if let imageUrl = arrWeatherItems.first?.imageUrl {
            dayView.imageWeather.setImage(fromUrl: imageUrl)
        }
    }

    func showWaitingView() {
        let alert = UIAlertController(title: nil, message: "Loading....", preferredStyle: .alert)

        alert.view.tintColor = UIColor.black
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView

        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = .gray
        loadingIndicator.startAnimating()

        alert.view.addSubview(loadingIndicator)
        self.navigationController?.present(alert, animated: true, completion: nil)
    }

    func hideWaitingView() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrWeatherItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as? WeatherCell else {
            return UITableViewCell()
        }
        let weatheritem = arrWeatherItems[indexPath.row]
        cell.labelTime.text = presenter.dateString(fromDate: weatheritem.date)
        cell.labelMaxTemp.text = weatheritem.maxTemp.roundedString + "°"
        cell.labelMinTemp.text = weatheritem.minTemp.roundedString + "°"
        cell.imageWeather.setImage(fromUrl: weatheritem.imageUrl)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.showDetailScreenWithData(atIndex: indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

