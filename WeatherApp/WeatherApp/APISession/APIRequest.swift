//
//  APIRequest.swift
//  WeatherApp
//
//  Created by pooja  on 14/07/21.
//

import Foundation
import UIKit
import Alamofire


let APIREQUEST = ApiRequest.sharedInstance

class ApiRequest{
    
    static let sharedInstance:ApiRequest = {
        let instance = ApiRequest()
        return instance
    }()
    
    typealias webServicesResponse = (Any?)-> Void
    
    //----------------------------------------------------------------------------
    // @@@@@@@@@@@@@@@@@@@@@@@@@@@ MARK:- ApiRequest @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    //----------------------------------------------------------------------------
    
    func apiRequest(url:String,isLoadingNeeded: Bool = true,parameters: [String: Any],method : HTTPMethod,viewController : UIViewController,complition :  @escaping webServicesResponse)
    {
        Internet.isAvailable(completion: { (status, message) in
            if status{
                
                    Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseString { response in
                       complition(response.data)
                    }
                
            }else{
                let alert = UIAlertController(title: "failure", message: "Check Your Internet Connection..!!!", preferredStyle: .alert)
                viewController.present(alert, animated: true, completion: nil)
                
                // change to desired number of seconds (in this case 5 seconds)
                let when = DispatchTime.now() + 1
                DispatchQueue.main.asyncAfter(deadline: when){
                    // your code with delay
                    alert.dismiss(animated: true, completion: nil)
                }
            }
            
        })
        
    }

   
}

