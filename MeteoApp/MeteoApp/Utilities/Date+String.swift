//
//  Date+String.swift
//  MeteoApp
//
//  Created by Gaia Magnani on 08/09/2017.
//  Copyright © 2017 Gaia Magnani. All rights reserved.
//

import Foundation
private var localDateFormatter : DateFormatter?
private var fullDayFormatFormatter : DateFormatter?

extension Date {
    func withFullDay() -> String {
        lazyBuildFullDayFormat()
        if let resultString = fullDayFormatFormatter?.string(from: self){
            return resultString
        }
        return "??"
    }
}

extension String {
    func fromLocalTime()->Date? {
        
        if localDateFormatter == nil{
            
            localDateFormatter = DateFormatter()
            
            let locale = Locale(identifier: "en_US_POSIX")
            //let timeZone = TimeZone(secondsFromGMT: 0)
            let timeZone = TimeZone(abbreviation: "CET")
            
            localDateFormatter!.locale = locale
            localDateFormatter!.timeZone = timeZone
            localDateFormatter!.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            // note: http://nshipster.com/nsformatter/ uses a different approach:
            //			let formatter = ISO8601DateFormatter()
            //			let timestamp = "2014-06-30T08:21:56+08:00"
            //			let date = formatter.date(from: timestamp)
        }
        
        let newTime : Date? = localDateFormatter!.date(from: self)
        return newTime
    }
    
    

}

private func lazyBuildFullDayFormat(){
    if (fullDayFormatFormatter == nil){
        fullDayFormatFormatter = DateFormatter()
        //let locale = Locale(identifier: "it_IT") // hack: force to IT, even if watch is set to other languages.
        //fullDayFormatFormatter!.locale = locale
        fullDayFormatFormatter!.dateFormat = "dd MMMM"
    }
    
}
