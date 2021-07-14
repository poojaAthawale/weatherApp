//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by pooja  on 14/07/21.
//

import Foundation
import SwiftyJSON
import Alamofire

class WeatherViewModel {

    private var weatherInfoModel: WeatherInfoModel
    
    // values for view
    var cityName: String {
        return self.weatherInfoModel.cityName
    }
    
    var temprature: Double {
        return self.weatherInfoModel.temprature
    }
    
    var minimumTemprature: Double {
        return self.weatherInfoModel.minTemprature
    }

    var maximumTemprature: Double {
        return self.weatherInfoModel.maxTemprature
    }
    
    var timestamp: Date? {
        return self.weatherInfoModel.timeStamp
    }
    
    //other values
    var tempratureInDegreeCel: String {
        return self.temprature.getTempInDegreeCelecious()
    }
    
    var tempratureMinInDegreeCel: String {
        return self.minimumTemprature.getTempInDegreeCelecious()
    }
    
    var tempratureMaxInDegreeCel: String {
        return self.maximumTemprature.getTempInDegreeCelecious()
    }
    
    // Initalizer
    required init(with model: WeatherInfoModel = WeatherInfoModel()) {
        self.weatherInfoModel = model
    }
    
    // MARK: - API Calls
    func getWeatherInfo(cityName: String,viewController: UIViewController,
    success: @escaping ((_ submittedImage: WeatherViewModel) -> Void),
    failure: @escaping((_ error: ApiError) -> Void)){
        let url = "https://api.openweathermap.org/data/2.5/weather?q=" + cityName + "&units=metric&appid=094aa776d64c50d5b9e9043edd4ffd00"
        
        APIREQUEST.apiRequest(url: url, parameters:[:], method: .post, viewController: viewController) {  (json)  in
            if let jsonTemp = json{
                let json = JSON(jsonTemp)
                
                if let message = json["message"].string {
                    let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                    viewController.present(alert, animated: true, completion: nil)
                    failure(.dataNotFound)
                } else {
                
                let weatherInfo = WeatherViewModel(with: WeatherInfoModel(json: json))
                success(weatherInfo)
                CoreDataManager.shared.saveWeatherInfo(weatherInfo: weatherInfo)
                }
                
            }else{
                failure(.dataNotFound)
            }
    
        }
        
    }
    
}

