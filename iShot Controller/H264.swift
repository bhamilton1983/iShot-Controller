
//  H26.swift
//  RtspClient
//
//  Created by Brian Hamilton on 9/6/18.


import Foundation


class H264: NSObject, URLSessionDelegate, XMLParserDelegate {
    
    var encoderString = [String: AnyObject]()
    var jsonString = [String: AnyObject]()
    var h264Dictionary:[String:String] = [:]
    var h264ElementArray = [String]()
    var h264ValueArray = [String]()
    var elementh264 = String()
    var valueh264 = String()
 
    // values of h264 below
    var resolution:String?
    var skiprate = String()
    var bitrate = String()
    var ratecontrol = String()
    var vbragressiveness = String()
    var profile = String()
    var videosourcetype = String()
    var encoderEnabled = String()
    var minimumQP = String()
    var maximumQP = String()
    var intrainterval = String()
    var customName = String()
    var multiCastAddress = String()
    var videoSourceIndex = String()
  
    
    func z3EncoderInfo(ip:String) {
      
        let url = URL(string: "http://\(ip)/cgi-bin/control.cgi?ctrl=enc&chn=1")
        
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
                    self.encoderString = jsonResponse as! [String : AnyObject]
                    self.parseEncoder()
                    
                    
                }catch _ {
                    print ("OOps not good JSON formatted response")
                }
            }
        })
        task.resume()
        
    }


    
    func GetH264Input (ip:String) {
        
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
            
            // You can print out response object
        //    print("response = \(String(describing: response))")
          //  print(String(describing: data))
            //Let's convert response sent from a server side script to a NSDictionary object:
            do {
                
                let parser = XMLParser(data: data!)
                parser.delegate = self
                
                if parser.parse() {
                    
                    if let data = data,
                        
                        let html = String(data: data, encoding: String.Encoding.utf8) {
                        
                        
                        var anotherArray = [String]()
                        
                        let next = html.sliceByString(from: "<component name=\"h264_1\"", to: "</attributes>")
                        
                        let nextCut = next?.components(separatedBy: "<attribute name=\"")
                        
                        for cuts in nextCut! {
                            
                            anotherArray.append(String(cuts.dropLast(13)))
                            
                        }
                        
                        for small in anotherArray {
                            
                            self.valueh264 = small.components(separatedBy: "\">").first!
                            self.elementh264 = small.components(separatedBy: "\">").last!
                            self.h264ElementArray.append(self.valueh264)
                            self.h264ValueArray.append(self.elementh264)
                            
                        }
                        for (index, element) in self.h264ElementArray.enumerated()
                            
                        {
                            self.h264Dictionary[element] = self.h264ValueArray[index]
                        }
                        
                        
                    }
              
                    self.createEncoder()
                    
                }
            }
            }
            task.resume()
    }
   
    

    
    
    
    func parseEncoder() {
        
        print(encoderString)
      //  videoCodec = encoderString["vcodec"]! as? String
        resolution = (encoderString["vres"]! as? String)!
    //    videoSource = encoderString["vsource"]! as? String
        profile = (encoderString["vquality"]! as? String)!
       // serialBaud = encoderString["klvserialbaud"]! as? String
        
      
        
    }
    func createEncoder() {
        
        resolution = h264Dictionary["resolution"]
        skiprate = h264Dictionary["skiprate"]!
        bitrate = h264Dictionary["bitrate"]!
        vbragressiveness  = h264Dictionary["vbraggressiveness"]!
        ratecontrol  = h264Dictionary["ratecontrol"]!
        minimumQP   = h264Dictionary["minqp"]!
        maximumQP  = h264Dictionary["maxqp"]!
        intrainterval  = h264Dictionary["intrainterval"]!
        multiCastAddress    = h264Dictionary["multicastipaddress"]!
        //  videoSourceIndex   = h264Dictionary["VideoSourceIndex"]!
        //  customName   = h264Dictionary["customname"]!
        encoderEnabled   = h264Dictionary["enabled"]!
        //  videosourcetype = h264Dictionary["videosourcetype"]!
        profile = h264Dictionary["profile"]!
    print(bitrate)

}
}
