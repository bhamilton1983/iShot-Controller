//
//  BasicCommands.swift
//  
//
//  Created by Brian Hamilton on 12/18/18.
//

import Foundation
import UIKit
import Moscapsule

class BasicCommands: NSObject  {
    
  
    static var LoginName = "String"
    var http = HttpService()
    var request = z3Request()
    var zoom = zoomParser()
    var mqttConfig = MQTTConfig(clientId: "Mamba", host: "10.220.45.109", port: 1883, keepAlive: 60)
    var mqttClient: MQTTClient? = nil
  
    func pub () {
        
        
        mqttConfig.onPublishCallback = { messageId in
            print("published (msg id=\(messageId)))")
         }
        mqttConfig.onMessageCallback = { mqttMessage in
            // print("MQTT Message received: payload=\(mqttMessage.payloadString)")
            let receivedMessage = mqttMessage.payloadString!
            //  print("from server msg = \(receivedMessage)")
            let data = receivedMessage.data(using: .utf8, allowLossyConversion: false)!
            
         }
        
        mqttClient = MQTT.newConnection(mqttConfig, connectImmediately: true)
        
        
        mqttClient?.publish(string: "{\"command\":\"8101040727FF\n\"}", topic: "mamba/rs/write", qos: 1, retain: false)
        
    }
    
    
    func zoom (name:String, value:Float) {
 
        
        
        if BasicCommands.LoginName == "IONODES" {
          
            
            
                http.postZoom()
            
           }
        
        if BasicCommands.LoginName == "ZCAM" {
            if value == 0 {
                  z3Request.z3Soap = "zoom_stop"
                  request.dzoom()
            }
             let zoomValue = value * 100000
               z3Request.z3Soap = "zoom_tele_var 7"
               request.dzoom()
            
        }
       
        if BasicCommands.LoginName == "TWIGA" {
            
               self.mqttClient?.publish(string: "{\"command\":\"8101040102FF\n\"}", topic: "mamba/rs/write", qos: 0, retain: false)
     
            
        }
        
}
    func zoomStop (name:String, value:Float) {
        
        
        
        if BasicCommands.LoginName == "IONODES" {

            
          
            http.postStopZoom()
            
        }
        
        if BasicCommands.LoginName == "ZCAM" {
           
            z3Request.z3Soap = "zoom_stop"
            request.dzoom()
            
        }
        
        if BasicCommands.LoginName == "TWIGA" {
            
            self.mqttClient?.publish(string: "{\"command\":\"8101040102FF\n\"}", topic: "mamba/rs/write", qos: 0, retain: false)
            
            
        }
        
    }
    
    func focusNear(name:String, value:Float) {
        
        
       
        if BasicCommands.LoginName == "IONODES" {
          
             let text = "\(value)"
             http.postFocusNear()
        }
        
        if BasicCommands.LoginName == "ZCAM" {
            let zoomValue = value * 64000
             Z3ZoomViewController.segmentChoice = "action=CameraControl&command=focus_direct \(zoomValue)"
             request.z3Zoom()
            
        }
        
        if BasicCommands.LoginName == "TWIGA" {
            
            self.mqttClient?.publish(string: "{\"command\":\"8101040102FF\n\"}", topic: "mamba/rs/write", qos: 0, retain: false)
            
            
        }
        
    }
    
    func focusFar(name:String, value:Float) {
        
        
        
        if BasicCommands.LoginName == "IONODES" {
            
          let text = "\(value)"
            http.postFocusFar()
                
                
            }
        
        
        if BasicCommands.LoginName == "ZCAM" {
            
                
               
            
            let zoomValue = value * 640000
            Z3ZoomViewController.segmentChoice = "action=CameraControl&command=focus_direct \(zoomValue)"
            request.z3Zoom()
            
        }
        
        if BasicCommands.LoginName == "TWIGA" {
            
            self.mqttClient?.publish(string: "{\"command\":\"8101040102FF\n\"}", topic: "mamba/rs/write", qos: 0, retain: false)
            
            
        }
        
    }
    
    func zoomOut (name:String, value:Float) {
        
        
        
        if BasicCommands.LoginName == "IONODES" {
            
          
          
           
            http.postZoomOut()
            
        }
        
        if BasicCommands.LoginName == "ZCAM" {
            if value == 0 {
                z3Request.z3Soap = "zoom_stop"
                request.dzoom()
            }
            
            z3Request.z3Soap  = "zoom_wide_var 7"
           
            request.dzoom()
            
        }
        
        if BasicCommands.LoginName == "TWIGA" {
            
            self.mqttClient?.publish(string: "{\"command\":\"8101040102FF\n\"}", topic: "mamba/rs/write", qos: 0, retain: false)
            
            
        }
        
    }
    
    func irisOpen (name:String, value:Float) {
        
        
        
        if BasicCommands.LoginName == "IONODES" {
            
     
            
            
            http.postIrisOpen()
            
        }
        
        if BasicCommands.LoginName == "ZCAM" {
            if value == 0 {
                z3Request.z3Soap = "zoom_stop"
                request.dzoom()
            }
            
            z3Request.z3Soap  = "zoom_wide_var 7"
            
            request.dzoom()
            
        }
        
        if BasicCommands.LoginName == "TWIGA" {
            
            self.mqttClient?.publish(string: "{\"command\":\"8101040102FF\n\"}", topic: "mamba/rs/write", qos: 0, retain: false)
            
            
        }
        
    }
    func irisClose (name:String, value:Float) {
        
        
        
        if BasicCommands.LoginName == "IONODES" {
            
         
            
            
            http.postIrisClose()
            
        }
        
        if BasicCommands.LoginName == "ZCAM" {
            if value == 0 {
                z3Request.z3Soap = "zoom_stop"
                request.dzoom()
            }
            
            z3Request.z3Soap  = "zoom_wide_var 7"
            
            request.dzoom()
            
        }
        
        if BasicCommands.LoginName == "TWIGA" {
            
            self.mqttClient?.publish(string: "{\"command\":\"8101040102FF\n\"}", topic: "mamba/rs/write", qos: 0, retain: false)
            
            
        }
        
    }
    func eFlipOn (name:String) {
        
        if BasicCommands.LoginName == "IONODES" {
            HttpService.SOAPGet2 = "mirror="
            HttpService.SOAPGet3 = "vertical"
            HttpService.SOAPGet4 = mainInstance.endstring
            http.postHttp()
            
        }
        
        if BasicCommands.LoginName == "ZCAM" {
            z3Request.z3Soap = "eflip_on"
            request.dzoom()
        }
        
        if BasicCommands.LoginName == "TWIGA" {
           
          
             self.mqttClient?.publish(string: "{\"command\":\"8101040102FF\n\"}", topic: "mamba/rs/write", qos: 0, retain: false)
            
        }
        
        
    }
    
    func eFlipOff (name:String) {
        
        if BasicCommands.LoginName == "IONODES" {
            HttpService.SOAPGet2 = "mirror="
            HttpService.SOAPGet3 = "none"
            HttpService.SOAPGet4 = mainInstance.endstring
            http.postHttp()
            
        }
        
        if BasicCommands.LoginName == "ZCAM" {
            z3Request.z3Soap = "eflip_off"
            request.dzoom()
        }
        
        if BasicCommands.LoginName == "TWIGA" {
         
             self.mqttClient?.publish(string: "{\"command\":\"8101040102FF\n\"}", topic: "mamba/rs/write", qos: 0, retain: false)
            
        }
        
        
    }
    func icrOn (name:String) {
        
        if BasicCommands.LoginName == "IONODES" {
            HttpService.SOAPGet2 = "icr="
            HttpService.SOAPGet3 = "true"
            HttpService.SOAPGet4 = mainInstance.endstring
            http.postHttp()
            
        }
        
        if BasicCommands.LoginName == "ZCAM" {
            z3Request.z3Soap = "icr_mode on"
            request.dzoom()
        }
        
        if BasicCommands.LoginName == "TWIGA" {
            
             self.mqttClient?.publish(string: "{\"command\":\"8101040102FF\n\"}", topic: "mamba/rs/write", qos: 0, retain: false)
           
            
        }
        
        
    }
    func icrOff (name:String) {
        
        if BasicCommands.LoginName == "IONODES" {
            HttpService.SOAPGet2 = "icr="
            HttpService.SOAPGet3 = "false"
            HttpService.SOAPGet4 = mainInstance.endstring
            http.postHttp()
            
        }
        
        if BasicCommands.LoginName == "ZCAM" {
            z3Request.z3Soap = "icr_mode off"
            request.dzoom()
        }
        
        if BasicCommands.LoginName == "TWIGA" {
            
            
        }
        
        
    }
    func mirrorHorizontal (name:String) {
        
        if BasicCommands.LoginName == "IONODES" {
            HttpService.SOAPGet2 = "mirror="
            HttpService.SOAPGet3 = "horizontal"
            HttpService.SOAPGet4 = mainInstance.endstring
            http.postHttp()
            
        }
        
        if BasicCommands.LoginName == "ZCAM" {
            z3Request.z3Soap = "lr_reverse_on"
            request.dzoom()
        }
        
        if BasicCommands.LoginName == "TWIGA" {
            
            
        }
        
        
    }
    func mirrorHorizontalOff (name:String) {
        
        if BasicCommands.LoginName == "IONODES" {
            HttpService.SOAPGet2 = "icr="
            HttpService.SOAPGet3 = "false"
            HttpService.SOAPGet4 = mainInstance.endstring
            http.postHttp()
            
        }
        
        if BasicCommands.LoginName == "ZCAM" {
            z3Request.z3Soap = "lr_reverse_off"
            request.dzoom()
        }
        
        if BasicCommands.LoginName == "TWIGA" {
            
            
        }
        
        
    }
    func autoFocusOn (name:String) {
        
        if BasicCommands.LoginName == "IONODES" {
            HttpService.SOAPGet2 = "autofocus="
            HttpService.SOAPGet3 = "true"
            HttpService.SOAPGet4 = mainInstance.endstring
            http.postHttp()
            
        }
        
        if BasicCommands.LoginName == "ZCAM" {
            z3Request.z3Soap = "focus_auto"
            request.dzoom()
        }
        
        if BasicCommands.LoginName == "TWIGA" {
            
            
        }
        
        
    }
    func autoFocusOff (name:String) {
        
        if BasicCommands.LoginName == "IONODES" {
            HttpService.SOAPGet2 = "autofocus="
            HttpService.SOAPGet3 = "false"
            HttpService.SOAPGet4 = mainInstance.endstring
            http.postHttp()
            
        }
        
        if BasicCommands.LoginName == "ZCAM" {
             z3Request.z3Soap = "focus_manual"
             request.dzoom()
        }
        
        if BasicCommands.LoginName == "TWIGA" {
            
            
        }
     }
    
    func autoExporsureOn (name:String) {
        
        if BasicCommands.LoginName == "IONODES" {
            HttpService.SOAPGet2 = "automaticexposure="
            HttpService.SOAPGet3 = "auto"
            HttpService.SOAPGet4 = mainInstance.endstring
           
            http.postHttp()
            
        }
        
        if BasicCommands.LoginName == "ZCAM" {
                z3Request.z3Soap = "ae_mode 0"
            request.dzoom()
        }
        
        if BasicCommands.LoginName == "TWIGA" {
            
            
        }
    }
        func autoExporsureOff (name:String) {
            
            if BasicCommands.LoginName == "IONODES" {
                HttpService.SOAPGet2 = "automaticexposure="
                HttpService.SOAPGet3 = "manual"
                HttpService.SOAPGet4 = mainInstance.endstring
           
                http.postHttp()
                
            }
            
            if BasicCommands.LoginName == "ZCAM" {
                z3Request.z3Soap = "ae_mode 3"
                request.dzoom()
            }
            
            if BasicCommands.LoginName == "TWIGA" {
                
                
            }
    }
    
    func imageStabOn (name:String) {
        
        if BasicCommands.LoginName == "IONODES" {
            HttpService.SOAPGet2 = "imagestabilisation="
            HttpService.SOAPGet3 = "true"
            HttpService.SOAPGet4 = mainInstance.endstring
            
            http.postHttp()
            
        }
        
        if BasicCommands.LoginName == "ZCAM" {
            z3Request.z3Soap = "ae_mode 3"
            request.dzoom()
        }
        
        if BasicCommands.LoginName == "TWIGA" {
            
            
        }
    }
    
    
    
    func imageStabOff (name:String) {
        
        if BasicCommands.LoginName == "IONODES" {
            HttpService.SOAPGet2 = "imagestabilisation="
            HttpService.SOAPGet3 = "false"
            HttpService.SOAPGet4 = mainInstance.endstring
            http.postHttp()
            
        }
        
        if BasicCommands.LoginName == "ZCAM" {
            z3Request.z3Soap = "ae_mode 3"
            request.dzoom()
        }
        
        if BasicCommands.LoginName == "TWIGA" {
            
            
        }
    }
    func autoExposureIris (name:String) {
        
        if BasicCommands.LoginName == "IONODES" {
            HttpService.SOAPGet2 = "automaticexposure="
            HttpService.SOAPGet3 = "iris"
            HttpService.SOAPGet4 = mainInstance.endstring
            
            http.postHttp()
            
        }
        
        if BasicCommands.LoginName == "ZCAM" {
            z3Request.z3Soap = "ae_mode 2"
            request.dzoom()
        }
        
        if BasicCommands.LoginName == "TWIGA" {
            
            
        }
    }
        
        func autoExposureShutter (name:String) {
            
            if BasicCommands.LoginName == "IONODES" {
                HttpService.SOAPGet2 = "automaticexposure="
                HttpService.SOAPGet3 = "shutter"
                HttpService.SOAPGet4 = mainInstance.endstring
                
                http.postHttp()
                
            }
            
            if BasicCommands.LoginName == "ZCAM" {
                z3Request.z3Soap = "ae_mode 1"
                request.dzoom()
            }
            
            if BasicCommands.LoginName == "TWIGA" {
                
                
            }
        
        
    }
        
        func shutter (name:String , value:String) {
            
            if BasicCommands.LoginName == "IONODES" {
                HttpService.SOAPGet2 = "shutterspeed="
                HttpService.SOAPGet3 = value
                HttpService.SOAPGet4 = mainInstance.endstring
                
                http.postHttp()
                
            }
            
            if BasicCommands.LoginName == "ZCAM" {
                z3Request.z3Soap = "ae_mode 1"
                request.dzoom()
            }
            
            if BasicCommands.LoginName == "TWIGA" {
                
                
            }
            
            
        }
        
        func whiteBalance (name:String , value:String) {
    

    
            if BasicCommands.LoginName == "IONODES" {
                HttpService.SOAPGet2 = "whitebalance="
                HttpService.SOAPGet3 = value
                HttpService.SOAPGet4 = mainInstance.endstring
                
                http.postHttp()
                
            }
            
            if BasicCommands.LoginName == "ZCAM" {
                z3Request.z3Soap = value
                request.dzoom()
            }
            
            if BasicCommands.LoginName == "TWIGA" {
                
                
            }
    
    
        }
        
        func digitalZoom (name:String , value:String) {
            
            if BasicCommands.LoginName == "IONODES" {
                HttpService.SOAPGet2 = "digitalzoomenable"
                HttpService.SOAPGet3 = "=\(value)"
                HttpService.SOAPGet4 = mainInstance.endstring
                
                http.postHttp()
                
            }
            
            if BasicCommands.LoginName == "ZCAM" {
                z3Request.z3Soap = "dzoom_on"
                request.dzoom()
            }
            
            if BasicCommands.LoginName == "TWIGA" {
                
                
            }
            
            
            
    }
    func digitalZoomOff (name:String) {
        
        if BasicCommands.LoginName == "IONODES" {
            HttpService.SOAPGet2 = "digitalzoomenable"
            HttpService.SOAPGet3 = "=false"
            HttpService.SOAPGet4 = mainInstance.endstring
            
            http.postHttp()
            
        }
        
        if BasicCommands.LoginName == "ZCAM" {
            z3Request.z3Soap = "dzoom_off"
            request.dzoom()
        }
        
        if BasicCommands.LoginName == "TWIGA" {
            
            
        }
        
        
        
    }
    
    func wdrOn(name:String) {
        
        if BasicCommands.LoginName == "IONODES" {
            HttpService.SOAPGet2 = "widedynamicrange="
            HttpService.SOAPGet3 = "true"
            HttpService.SOAPGet4 = mainInstance.endstring
            http.postHttp()
            
        }
        
        if BasicCommands.LoginName == "ZCAM" {
            z3Request.z3Soap = "ae_mode 3"
            request.dzoom()
        }
        
        if BasicCommands.LoginName == "TWIGA" {
            
            
        }
    }
    func defogOn(name:String) {
        
        if BasicCommands.LoginName == "IONODES" {
            HttpService.SOAPGet2 = "defog="
            HttpService.SOAPGet3 = "true"
            HttpService.SOAPGet4 = mainInstance.endstring
            http.postHttp()
            
        }
        
        if BasicCommands.LoginName == "ZCAM" {
            z3Request.z3Soap = "ae_mode 3"
            request.dzoom()
        }
        
        if BasicCommands.LoginName == "TWIGA" {
            
            
        }
    }
    func defogOff(name:String) {
        
        if BasicCommands.LoginName == "IONODES" {
            HttpService.SOAPGet2 = "defog="
            HttpService.SOAPGet3 = "false"
            HttpService.SOAPGet4 = mainInstance.endstring
            http.postHttp()
            
        }
        
        if BasicCommands.LoginName == "ZCAM" {
            z3Request.z3Soap = "ae_mode 3"
            request.dzoom()
        }
        
        if BasicCommands.LoginName == "TWIGA" {
            
            
        }
    }
    
    func wdrOff(name:String) {
        
        if BasicCommands.LoginName == "IONODES" {
            HttpService.SOAPGet2 = "widedynamicrange="
            HttpService.SOAPGet3 = "false"
            HttpService.SOAPGet4 = mainInstance.endstring
            http.postHttp()
            
        }
        
        if BasicCommands.LoginName == "ZCAM" {
            z3Request.z3Soap = "ae_mode 3"
            request.dzoom()
        }
        
        if BasicCommands.LoginName == "TWIGA" {
            
            
        }
    }
        
        func setResolution (name:String , value:String) {
            
            if BasicCommands.LoginName == "IONODES" {
                HttpService.SOAPGet2 = value
                http.postConfig()
                
            }
            
            if BasicCommands.LoginName == "ZCAM" {
                z3Request.z3Soap = value
                request.dzoom()
            }
            
            if BasicCommands.LoginName == "TWIGA" {
                
                
            }
            
            
            
        }

}



