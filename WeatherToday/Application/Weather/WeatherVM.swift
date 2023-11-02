//
//  WeatherVM.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 26.11.2021.
//

import Foundation
import MLBasicKit
import Combine

enum WeatherViewState: ViewState {
    case close (String)
}

class WeatherVM: BaseVM {
    @Published var cityName: String = "Barcelona"
    @Published var weatherType: String? = nil
    @Published var currentCityTemp: Double? = nil
    @Published var currentDate: Int? = nil
    @Published var weather: WeatherResponse? = nil    
    var currentLocation: (latitude:Double, longitude:Double) = (41.3874, 2.1686)

    func closeButtonPressed() {
        state.send(WeatherViewState.close("Closed"))
    }
}

extension WeatherVM {
    func fetchCurrentWeather() {
        // Get current weather
        WeatherApi().fetchWeather(latitude: currentLocation.latitude,
                                  longitude: currentLocation.longitude,
                                   succeed: { [weak self] (weather) in
            guard let self = self else { return }

            self.weather = weather
            self.currentDate = weather.weather.currentDate
            self.weatherType = weather.weather.weatherType
            self.currentCityTemp = weather.weather.currentCityTemp

        }, failed: { (error) in
            print(error)
        })
    }
}
