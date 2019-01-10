//
//  z3Camera.swift
//  RtspClient
//
//  Created by Brian Hamilton on 10/3/18.
//

import Foundation



class zCamera: NSObject, URLSessionDelegate, XMLParserDelegate {

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
    
    
    
    func z3Info() {
        //http://10.220.45.134/cgi-bin/control.cgi?ctrl=enc&chn=1
        //  http://10.220.45.134/cgi-bin/control.cgi?action=zoom_direct=0x0000&chn=1
        let url = URL(string: "http://\(Login.ip))/cgi-bin/control.cgi?ctrl=sys&chn=null")
        
        let config = URLSessionConfiguration.default
        
        let request = NSMutableURLRequest(url: url!)
        
        request.httpMethod = "GET"
        
        // let bodyData =  "zoom_direct : "0x4000"]
        
        //  request.httpBody = bodyData.data(using: String.Encoding.utf8)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        print(url)
        print(request)
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
                    
                }catch _ {
                    print ("OOps not good JSON formatted response")
                }
            }
        })
        task.resume()
        
    }
    
    func z3EncoderInfo() {
        //http://10.220.45.134/cgi-bin/control.cgi?ctrl=enc&chn=1
        // http://10.220.45.134/cgi-bin/control.cgi?action=zoom_direct=0x0000&chn=1
        let url = URL(string: "http://\(Login.ip)/cgi-bin/control.cgi?ctrl=enc&chn=1")
        
        let config = URLSessionConfiguration.default
        
        let request = NSMutableURLRequest(url: url!)
        
        request.httpMethod = "GET"
        
        // let bodyData =  "zoom_direct : "0x4000"]
        
        //  request.httpBody = bodyData.data(using: String.Encoding.utf8)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        print(url)
        print(request)
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


    
 
  

    func parseEncoder() {
        
        print(encoderString)
           videoCodec = encoderString["vcodec"]! as? String
           videoResolution = encoderString["vres"]! as? String
           videoSource = encoderString["vsource"]! as? String
           videoQuality = encoderString["vquality"]! as? String
           serialBaud = encoderString["klvserialbaud"]! as? String
      
    }




    func parseCamera() {
        

        
        processor = jsonString["processor_id"]! as? String
        hardwareVersion = jsonString["hwversion"]! as? String
        boardID = jsonString["board_id"]! as? String
        serialNumber = jsonString["hwserial"]! as? String
        ipaddress = jsonString["local_ip"]! as? String
        
    }




}
