//
//  Sensor Class.swift
//  RtspClient
//
//  Created by Brian Hamilton on 9/6/18.
//

import Foundation

class Sensor: NSObject, URLSessionDelegate, XMLParserDelegate {
    
    var sensorDictionary:[String:String] = [:]
    var sensorElementArray = [String]()
    var sensorValueArray = [String]()
    var elementsensor = String()
    var valuesensor = String()
    // these are utility to parse the html package coming back
    // Below are the sensor category variables
    var transparentserialportinstance = String()
    var zoomMultiplier:Int?
    var defog = String()
    var widedynamicrange = String()
    var widedynamicrangefcbev = String()
    var wdbrightcompensationlevel = String()
    var wdbrightlevel = String()
    var highsensitivity = String()
    var currentzoomlevel = String()
    var imagestabilization = String()
    var mirror = String()
    var initialzoomlevel = String()
    var initialfocuslevel = String()
    var currentfocuslevel = String()
    var initialirislevel = String()
    var currentirislevel = String()
    var gainlevel = String()
    var brightlevel = String()
    var autoicr = String()
    var whitebalance = String()
    var autofocus = String()
    var automaticexposure = String()
    var temperature = String()
    var digitalzoomenable = String()
    var initialdigitalzoomlevel = String()
    var currentdigitalzoomlevel = String()
    var colorgain = String()
    var shutterspeed = String()
    
    func GetBlockSensorInput (ip:String) {
        
        _ = ip
        
        let credential = URLCredential(
            user: "admin",
            password: "admin",
            persistence: .forSession
        )
        let protectionSpace = URLProtectionSpace(
            host: "example.com",
            port: 80,
            protocol: "https",
            realm: nil,
            authenticationMethod: NSURLAuthenticationMethodHTTPBasic
        )
        URLCredentialStorage.shared.setDefaultCredential(credential, for: protectionSpace)
        let soapMessage1 = Camera.SOAPGet1
        let soapMessage2 = Camera.SOAPGet2
        let soapMessage3 = Camera.SOAPGet3
        let soapMessage = soapMessage1 + soapMessage2 + soapMessage3
        let session = URLSession.shared
        let url = URL(string: "http://admin:admin@\(ip)/services/configuration.ion?sel=paramlist&params=videoinput_*.*,videoinput_*.*.*")
        var theRequest = URLRequest(url: url! as URL)
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.httpMethod = "GET"
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion:false )
        //            theRequest.addValue("Basic", "admin:admin" , forHTTPHeaderField: "Authorization")
        theRequest.httpShouldUsePipelining = true
        theRequest.httpShouldHandleCookies = true
        
        let task = session.dataTask(with: theRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
            // You can print out response object
        //    print("response = \(String(describing: response))")
       //     print(String(describing: data))
            //Let's convert response sent from a server side script to a NSDictionary object:
            do {
                
                let parser = XMLParser(data: data!)
                parser.delegate = self
                
                if parser.parse() {
                    
                    if let data = data,
                        
                        let html = String(data: data, encoding: String.Encoding.utf8) {
                  
                        var anotherArray = [String]()
                        
                        let next = html.sliceByString(from: "<component name=\"sensor\">", to: "</component>")
               
                        let nextCut = next?.components(separatedBy: "<attribute name=\"")
                   
                        for cuts in nextCut! {
                            
                            anotherArray.append(String(cuts.dropLast(13)))
                            
                        }
                        
                        for small in anotherArray {
                            
                            self.valuesensor = small.components(separatedBy: "\">").first!
                            self.elementsensor = small.components(separatedBy: "\">").last!
                            self.sensorElementArray.append(self.valuesensor)
                            self.sensorValueArray.append(self.elementsensor)
                            
                        }
                        for (index, element) in self.sensorElementArray.enumerated()
                            
                        {
                            self.sensorDictionary[element] = self.sensorValueArray[index]
                           
                        }
                     //   print("SENSOR")
                     //   print(self.sensorDictionary)
                        self.blocksensorValue()
                        
                    }
                    
                }
            }
        }
        task.resume()
        
    }
    
    
    
    
    func blocksensorValue() {
        
        wdbrightcompensationlevel = sensorDictionary["wdbrightcompensationlevel"]!
        imagestabilization = sensorDictionary["imagestabilization"]!
        mirror = sensorDictionary["mirror"]!
        initialzoomlevel = sensorDictionary["initialzoomlevel"]!
        currentzoomlevel = sensorDictionary["currentzoomlevel"]!
        currentfocuslevel  = sensorDictionary["currentfocuslevel"]!
        initialfocuslevel = sensorDictionary["initialfocuslevel"]!
        highsensitivity = sensorDictionary["highsensitivity"]!
        initialzoomlevel = sensorDictionary["initialzoomlevel"]!
        currentirislevel = sensorDictionary["currentirislevel"]!
        wdbrightlevel  = sensorDictionary["wdbrightlevel"]!
        wdbrightlevel  = sensorDictionary["wdbrightlevel"]!
        defog = sensorDictionary["defog"]!
        initialzoomlevel = sensorDictionary["initialzoomlevel"]!
        currentirislevel = sensorDictionary["currentirislevel"]!
        gainlevel = sensorDictionary["gainlevel"]!
        brightlevel   = sensorDictionary["brightlevel"]!
        initialdigitalzoomlevel  = sensorDictionary["initialdigitalzoomlevel"]!
        digitalzoomenable    = sensorDictionary["digitalzoomenable"]!
        autoicr = sensorDictionary["autoicr"]!
        whitebalance = sensorDictionary["whitebalance"]!
        autofocus = sensorDictionary["autofocus"]!
        automaticexposure = sensorDictionary["automaticexposure"]!
      //  if let temperature = sensorDictionary["temperature"]!
        shutterspeed  = sensorDictionary["shutterspeed"]!
        colorgain  = sensorDictionary["colorgain"]!
        transparentserialportinstance = sensorDictionary["transparentserialportinstance"]!
        
       
      
    }
    func GetBoardSensorInput (ip:String) {
        
        _ = ip
        
        let credential = URLCredential(
            user: "admin",
            password: "admin",
            persistence: .forSession
        )
        let protectionSpace = URLProtectionSpace(
            host: "example.com",
            port: 80,
            protocol: "https",
            realm: nil,
            authenticationMethod: NSURLAuthenticationMethodHTTPBasic
        )
        URLCredentialStorage.shared.setDefaultCredential(credential, for: protectionSpace)
        let soapMessage1 = Camera.SOAPGet1
        let soapMessage2 = Camera.SOAPGet2
        let soapMessage3 = Camera.SOAPGet3
        let soapMessage = soapMessage1 + soapMessage2 + soapMessage3
        let session = URLSession.shared
        let url = URL(string: "http://admin:admin@\(ip)/services/configuration.ion?sel=paramlist&params=videoinput_*.*,videoinput_*.*.*")
        var theRequest = URLRequest(url: url! as URL)
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.httpMethod = "GET"
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion:false )
        //            theRequest.addValue("Basic", "admin:admin" , forHTTPHeaderField: "Authorization")
        theRequest.httpShouldUsePipelining = true
        theRequest.httpShouldHandleCookies = true
        
        let task = session.dataTask(with: theRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
            // You can print out response object
       //     print("response = \(String(describing: response))")
         //   print(String(describing: data))
            //Let's convert response sent from a server side script to a NSDictionary object:
            do {
                
                let parser = XMLParser(data: data!)
                parser.delegate = self
                
                if parser.parse() {
                    
                    if let data = data,
                        
                        let html = String(data: data, encoding: String.Encoding.utf8) {
                       
                        var anotherArray = [String]()
                        
                        let next = html.sliceByString(from: "name=\"videoinput_1\">", to: "</attributes>")
                        
                        let nextCut = next?.components(separatedBy: "<attribute name=\"")
                        
                        for cuts in nextCut! {
                            
                            anotherArray.append(String(cuts.dropLast(13)))
                            
                        }
                        
                        for small in anotherArray {
                            
                            self.valuesensor = small.components(separatedBy: "\">").first!
                            self.elementsensor = small.components(separatedBy: "\">").last!
                            self.sensorElementArray.append(self.valuesensor)
                            self.sensorValueArray.append(self.elementsensor)
                            
                        }
                        for (index, element) in self.sensorElementArray.enumerated()
                            
                        {                           self.sensorDictionary[element] = self.sensorValueArray[index]
                        }
                        
                        self.boardSensorValue()
                        
                    }
                    
                }
            }
        }
        task.resume()
        
    }
    func boardSensorValue() {
        
        imagestabilization = sensorDictionary["imagestabilization"]!
        mirror  = sensorDictionary["mirror"]!
        initialzoomlevel = sensorDictionary["initialzoomlevel"]!
        currentzoomlevel = sensorDictionary["currentzoomlevel"]!
        currentfocuslevel  = (sensorDictionary["currentfocuslevel"])!
        initialfocuslevel = sensorDictionary["initialfocuslevel"]!
        initialzoomlevel = sensorDictionary["initialzoomlevel"]!
        gainlevel = sensorDictionary["gainlevel"]!
        initialdigitalzoomlevel  = sensorDictionary["initialdigitalzoomlevel"]!
        whitebalance = sensorDictionary["whitebalance"]!
        automaticexposure = sensorDictionary["automaticexposure"]!
        shutterspeed  = sensorDictionary["shutterspeed"]!
        
        
    }
    
}
