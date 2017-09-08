//
//  Double+String.swift
//  MeteoApp
//
//  Created by Gaia Magnani on 09/09/2017.
//  Copyright © 2017 Gaia Magnani. All rights reserved.
//

import Foundation

private var currencyFormatter: NumberFormatter?

extension Double{
    
    func toCurrency() -> String? {
        
        if currencyFormatter == nil{
            currencyFormatter = NumberFormatter()
        
            
            currencyFormatter!.positiveFormat = "#,##0.00"
            currencyFormatter!.groupingSeparator = "."
            
            currencyFormatter!.decimalSeparator = ","
            
        }
        
        let num: NSNumber = NSNumber(value: self)
        
        guard let formattedNumberString = currencyFormatter!.string(from: num ) else {
            return nil
        }
        
        var finalString: String?
        
        finalString = formattedNumberString
    
        return finalString
        
    }
} // extension Double

