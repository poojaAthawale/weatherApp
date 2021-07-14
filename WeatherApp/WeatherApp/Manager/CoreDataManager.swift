//
//  CoreDataManager.swift
//  WeatherApp
//
//  Created by pooja  on 14/07/21.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager: NSObject {
    
    static let shared = CoreDataManager()
    
    private override init() {
        
    }
    
    func saveWeatherInfo(weatherInfo: WeatherViewModel)  {
        
        let fetchRequest = NSFetchRequest<WeatherInfo>(entityName: "WeatherInfo")
        
        let predicate = NSPredicate(format: "cityName = %@", argumentArray: [weatherInfo.cityName])
        
        fetchRequest.predicate = predicate
        
        do {
            let results = try DBManager.sharedInstance().managedObjectContext.fetch(fetchRequest)
            
            if let result = results.first {
                // Already exist update
                result.cityName = weatherInfo.cityName
                result.temprature = weatherInfo.temprature
                result.temprature_max = weatherInfo.maximumTemprature
                result.temprature_min = weatherInfo.minimumTemprature
                result.timestamp = weatherInfo.timestamp
            } else {
                // create new record
                let weatherInfoEntity = NSEntityDescription.insertNewObject(forEntityName: "WeatherInfo", into: DBManager.sharedInstance().managedObjectContext) as! WeatherInfo
                
                weatherInfoEntity.cityName = weatherInfo.cityName
                weatherInfoEntity.temprature = weatherInfo.temprature
                weatherInfoEntity.temprature_max = weatherInfo.maximumTemprature
                weatherInfoEntity.temprature_min = weatherInfo.minimumTemprature
                weatherInfoEntity.timestamp = weatherInfo.timestamp
                
                DBManager.sharedInstance().saveContext()
            }
        } catch {
            print("Error")
        }
        
    }
    
    func getRecentSearchResults() -> [WeatherViewModel] {
        
        var weatherInfoList: [WeatherViewModel] = [WeatherViewModel]()
        
        let fetchRequest = NSFetchRequest<WeatherInfo>(entityName: "WeatherInfo")
        
        do {
            let results = try DBManager.sharedInstance().managedObjectContext.fetch(fetchRequest)
            
            
            for result in results {
                
                if let timestamp = result.timestamp {
                    if Date().minutes(from: timestamp) > (10) {
                        self.deleteRecentWeatherInfo(weatherInfo: result)
                        continue
                    }
                }
                
                let weatherInfoModel = WeatherInfoModel(weatherInfo: result)
                weatherInfoList.append(WeatherViewModel(with: weatherInfoModel))
            }
            
        } catch {
            print("Not able to fetch search results")
        }
        
        return weatherInfoList
    }
    
    func deleteRecentWeatherInfo(weatherInfo: WeatherInfo) {
        DBManager.sharedInstance().managedObjectContext.delete(weatherInfo)
        DBManager.sharedInstance().saveContext()
    }
}
