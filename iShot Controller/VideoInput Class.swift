//
//  VideoInput Class.swift
//  RtspClient
//
//  Created by Brian Hamilton on 9/6/18.
//

import Foundation


class VideoInput:NSObject, XMLParserDelegate, URLSessionDelegate {
    var jsonString = [String: AnyObject]()
    var videoinput1:[String:String] = [:]
    var elementInputArray = [String]()
    var valueInputArray = [String]()
    var elementVideo = String()
    var valueVideo = String()
    //
    var sensor:String?
    var CameraModelNumber = String()
    var CameraInputFormat = String()
    var sourceFrameRate:String?
    var edgeEnhance:String?
    var edgeEnhanceStrength:String?
    var noiseReductionStrength:String?
    var wideScreenConversion:String?
    var noiseReduction:String?
    
    func GetVideoInput1 (ip:String) {
        
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

        theRequest.httpShouldUsePipelining = true
        theRequest.httpShouldHandleCookies = true
        
        let task = session.dataTask(with: theRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
  
            do {
                
                let parser = XMLParser(data: data!)
                parser.delegate = self
                
                if parser.parse() {
                    
                    if let data = data,
                        let html = String(data: data, encoding: String.Encoding.utf8) {
                        
                        var anotherArray = [String]()
                        
                        let new = String(html.dropFirst(112))
                        let next = new.sliceByString(from: "<component name=\"videoinput_1\">", to: "</attributes>")
                        let nextStep = next?.dropFirst(125)
                        let nextCut = nextStep?.components(separatedBy: "<attribute name=\"")
                        
                        for cuts in nextCut! {
                            
                            
                            anotherArray.append(String(cuts.dropLast(13)))
                            
                        }
                        
                        
                        for small in anotherArray {
                            
                            self.valueVideo = small.components(separatedBy: "\">").first!
                            self.elementVideo = small.components(separatedBy: "\">").last!
                            self.valueInputArray.append(self.valueVideo)
                            self.elementInputArray.append(self.elementVideo)
                            
                        }
                        
                        for (index, element) in self.valueInputArray.enumerated()
                            
                        {
                            self.videoinput1[element] = self.elementInputArray[index]
                            
                        }
                        
                        self.createVideoInput()
                    }
                    
                }
            }
        }
        
        
        task.resume()
    }
  
    
    
    
    func createVideoInput() {
        
       // wideScreenConversion?  = self.videoinput1["\"widescreenconversion"]!
        noiseReduction? = self.videoinput1["noisereduction"]!
        edgeEnhanceStrength? = self.videoinput1["edgeenhancestrength"]!
        edgeEnhance? = self.videoinput1["edgeenhance"]!
        noiseReductionStrength?  = self.videoinput1["noisereductionstrength"]!
        sensor? = self.videoinput1["hdsensor"]!
        sourceFrameRate? = self.videoinput1["sourceframerate"]!
        CameraModelNumber = self.videoinput1["hdsensor"]!
        CameraInputFormat = self.videoinput1["digitalinputformat"]!
        
    }
    func z3Info(ip:String) {
        
        let url = URL(string: "http://\(ip)/cgi-bin/control.cgi?ctrl=sys&chn=null")
        
        let config = URLSessionConfiguration.default
        
        let request = NSMutableURLRequest(url: url!)
        
        request.httpMethod = "GET"
        
 
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
                   // print(jsonResponse)
                    self.parseZ3Input()
                    
                }catch _ {
                    print ("OOps not good JSON formatted response")
                }
            }
        })
        task.resume()
        
    }
    
    func parseZ3Input() {
        CameraModelNumber = (jsonString["hwversion"]! as? String)!
        sourceFrameRate? = (jsonString["camera1_if_type"]! as? String)!
        sensor? =  (jsonString["processor_id"]! as? String)!
        
    }
    
    
    
}
