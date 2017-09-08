//
//  ServiceRequester.swift
//  MeteoApp
//
//  Created by Gaia Magnani on 08/09/2017.
//  Copyright © 2017 Gaia Magnani. All rights reserved.
//

import Foundation

class ServiceRequester: NSObject, URLSessionDelegate {
    
    
    var session: URLSession?
    var params : Dict = [:] // by default is empty.
    var method : String = "POST"
    var lastError = 0
    private func addBodyToRequest(request: inout URLRequest){
        
        var body = ""
        for (k,v) in params{
            body = body + "&\(k)=\(v)"
        }
        let data = body.data(using: .utf8)
        request.httpBody = data
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
    }

    func getDataWith( completionHandler :  @escaping () -> Void,
                      errCompletionHandler :  ( (Int, String) -> Void )?
        ){
 
        var serverURLString = BASE_URL

        
        if method == "GET"{
            for (k,v) in params{
                serverURLString = serverURLString + "\(k)=\(v)&"
            }
        }
        
        guard let url =  URL(string: serverURLString ) else {
            #if DEBUG
                print("wrong URL format")
            #endif
            return
        }
        
        var request = URLRequest(url: url,
                                cachePolicy: .reloadIgnoringLocalCacheData,  //  .useProtocolCachePolicy,
            timeoutInterval: STD_HTTP_TIMEOUT)
        
        request.httpMethod = self.method

        // add additional params if in POST:
        if self.method == "POST"{
            self.addBodyToRequest(request: &request)
        }
        
        
        self.session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        
        let task = session!.dataTask(with: request, completionHandler: { (data, response, error: Error?) -> Void in
            
            if (error != nil){
                    print(error!)
                return
            }
            
            // we got some aswer:
            if let HTTPResponse = response as? HTTPURLResponse
            {
                _ = HTTPResponse.statusCode == 200 || HTTPResponse.statusCode == 201 ? true : false
            }
            
            if let data = data, let _ = response?.url {
            
                
                self.parse(data: data)
                if self.lastError == 0 {
                    completionHandler()
                }else{
                    errCompletionHandler!(self.lastError, "parse error")
                }
            }
            
        })
        
        task.resume()
    }
    

    
    
    /// every descendant will implement a parser, this parser is going to be always override
    func parse(data : Data) {
        
        #if DEBUG
            print("never here!")
        #endif
        
        do {
            if let d = try JSONSerialization.jsonObject(with: data, options: []) as? Dict{
                
                #if DEBUG
                    print(d)
                #endif
                
            }
        } catch  {
            return
        }
    }

    
}
