//
//  WeatherDetailViewController.swift
//  WeatherAppVIPER
//
//  Created by ramchandra on 28/02/18.
//  Copyright © 2018 ramchandra. All rights reserved.
//

import UIKit

protocol WeatherDetailViewInput: class {
    func loadImage(withUrl url: URL)
    func setTitle(_ title: String)
    func setWeatherDescription(_ des: String)
    func setTemp(_ temp: String)
    func setMinMaxtemp(min: String, max: String)
}

protocol WeatherDetailViewOutput {
    func saveData(_ data: WeatherItem, city: String)
    func getWeatherData()
}

class WeatherDetailViewController: UIViewController, WeatherDetailViewInput {

    var presenter: WeatherDetailViewOutput!

    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var imageViewWeatherIcon: UIImageView!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var labelMintemp: UILabel!
    @IBOutlet weak var labelMaxTemp: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        WeatherDetailAssembly.configure(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getWeatherData()
    }

    func loadImage(withUrl url: URL) {
        imageViewWeatherIcon.setImage(fromUrl: url)
    }

    func setTitle(_ title: String) {
        navigationItem.title = title
    }

    func setWeatherDescription(_ des: String) {
        labelDescription.text = des
    }

    func setTemp(_ temp: String) {
        labelTemp.text = temp
    }

    func setMinMaxtemp(min: String, max: String) {
        labelMintemp.text = min
        labelMaxTemp.text = max
    }
}
