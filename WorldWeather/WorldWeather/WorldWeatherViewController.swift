//
//  ViewController.swift
//  WorldWeather
//
//  Created by Ashish Ashish on 08/03/21.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftSpinner
import SwiftyJSON
import PromiseKit

/*
 Localization Steps:
 1. Click on the Project in the left top bar
 2. Select the project from the Project in the main screen
 3. In the Localizations section Click on + button to add your localized language
 4. Create a local folder and call it Localizable
 5. Add a new Strings file and call it Localizable too
 6. Add a key value pair in the file like following "hello_world" = "Hello World"; // remember to terminate string by semi colon
 7. Click on the Localizable.string file and in the right menu (identity inspector) you will see a Localization section
 8. Click on the Localize button in the Localization section
 9. In the Pop up click on Localize
 10. In the identity inspector check for all the languages you want to localize
 11. Create a file called Utilities
 12. Add a Swift file called LocalizationUtil.swift
 13. Add a variable for the string you want to localize and localize it with the Key added in the strings file as follows
 14. var strHelloWorld = NSLocalizedString("hello_world", comment: "")
 15. Replace Corresponding text in the language files with localized text
 16. Add a function which will initialize the text for all the UI Elements
 17. Call the initialize text from the viewDidLoad()
 
 */

class WorldWeatherViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
   
    

    @IBOutlet weak var lblCity: UILabel!
    
    @IBOutlet weak var lblCondition: UILabel!
    
    @IBOutlet weak var lblTemperature: UILabel!
    
    @IBOutlet weak var lblHighLow: UILabel!
    
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var condImage: UIImageView!
    
    @IBOutlet weak var lowImage: UIImageView!
    @IBOutlet weak var highImage: UIImageView!
    
    let locationManager = CLLocationManager()
    var imageArray:[String] = ["0","1","2","3","4","5","6","7","8","9","10",
                               "11","12","13","14","15","16","17","18","19","20",
                                "21","22","23","24","25","26","27","28","29","30",
                                "31","32","33","34","35","36","37","38","39","40",
                                "41","42","43","44"]
    // We need to have a class of View Model
    let viewModel = WorldWeatherViewModel()
    
    var model5DayForecastArr:[Model5DayForecast]=[Model5DayForecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        initializeText()
//        tblView.delegate = self
//        tblView.dataSource = self
    
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
    }
    func getWeekDay(_dateString :String)->String{
        print(_dateString)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:_dateString)!
        let format1 = "EEEE"
        dateFormatter.dateFormat = format1
        let formatDate1 = dateFormatter.string(from: date)
        print("date: \(formatDate1)")
        return formatDate1
    }
    //megha
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return model5DayForecastArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        print(model5DayForecastArr.count)
        let weekday = getWeekDay(_dateString: model5DayForecastArr[indexPath.row].date)
        cell.lblDay.text = weekday
//        let isoDate : String = (model5DayForecastArr[indexPath.row].date)
//        type(of: model5DayForecastArr[indexPath.row].date)
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        let date = dateFormatter.date(from:isoDate)!
//        let format1 = "EEEE"
//        dateFormatter.dateFormat = format1
//        let formatDate1 = dateFormatter.string(from: date)
//        print("date: \(formatDate1)")
        
        
        
//        let dateFormatter = DateFormatter()
////        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//       dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//
//        guard let date = dateFormatter.date(from: model5DayForecastArr[indexPath.row].date) else {  fatalError() }
//        dateFormatter.dateFormat = "EEEE"
//        let stringDate: String = dateFormatter.string(from: date)
//        print(stringDate)
        //my label
        
        
        
        
        
//        cell.lblDay.text = "\(model5DayForecastArr[indexPath.row].date)"
        cell.lblLowTemp.text = "\(model5DayForecastArr[indexPath.row].minTemp)° F"
        cell.lblHighTemp.text = "\(model5DayForecastArr[indexPath.row].maxTemp)° F"
        cell.lblLowTempImg.image = UIImage(named: self.imageArray[model5DayForecastArr[indexPath.row].dayweatherIcon])
        cell.lblHighTempImg.image = UIImage(named: self.imageArray[model5DayForecastArr[indexPath.row].nightweatherIcon])


//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        

//            cell.textLabel?.text = "\(model5DayForecastArr[indexPath.row].date), \(model5DayForecastArr[indexPath.row].minTemp)° F,\(model5DayForecastArr[indexPath.row].maxTemp)° F"
//        cell.imageView?.image = UIImage(named: self.imageArray[model5DayForecastArr[indexPath.row].dayweatherIcon])
//        cell.imageView?.image = UIImage(named: self.imageArray[model5DayForecastArr[indexPath.row].nightweatherIcon])

        
        
        return cell;
    }
  
    //megha
    
    func initializeText(){
        self.title = strHelloWorld
        lblCity.text = strCity
        lblCondition.text = strCondition
        lblTemperature.text = strTemperature
        lblHighLow.text = strHighLow
    }
    
    //MARK: Location Manager functions
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let currLocation = locations.last{
            
            let lat = currLocation.coordinate.latitude
            let lng = currLocation.coordinate.longitude
            
            print(lat)
            print(lng)
            updateWeatherData(lat, lng)
        }
    }
    
    
    //MARK: Update the weather from ViewModel
    
    func updateWeatherData(_ lat : CLLocationDegrees, _ lng : CLLocationDegrees){
        
        let cityDataURL = getLocationURL(lat, lng)
        
        viewModel.getCityData(cityDataURL).done { city in
            // Update City Name
            self.lblCity.text = city.cityName
            
            let key = city.cityKey
            
            let currentConditionURL = getCurrentConditionURL(key)
            let oneDayForecastURL = getOneDayURL(key)
            let fiveDayForecastURL = getfiveDayURL(key)  // megha
            
            
            self.viewModel.getCurrentConditions(currentConditionURL).done { currCondition in
                self.lblCondition.text = currCondition.weatherText
                self.lblTemperature.text =  "\(currCondition.imperialTemp)°"
                self.condImage.image = UIImage(named: self.imageArray[currCondition.weatherIcon])
            }.catch { error in
                print("Error in getting current conditions \(error.localizedDescription)")
            }
            
            self.viewModel.getOneDayConditions(oneDayForecastURL).done { oneDay in
                self.lblHighLow.text = "H: \(oneDay.dayTemp)° L: \(oneDay.nightTemp)°"
                self.highImage.image = UIImage(named: self.imageArray[oneDay.dayIcon])
                self.lowImage.image = UIImage(named: self.imageArray[oneDay.nightIcon])
                
            }.catch { error in
                print("Error in getting one day forecast conditions \(error.localizedDescription)")
            }
            
            //megha
            self.viewModel.getFiveDayConditions(fiveDayForecastURL).done { fiveDayForecast in
                self.model5DayForecastArr = fiveDayForecast
//                for(forecast in model5DayForecastArr) {
//                    print(forecast.minTemp)
//                }
               self.tblView.reloadData()
            }.catch { error in
                print("Error in getting one day forecast conditions \(error.localizedDescription)")
            }
            //megha
            
        }
        .catch { error in
            print("Error in getting City Data \(error.localizedDescription)")
        }
    }
}

