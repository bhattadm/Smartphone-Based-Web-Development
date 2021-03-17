//
//  Model5DayForecast.swift
//  WorldWeather
//
//  Created by Megha Bhattad on 3/15/21.
//

import Foundation

class Model5DayForecast{
    
    var date  = ""
    var minTemp = ""
    var maxTemp = ""
    var dayweatherIcon : Int = 0
    var nightweatherIcon : Int = 0
    
    init(_ date: String,_ minTemp: String,_ maxTemp: String,_ dayweatherIcon : Int,_ nightweatherIcon : Int)
    {
        self.date = date
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.dayweatherIcon = dayweatherIcon
        self.nightweatherIcon = nightweatherIcon
    }
}
