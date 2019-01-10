//  CameraClass.swift
//  RtspClient
//  Created by Brian Hamilton on 8/1/18.

import Foundation



class Camera: NSObject, URLSessionDelegate, XMLParserDelegate {
    
    var camText = String()
    var sensor = Sensor()
    var encoder = H264()
    var videoInput = VideoInput()
    let http = HttpService()
    var discoveryArray = [String]()
    var encoderString = [String: AnyObject]()
    var jsonString = [String: AnyObject]()
    static var z3Soap = String()
    var processor:String?
    var serialNumber:String?
    var ipaddress:String?
    var boardID:String?
    var hardwareVersion:String?
    var sensorSerialNum:String?
    var systemDeviceName:String?
    var model:String?
    var videoResolution:String?
    var serialBaud:String?
    var videoSource:String?
    var videoCodec:String?
    var videoQuality:String?
    var macAddress = String()
    var finalArray = [String]()
    var discoveryText:String?
    var ipadd:String?
    var zoomMultiplier:Int?
    var firmWare:String = ""
    var boardModel = String()
    var serialPortCount:String?
    var attributes = String()
    var videoinput = String()
    var dhcpEnabled = String()
    var serialNum = String()
    var portNumber = String()
    var inputPinCount = String()
    var authenticationMethod = String()
    var ipaddressv4 = String()
    var videoInputCount = String()
    var outputRelayCount = String()
    var DHCPenabled = String()
    var element = String()
    var value = String()
    var discoveryDictionary:[String:String] = [:]
    var elementArray = [String]()
    var valueArray = [String]()
    static var SOAPGet1:String = ""
    static var SOAPGet2:String = ""
    static var SOAPGet3:String = ""
    static var SOAPGet4:String = ""
    

    
    func discoverIP(ip:String) {
        
        _ = ip
        let soapMessage = ""
    
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
        let session = URLSession.shared
        let url = URL(string:"http://\(ip)/services/system.ion?sel=discover")
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
                        print(html)
                        let textToParse = (html.sliceByString(from:"<discover>", to: "</discover>") as Any as! String)
                        let result = textToParse.components(separatedBy: "><")
                        for results in result {
                            let firstcut = results.components(separatedBy: "param name=")
                            for cuts in firstcut {
                                let nextCut = cuts.dropFirst(1)
                                
                                let last = String(nextCut.dropLast(7))
                                self.discoveryArray.append(last)
                                
                            }
                            
                            
                        }
                        
                        for thing in self.discoveryArray.dropLast(5) {
                            
                            self.value = thing.components(separatedBy: "\'>").first!
                            self.element = thing.components(separatedBy: "\'>").last!
                            self.valueArray.append(self.value)
                            self.elementArray.append(self.element)
                            
                        }
                        
                        for (index, element) in self.valueArray.enumerated()
                        {
                            self.discoveryDictionary[element] = self.elementArray[index]
                        }
                        
                    }
                  
                    self.discoverDevice()
                    self.grabAttributes()
                }
            }
        }
        task.resume()
        
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
                 self.parseCamera()
                 self.encoder.z3EncoderInfo(ip: Login.ip)
                 self.videoInput.z3Info(ip: Login.ip)
                
                    
                }catch _ {
                    print ("OOps not good JSON formatted response")
                }
            }
        })
        task.resume()
        
    }
    
    
    func discoverDevice () {
        
//        outputRelayCount = ""

        serialPortCount = self.discoveryDictionary["serialport.count"]
        firmWare = self.discoveryDictionary["firmwareversion"]!
        boardModel = self.discoveryDictionary["model"]!
        dhcpEnabled  = self.discoveryDictionary["firmwareversion"]!
        serialNum = self.discoveryDictionary["serialnum"]!
        macAddress = self.discoveryDictionary["macaddress"]!
        ipaddressv4 = self.discoveryDictionary["ipaddressv4"]!
        videoInputCount = self.discoveryDictionary["videoinput.count"]!
        DHCPenabled = self.discoveryDictionary["dhcpv4enabled"]!
        portNumber = self.discoveryDictionary["ionapiport"]!
        
    }
    func grabAttributes() {
        
        encoder.GetH264Input(ip: Login.ip)
        videoInput.GetVideoInput1(ip: Login.ip)
        sensor.GetBlockSensorInput(ip:Login.ip)
        
        
        
    }
    

    
    
    
    
    func parseCamera() {
        
        
        
        firmWare = (jsonString["processor_id"]! as? String)!
        hardwareVersion = jsonString["hwversion"]! as? String
        boardModel = (jsonString["board_id"]! as? String)!
        serialNum = (jsonString["hwserial"]! as? String)!
        ipaddressv4 = (jsonString["local_ip"]! as? String)!
  
        
        
    }
    
    
  

    
}
