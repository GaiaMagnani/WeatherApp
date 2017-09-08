//
//  ServiceRequesterDay.swift
//  MeteoApp
//
//  Created by Gaia Magnani on 08/09/2017.
//  Copyright © 2017 Gaia Magnani. All rights reserved.
//

import Foundation


class ServiceRequesterDay: ServiceRequester {
    var days: [Day] = []
    
      init(city: String, numOfDays: Int) {
        super.init()
        
        params = ["q" : city, "cnt" : numOfDays, "appid" : APIKEY]
        self.method = "GET"
    }

    override func parse(data : Data) {
        
        do {
            if let d : Dict = try JSONSerialization.jsonObject(with: data, options: []) as?  Dict {
                
                    print(d)
                
                if let LIST = d["list"] as? [Dict] {
                    _ = parseList(LIST: LIST)
                } else {
                    self.lastError = 1
                }
            }
        } catch  {
            return
        }
    }
    
    
    
    /// parse json to checks error and take json data's
    func parseList(LIST: [Dict]){

        for (index, day) in LIST.enumerated() {
            if index%3 == 0 {
                let singleDay = Day()
                if let dayAndTime = day["dt_txt"] as? String {
                    if let date = dayAndTime.fromLocalTime() {
                        singleDay.longDay = date.withFullDay()
                    }
                    
                }
                if var dict = day["main"] as? Dict {
                    print(dict)
                    if let temp = dict["temp_max"] as? Double {
                        singleDay.max = temp.toCurrency()
                    }
                    if let temp_min = dict["temp_min"] as? Double {
                        singleDay.min = temp_min.toCurrency()
                    }
                }
                days.append(singleDay)
            }
            
        }

    }

}
