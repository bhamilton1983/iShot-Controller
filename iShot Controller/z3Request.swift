//
//  z3Request.swift
//  RtspClient
//
//  Created by Brian Hamilton on 9/14/18.
//

import Foundation



class z3Request:NSObject, XMLParserDelegate,  URLSessionDelegate, URLSessionStreamDelegate {
    
     var jsonString = [String: AnyObject]()
     static var z3Soap = String()
    
    func z3Info(ip:String) {
        //http://10.220.45.134/cgi-bin/control.cgi?ctrl=enc&chn=1
        // http://10.220.45.134/cgi-bin/control.cgi?action=zoom_direct=0x0000&chn=1
        let url = URL(string: "http://\(ip)/cgi-bin/control.cgi?ctrl=enc&chn=1")
        
        let config = URLSessionConfiguration.default
        
        let request = NSMutableURLRequest(url: url!)
        
        request.httpMethod = "GET"
        
         //let bodyData =  "zoom_direct : "0x4000"]
        
      //   request.httpBody = bodyData.data(using: String.Encoding.utf8)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
      
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request as URLRequest as URLRequest, completionHandler: {(data, response, error) in
            if let response = response {
                let nsHTTPResponse = response as! HTTPURLResponse
                let statusCode = nsHTTPResponse.statusCode
                print ("status code = \(statusCode)")
            }
            if let error = error {
                print ("\(error)")
            }
            if let data = data {
                do{
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                    self.jsonString = jsonResponse as! [String : AnyObject]
                  // self.parseCamera()
                    print(jsonResponse)
                  
                }catch _ {
                    print ("OOps not good JSON formatted response")
                }
            }
        })
        task.resume()
        
    }
    
    func z3Zoom () {
       
     
            
            //declare parameter as a dictionary which contains string as key and value combination.
         //   let parameters = ["action":"CameraControl","command":"zoom_direct=0x4000"]
            
            //create the url with NSURL
            let url = NSURL(string: "http://\(Login.ip)/cgi-bin/control.cgi")
            
            let config = URLSessionConfiguration.default
            
            let request = NSMutableURLRequest(url: url! as URL)
            
            request.httpMethod = "POST"
            
           let bodyData =  "\(Z3ZoomViewController.segmentChoice) \(Z3ZoomViewController.currentZoomLevel)"
            print(bodyData)
            request.httpBody = bodyData.data(using: String.Encoding.utf8)
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("text/javascript", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
            let session = URLSession(configuration: config)
            
            let task = session.dataTask(with: request as URLRequest as URLRequest, completionHandler: {(data, response, error) in
                if let response = response {
                    let nsHTTPResponse = response as! HTTPURLResponse
                    let statusCode = nsHTTPResponse.statusCode
                    print ("status code = \(statusCode)")
                }
                if let error = error {
                    print ("\(error)")
                }
                if let data = data {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                    print ("data = \(jsonResponse)")
                    
                        
                    }catch _ {
                        print ("OOps not good JSON formatted response")
                    }
                }
            })
            task.resume()
            
}
    func parseCamera() {
        
           print(jsonString)
       
       
    }
    
    
    
    func z3Focus () {
        
        
        
        //declare parameter as a dictionary which contains string as key and value combination.
        //   let parameters = ["action":"CameraControl","command":"zoom_direct=0x4000"]
        
        //create the url with NSURL
        let url = NSURL(string: "http://\(Login.ip)/cgi-bin/control.cgi")
        
        let config = URLSessionConfiguration.default
        
        let request = NSMutableURLRequest(url: url! as URL)
        
        request.httpMethod = "POST"
        
        let bodyData =  "action=CameraControl&command=focus_direct \(z3Request.z3Soap)"
        print(bodyData)
        request.httpBody = bodyData.data(using: String.Encoding.utf8)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("text/javascript", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request as URLRequest as URLRequest, completionHandler: {(data, response, error) in
            if let response = response {
                let nsHTTPResponse = response as! HTTPURLResponse
                let statusCode = nsHTTPResponse.statusCode
                print ("status code = \(statusCode)")
            }
            if let error = error {
                print ("\(error)")
            }
            if let data = data {
                do{
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                    print ("data = \(jsonResponse)")
                }catch _ {
                    print ("OOps not good JSON formatted response")
                }
            }
        })
        task.resume()
        
    }
    func z3ZoomOut () {
        
        
        
        //declare parameter as a dictionary which contains string as key and value combination.
        //   let parameters = ["action":"CameraControl","command":"zoom_direct=0x4000"]
        
        //create the url with NSURL
        let url = NSURL(string: "http://\(Login.ip)/cgi-bin/control.cgi")
        
        let config = URLSessionConfiguration.default
        
        let request = NSMutableURLRequest(url: url! as URL)
        
        request.httpMethod = "POST"
        
        let bodyData =  "action=CameraControl&&command=\(z3Request.z3Soap)"
        
        request.httpBody = bodyData.data(using: String.Encoding.utf8)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("text/javascript", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
      
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request as URLRequest as URLRequest, completionHandler: {(data, response, error) in
            if let response = response {
                let nsHTTPResponse = response as! HTTPURLResponse
                let statusCode = nsHTTPResponse.statusCode
                print ("status code = \(statusCode)")
            }
            if let error = error {
                print ("\(error)")
            }
            if let data = data {
                do{
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                    print ("data = \(jsonResponse)")
                }catch _ {
                    print ("OOps not good JSON formatted response")
                }
            }
        })
        task.resume()
        
}
    func dzoom () {
        
        
        
        //declare parameter as a dictionary which contains string as key and value combination.
        //   let parameters = ["action":"CameraControl","command":"zoom_direct=0x4000"]
        
        //create the url with NSURL
        let url = NSURL(string: "http://\(Login.ip)/cgi-bin/control.cgi")
        
        let config = URLSessionConfiguration.default
        
        let request = NSMutableURLRequest(url: url! as URL)
        
        request.httpMethod = "POST"
        
        let bodyData =  "action=CameraControl&command=\(z3Request.z3Soap)"
        print(bodyData)
        request.httpBody = bodyData.data(using: String.Encoding.utf8)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("text/javascript", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
     
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request as URLRequest as URLRequest, completionHandler: {(data, response, error) in
            if let response = response {
                let nsHTTPResponse = response as! HTTPURLResponse
                let statusCode = nsHTTPResponse.statusCode
                print ("status code = \(statusCode)")
            }
            if let error = error {
                print ("\(error)")
            }
            if let data = data {
                do{
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                    print ("data = \(jsonResponse)")
                }catch _ {
                    print ("OOps not good JSON formatted response")
                }
            }
        })
        task.resume()
        
    }
}
