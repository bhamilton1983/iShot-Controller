//
//  HttpService.swift
//  RtspClient
//
//  Created by Brian Hamilton on 7/31/18.


import Foundation
import Photos



class HttpService :NSObject, XMLParserDelegate,  URLSessionDelegate, URLSessionStreamDelegate {
    var cameraText = String()
    var text = String()
    var clipParse = [String]()
    static var clipArray = [String]()
    var clipSize = [String]()
    var clipDate = [String]()
    var clipTimeArrqy = [String]()
    static var discovery = ""
    static var camera = Camera()
    static var XMLPackage:String = ""
    static var SOAPGet1:String = ""
    static var SOAPGet2:String = ""
    static var SOAPGet3:String = ""
    static var SOAPGet4:String = ""
    var result = [String]()
    var webData : NSMutableData?
    static var clipsToParse = String()
   

    func getBrand(url:String) {
        
        let ip = url
        
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
        
        //http://admin:admin@\(ip)/services/configuration.ion?sel=paramlist&params=videoinput_*.*,videoinput_*.*.*
        //"http://admin:admin@\(ip)/services/system.ion?sel=featureoptions
        
        URLCredentialStorage.shared.setDefaultCredential(credential, for: protectionSpace)
        let soapMessage1 = HttpService.SOAPGet1
        let soapMessage2 = HttpService.SOAPGet2
        let soapMessage3 = HttpService.SOAPGet3
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
          //  print("response = \(String(describing: response))")
        //    print(String(describing: data))
            //Let's convert response sent from a server side script to a NSDictionary object:
            do {
                
                let parser = XMLParser(data: data!)
                parser.delegate = self
                
                if parser.parse() {
                    
                    if let data = data,
                        let html = String(data: data, encoding: String.Encoding.utf8) {
                      // print(html)
                        
                        
                        // let textToParse = (html.sliceByString(from: "<paramlist>", to: "</paramlist>") as Any as! String)
                        
                        self.cameraText = html
                        
                        
                        
                        //     HttpService.XMLPackage = textToParse
                        //   HttpService.camera.mainLoad = textToParse
                        //    HttpService.camera.cameraInfo()
                        //     LoginTable.camera.GetCameraInfo(ip:Login.ip)
                        
                    }
                    
                }
            }
        }
        task.resume()
    }

    
    
    
    func getHttp(url:String) {
        
        let ip = url
     
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
   
        //http://admin:admin@\(ip)/services/configuration.ion?sel=paramlist&params=videoinput_*.*,videoinput_*.*.*
        //"http://admin:admin@\(ip)/services/system.ion?sel=featureoptions
  
    URLCredentialStorage.shared.setDefaultCredential(credential, for: protectionSpace)
        let soapMessage1 = HttpService.SOAPGet1
        let soapMessage2 = HttpService.SOAPGet2
        let soapMessage3 = HttpService.SOAPGet3
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
            print("response = \(String(describing: response))")
        //   print(String(describing: data))
            //Let's convert response sent from a server side script to a NSDictionary object:
            do {
                
                let parser = XMLParser(data: data!)
                parser.delegate = self
        
                if parser.parse() {
          
                    if let data = data,
                        let html = String(data: data, encoding: String.Encoding.utf8) {
                print(html)
                        
                        
                      // let textToParse = (html.sliceByString(from: "<paramlist>", to: "</paramlist>") as Any as! String)
                        
                        self.cameraText = html
                    
                        
                        
                       //     HttpService.XMLPackage = textToParse
                         //   HttpService.camera.mainLoad = textToParse
                        //    HttpService.camera.cameraInfo()
                       //     LoginTable.camera.GetCameraInfo(ip:Login.ip)
                                    
                                    }
                        
                                    }
                                    }
                                    }
                                task.resume()
                                    }
    
    func lightHttp () {
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
        let soapMessage1 = "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>"
        let soapMessage2 = HttpService.SOAPGet2
        let soapMessage3 = HttpService.SOAPGet3
        let soapMessage4 = HttpService.SOAPGet4
        let soapMessage = soapMessage1 + soapMessage2 + soapMessage3 + soapMessage4
        let session = URLSession.shared
      print(soapMessage)
        
        let url = URL(string: "http://admin:admin@\(Login.ip)/services/configuration.ion?action=setparams&format=text")
        var theRequest = URLRequest(url: url! as URL)
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.httpMethod = "POST"
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion:false )
        //  theRequest.addValue("Basic", "admin:admin" , forHTTPHeaderField: "Authorization")
        theRequest.httpShouldUsePipelining = true
        theRequest.httpShouldHandleCookies = true
        let task = session.dataTask(with: theRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
        }
        task.resume()
    }

func postHttp () {
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
    let soapMessage1 = mainInstance.firstString
    let soapMessage2 = HttpService.SOAPGet2
    let soapMessage3 = HttpService.SOAPGet3
    let soapMessage4 = HttpService.SOAPGet4
    let soapMessage = soapMessage1 + soapMessage2 + soapMessage3 + soapMessage4 
    let session = URLSession.shared
  print(soapMessage)
    
    let url = URL(string: "http://admin:admin@\(Login.ip)/services/configuration.ion?action=setparams&format=text")
    var theRequest = URLRequest(url: url! as URL)
    theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
    theRequest.httpMethod = "POST"
    theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion:false )
    //  theRequest.addValue("Basic", "admin:admin" , forHTTPHeaderField: "Authorization")
    theRequest.httpShouldUsePipelining = true
    theRequest.httpShouldHandleCookies = true
    let task = session.dataTask(with: theRequest) { (data: Data?, response: URLResponse?, error: Error?) in
        
        if error != nil
        {
            print("error=\(String(describing: error))")
            return
        }
        
    }
    task.resume()
    }
    func postStopZoom () {
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
        let soapMessage1 = mainInstance.firstString
        let soapMessage2 = HttpService.SOAPGet2
        let soapMessage3 = HttpService.SOAPGet3
        let soapMessage4 = HttpService.SOAPGet4
        let soapMessage = soapMessage1 + soapMessage2 + soapMessage3 + soapMessage4
        let session = URLSession.shared
        print(soapMessage)
        
        let url = URL(string: "http://admin:admin@\(Login.ip)/services/io.ion?action=ptz&source=videoinput_1&command=zoom&subcommand=outstop")
        var theRequest = URLRequest(url: url! as URL)
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.httpMethod = "POST"
      //  theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion:false )
        //  theRequest.addValue("Basic", "admin:admin" , forHTTPHeaderField: "Authorization")
        theRequest.httpShouldUsePipelining = true
        theRequest.httpShouldHandleCookies = true
        let task = session.dataTask(with: theRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
        }
        task.resume()
    }

    func postZoom () {
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
   
        
        let url = URL(string: "http://admin:admin@\(Login.ip)/services/io.ion?action=ptz&source=videoinput_1&command=zoom&subcommand=instart&zoom=100")
        var theRequest = URLRequest(url: url! as URL)
     //   theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.httpMethod = "POST"
      //  theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion:false )
        //  theRequest.addValue("Basic", "admin:admin" , forHTTPHeaderField: "Authorization")
        theRequest.httpShouldUsePipelining = true
        theRequest.httpShouldHandleCookies = true
        let task = session.dataTask(with: theRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
        }
        task.resume()
    }
    
    
    func postIrisOpen () {
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
        
        
        let url = URL(string: "http://admin:admin@\(Login.ip)/services/io.ion?action=ptz&source=videoinput_1&command=iris&subcommand=openstart")
        var theRequest = URLRequest(url: url! as URL)
        //   theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.httpMethod = "POST"
        //  theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion:false )
        //  theRequest.addValue("Basic", "admin:admin" , forHTTPHeaderField: "Authorization")
        theRequest.httpShouldUsePipelining = true
        theRequest.httpShouldHandleCookies = true
        let task = session.dataTask(with: theRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
        }
        task.resume()
    }
    
    
    func postIrisClose () {
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
        let url = URL(string: "http://admin:admin@\(Login.ip)/services/io.ion?action=ptz&source=videoinput_1&command=iris&subcommand=closestart")
        var theRequest = URLRequest(url: url! as URL)
        //   theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.httpMethod = "POST"
        //  theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion:false )
        //  theRequest.addValue("Basic", "admin:admin" , forHTTPHeaderField: "Authorization")
        theRequest.httpShouldUsePipelining = true
        theRequest.httpShouldHandleCookies = true
        let task = session.dataTask(with: theRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
        }
        task.resume()
    }
    
    func postIrisStop () {
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
        
        
        let url = URL(string: "http://admin:admin@\(Login.ip)/services/io.ion?action=ptz&source=videoinput_1&command=iris&subcommand=closestop")
        var theRequest = URLRequest(url: url! as URL)
        //   theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.httpMethod = "POST"
        //  theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion:false )
        //  theRequest.addValue("Basic", "admin:admin" , forHTTPHeaderField: "Authorization")
        theRequest.httpShouldUsePipelining = true
        theRequest.httpShouldHandleCookies = true
        let task = session.dataTask(with: theRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
        }
        task.resume()
    }
    func postFocusNear () {
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
    
        
        let url = URL(string: "http://admin:admin@\(Login.ip)/services/io.ion?action=ptz&source=videoinput_1&command=focus&subcommand=nearstart&speed=1")
        var theRequest = URLRequest(url: url! as URL)
       
        theRequest.httpMethod = "POST"
        theRequest.httpShouldUsePipelining = true
        theRequest.httpShouldHandleCookies = true
        let task = session.dataTask(with: theRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
        }
        task.resume()
    }
    func postFocusFar () {
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
        
        
        let url = URL(string: "http://admin:admin@\(Login.ip)/services/io.ion?action=ptz&source=videoinput_1&command=focus&subcommand=farstart&speed=1")
        var theRequest = URLRequest(url: url! as URL)
        
        theRequest.httpMethod = "POST"
        theRequest.httpShouldUsePipelining = true
        theRequest.httpShouldHandleCookies = true
        let task = session.dataTask(with: theRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
        }
        task.resume()
    }
    func postFocusStop () {
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
        
        
        let url = URL(string: "http://admin:admin@\(Login.ip)/services/io.ion?action=ptz&source=videoinput_1&command=focus&subcommand=farstop&speed=100")
        var theRequest = URLRequest(url: url! as URL)
        
        theRequest.httpMethod = "POST"
        theRequest.httpShouldUsePipelining = true
        theRequest.httpShouldHandleCookies = true
        let task = session.dataTask(with: theRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
        }
        task.resume()
    }
    func postZoomOut () {
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
        
        
        let url = URL(string: "http://admin:admin@\(Login.ip)/services/io.ion?action=ptz&source=videoinput_1&command=zoom&subcommand=outstart&zoom=100")
        var theRequest = URLRequest(url: url! as URL)
     //   theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.httpMethod = "POST"
        //  theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion:false )
        //  theRequest.addValue("Basic", "admin:admin" , forHTTPHeaderField: "Authorization")
        theRequest.httpShouldUsePipelining = true
        theRequest.httpShouldHandleCookies = true
        let task = session.dataTask(with: theRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
        }
        task.resume()
    }
    func postOnvif () {
        let credential = URLCredential(
            user: "root",
            password: "1234",
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
 
     //   let soapMessage = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n<e:Envelope xmlns:e=\"http://www.w3.org/2003/05/soap-envelope\"\r\nxmlns:w=\"http://schemas.xmlsoap.org/ws/2004/08/addressing\"\r\nxmlns:d=\"http://schemas.xmlsoap.org/ws/2005/04/discovery\"\r\nxmlns:dn=\"http://www.onvif.org/ver10/network/wsdl\">\r\n<e:Header>/r/n<w:MessageID>uuid:84ede3de-7dec-11d0-c360-f01234567890</w:MessageID>\r\n<w:To e:mustUnderstand=\"true\">urn:schemas-xmlsoap-org:ws:2005:04:discovery</w:To>\r\n<w:Action\r\na:mustUnderstand=\"true\">http://schemas.xmlsoap.org/ws/2005/04/discovery/Probe\r\n</w:Action>\r\n</e:Header>\r\n<e:Body>\r\n<d:Probe>\r\n<d:Types>dn:NetworkVideoTransmitter</d:Types>\r\n</d:Probe>\r\n</e:Body>\r\n</e:Envelope>"
     
        
        let session = URLSession.shared
     //  print(soapMessage)
        
        let url = URL(string: "http://root:1234@10.220.45.146/onvif/device_service")
        var theRequest = URLRequest(url: url! as URL)
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.httpMethod = "GET"
     //   theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion:false )
        //  theRequest.addValue("Basic", "admin:admin" , forHTTPHeaderField: "Authorization")
        theRequest.httpShouldUsePipelining = true
        theRequest.httpShouldHandleCookies = true
        let task = session.dataTask(with: theRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            // You can print out response object
            print("response = \(String(describing: response))")
            //  print(String(describing: data))
            //Let's convert response sent from a server side script to a NSDictionary object:
            do {
                
                let parser = XMLParser(data: data!)
                parser.delegate = self
                
                if parser.parse() {
                    
                    if let data = data,
                        let html = String(data: data, encoding: String.Encoding.utf8) {
                        //  print(html)
                    }
            
        }
            }
        }
        task.resume()
    }
    
 

        func postSave () {
        
       
   
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
            let url = URL(string: "http://admin:admin@\(Login.ip)/services/configuration.ion?action=saveparams")
        var theRequest = URLRequest(url: url! as URL)
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.httpMethod = "POST"
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion:false )
        //  theRequest.addValue("Basic", "admin:admin" , forHTTPHeaderField: "Authorization")
        theRequest.httpShouldUsePipelining = true
        theRequest.httpShouldHandleCookies = true
            let task = session.dataTask(with: theRequest) { (data: Data?, response: URLResponse?, error: Error?) in
                
                if error != nil
                {
                    print("error=\(String(describing: error))")
                    return
                }
                // You can print out response object
                print("response = \(String(describing: response))")
              //  print(String(describing: data))
                //Let's convert response sent from a server side script to a NSDictionary object:
                do {
                    
                    let parser = XMLParser(data: data!)
                    parser.delegate = self
                    
                    if parser.parse() {
                        
                        if let data = data,
                            let html = String(data: data, encoding: String.Encoding.utf8) {
                          //  print(html)
                        }
                    }
                }
            }
            
                
    
            task.resume()
    }
    func postConfig () {

        let soapMessage1 = VideoEncoder.firstResolution
        let soapMessage2 = HttpService.SOAPGet2
        let soapMessage3 = mainInstance.endstring
        let soapMessage = soapMessage1 + soapMessage2 + soapMessage3
     //   print(soapMessage)
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
        let url = URL(string:"http://admin:admin@\(Login.ip)/services/configuration.ion?action=setparams&format=text")
        var theRequest = URLRequest(url: url! as URL)
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.httpMethod = "POST"
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion:false )
        //  theRequest.addValue("Basic", "admin:admin" , forHTTPHeaderField: "Authorization")
        theRequest.httpShouldUsePipelining = true
        theRequest.httpShouldHandleCookies = true
        let task = session.dataTask(with: theRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
        }
        task.resume()
    }
   
    

    func discoverIP(url:String) {
    let soapMessage = ""
      //  print(soapMessage)
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
        let url = URL(string:"http://\(Login.ip)/services/system.ion?sel=discover")
    var theRequest = URLRequest(url: url! as URL)
    theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
    theRequest.httpMethod = "GET"
    theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion:false )
    //  theRequest.addValue("Basic", "admin:admin" , forHTTPHeaderField: "Authorization")
    theRequest.httpShouldUsePipelining = true
    theRequest.httpShouldHandleCookies = true
        let task = session.dataTask(with: theRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
            // You can print out response object
            print("response = \(String(describing: response))")
         //   print(String(describing: data))
            //Let's convert response sent from a server side script to a NSDictionary object:
            do {
                
                let parser = XMLParser(data: data!)
                parser.delegate = self
                
                if parser.parse() {
                    
                    if let data = data,
                        let html = String(data: data, encoding: String.Encoding.utf8) {
                        
                        let textToParse = (html.sliceByString(from:"<system.ion>", to: "</system.ion>") as Any as! String)
                            let camera = Camera()
                             camera.discoveryText = textToParse
                         
                        
                        
                        
                    }
                    
                        
                    }
                        
                }
            }

        
        task.resume()
            }


   
    func startRecording() {
        
        
        let soapMessage = ""
        print(soapMessage)
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
        let url = URL(string: "http://\(Login.ip)/services/media.ion?action=startondemandrecording")
     //   print(url)
        var theRequest = URLRequest(url: url! as URL)
        theRequest.httpMethod = "POST"
        //  theRequest.addValue("Basic", "admin:admin" , forHTTPHeaderField: "Authorization")
        theRequest.httpShouldUsePipelining = true
        theRequest.httpShouldHandleCookies = true
        let task = session.dataTask(with: theRequest) { (data: Data?, response: URLResponse?, error: Error?) in
                             //   print(response)
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
        }
        task.resume()
    }
    func stopRecording() {
        
        
        let soapMessage = ""
    //    print(soapMessage)
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
        let url = URL(string: "http://\(Login.ip)/services/media.ion?action=stopondemandrecording")
      //  print(url)
        var theRequest = URLRequest(url: url! as URL)
        theRequest.httpMethod = "POST"
        theRequest.httpShouldUsePipelining = true
        theRequest.httpShouldHandleCookies = true
        let task = session.dataTask(with: theRequest) { (data: Data?, response: URLResponse?, error: Error?) in
         //   print(response)
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
        }
        task.resume()
    }
    func postMedia() {
        
        
            let soapMessage1 = HttpService.SOAPGet1
            let soapMessage2 = HttpService.SOAPGet2
            let soapMessage3 = mainInstance.endstring
            let soapMessage = soapMessage1 + soapMessage2 + soapMessage3
            print(soapMessage)
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
        let url = URL(string: "http://admin:admin@\(Login.ip)/services/configuration.ion?action=setparams&format=text")
        var theRequest = URLRequest(url: url! as URL)
        theRequest.httpMethod = "POST"
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion:false )
        //  theRequest.addValue("Basic", "admin:admin" , forHTTPHeaderField: "Authorization")
        theRequest.httpShouldUsePipelining = true
        theRequest.httpShouldHandleCookies = true
        let task = session.dataTask(with: theRequest) { (data: Data?, response: URLResponse?, error: Error?) in
        //    print(response)
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
        }
        task.resume()
    }
    func postRecord() {
        
        let ip = "http://\(Login.ip)/services/media.ion?sel=clipinfo&sources=videoinput_1"
        
        //     // Delete all clips of the video input #1 on board #1 for the 2010-11-17
       // POST http://w.x.y.z/services/media.ion?action=deleteclips&clip=videoinput_1-1*20101117*.asf
        
        
        let soapMessage1 = HttpService.SOAPGet1
        let soapMessage2 = HttpService.SOAPGet2
        let soapMessage3 = mainInstance.endstring
        let soapMessage = soapMessage1 + soapMessage2 + soapMessage3
        print(soapMessage)
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
        let url = URL(string: ip)
        var theRequest = URLRequest(url: url! as URL)
        theRequest.httpMethod = "POST"
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion:false )
        //  theRequest.addValue("Basic", "admin:admin" , forHTTPHeaderField: "Authorization")
        theRequest.httpShouldUsePipelining = true
        theRequest.httpShouldHandleCookies = true
            let task = session.dataTask(with: theRequest) { (data: Data?, response: URLResponse?, error: Error?) in
                
                if error != nil
                {
                    print("error=\(String(describing: error))")
                    return
                }
                
                // You can print out response object
                print("response = \(String(describing: response))")
                print(String(describing: data))
                //Let's convert response sent from a server side script to a NSDictionary object:
                do {
                    
                    let parser = XMLParser(data: data!)
                    parser.delegate = self
                    
                    if parser.parse() {
                        
                        if let data = data,
                        let html = String(data: data, encoding: String.Encoding.utf8) {
                       
                    
                            self.text = html
                        
                            let secondString = self.text.dropFirst(195)
                            let thirdString = secondString.dropLast(51)
                            let nextText = self.text.sliceByString(from: "</moreresults>\r\n", to: "</clipinfo")
                            let final = nextText?.dropFirst(152)
                           
                      
                     
                            
                                    HttpService.clipsToParse = String(thirdString)
                                    self.result = (final?.components(separatedBy: "000Z\">"))!
                                //    self.clipAddress()
                               
                            
                  
            
                    
                    
                    
                }
                }
        }
        }
        
                        task.resume()   
        
    }


    
    
    func downloadToFolder() {
        
    let fileManager = FileManager.default
  
        
    let fileURL = URL(string: "ClipView.clipAddress")
        
    if let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
        let filePath =  tDocumentDirectory.appendingPathComponent("InterTest Folder")
        if !fileManager.fileExists(atPath: filePath.path) {
            do {
                try fileManager.createDirectory(atPath: filePath.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                NSLog("Couldn't create document directory")
            }
        }
        NSLog("Document directory is \(filePath)")
    }
    
    }
        
        
    
    
    
    
    
    
    
    
    
//
//    func downLoad () {
//
//            let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
//            let destinationFileUrl = documentsUrl.appendingPathComponent("\(ClipView.saveName).asf")
//
//            let fileURL = URL(string:ClipView.clipAddress)
//
//            let sessionConfig = URLSessionConfiguration.default
//            let session = URLSession(configuration: sessionConfig)
//
//            let request = URLRequest(url:fileURL!)
//
//            let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
//                if let tempLocalUrl = tempLocalUrl, error == nil {
//                    print(fileURL)
//                    print(destinationFileUrl)
//            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
//                print("Successfully downloaded. Status code: \(statusCode)")
//
//            }
//
//            do {
//                try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
//            } catch (let writeError) {
//                print("Error creating a file \(destinationFileUrl) : \(writeError)")
//            }
//
//                    } else {
//            print("Error took place while downloading a file. Error description: %@", error?.localizedDescription);
//        }
//    }
//
//    task.resume()
//    }
        }


extension Substring {
    mutating func remove(upToAndIncluding idx: Index) {
        self = self[index(after: idx)...]
    }
    
    mutating func parseField() -> Substring {
        assert(!self.isEmpty)
        switch self[startIndex] {
        case "\"":
            removeFirst()
            guard let quoteIdx = index(of: "\"") else {
                fatalError("expected quote") // todo throws
            }
            let result = prefix(upTo: quoteIdx)
            remove(upToAndIncluding: quoteIdx)
            if !isEmpty {
                let comma = removeFirst()
                assert(comma == ",") // todo throws
            }
            return result
            
        default:
            if let commaIdx = index(of: ",") {
                let result = prefix(upTo: commaIdx)
                remove(upToAndIncluding: commaIdx)
                return result
            } else {
                let result = self
                removeAll()
                return result
            }
        }
    }
}


