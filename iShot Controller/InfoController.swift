//
//  InfoController.swift
//  RtspClient
//
//  Created by Brian Hamilton on 12/22/18.
//

import UIKit

class InfoController: UIViewController {

    @IBOutlet weak var imageStab: UILabel!
    @IBOutlet weak var shutter: UILabel!
    @IBOutlet weak var profile: UILabel!
    @IBOutlet weak var moreInfo: UIButton!
    @IBOutlet weak var compRes: UILabel!
    @IBOutlet weak var cameraModel: UILabel!
    @IBOutlet weak var macAddress: UILabel!
    @IBOutlet var infoView: UIView!
    @IBOutlet weak var whiteBalance: UILabel!
    @IBOutlet weak var wdrLabel: UILabel!
    @IBOutlet weak var dZoomMode: UILabel!
    @IBOutlet weak var currentZoom: UILabel!
    @IBOutlet weak var bitRate: UILabel!
    @IBOutlet weak var exposure: UILabel!
    @IBOutlet weak var modelNumber: UILabel!
    @IBOutlet weak var rtspLabel: UILabel!
    @IBOutlet weak var ipLabel: UILabel!
    @IBOutlet weak var resolutionLabel: UILabel!
    @IBOutlet weak var portLabel: UILabel!
    let camera = Camera()
    let z3 = zCamera()
    let sensor = Sensor()
  
    @IBOutlet weak var mirrorMode: UILabel!
    @IBOutlet weak var focusLevel: UILabel!
    @IBOutlet weak var afLabel: UILabel!
  
    
    @IBOutlet weak var defog: UILabel!
    
  
        
  
   
    override func viewDidLoad() {
        super.viewDidLoad()
    
     
        
        
       
    }
    
    
 
    
    


      

    func setLabels(string:String) {
      
        
     self.camera.discoverIP(ip: string)
        self.sensor.GetBlockSensorInput(ip: string)
             DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
             
              
             //  self.cameraModel.text = "Serial#: \(String(describing: self.camera.serialNum))"
                self.ipLabel.text = "IP: \(Login.ip)"
                self.rtspLabel.text = "Board: \(self.camera.boardModel)"
                self.resolutionLabel.text = "Port: \(String(describing: self.camera.portNumber))"
                self.portLabel.text = "Firmware:  \(String(describing: self.camera.firmWare))"
                self.macAddress.text = "MAC: \(String(describing: self.camera.macAddress))"
                self.modelNumber.text =  "Camera:  \(String(describing: self.camera.videoInput.CameraModelNumber))"
              
                if let text = self.camera.encoder.resolution {
                     self.compRes.text =  "Resolution:  \(text)"
                }
                self.cameraModel.frame = CGRect(x:5, y:69, width: 400, height: 20)
                self.ipLabel.frame = CGRect(x:5, y:115, width: 400, height: 20)
                self.resolutionLabel.frame = CGRect(x:5, y:161, width: 400, height: 20)
                self.rtspLabel.frame = CGRect(x:5, y:0, width: 400, height: 20)
                self.portLabel.frame = CGRect(x:5, y:92, width: 400, height: 20)
                  self.modelNumber.frame = CGRect(x:5, y:23, width: 400, height: 20)
                  self.macAddress.frame = CGRect(x:5, y:46, width: 400, height: 20)
                  self.compRes.frame = CGRect(x:5, y:138, width: 400, height: 20)
                    self.imageStab.frame = CGRect(x:5, y:317, width: 400, height: 20)
                    self.imageStab.text =  "Stablization:  \(String(describing: self.sensor.imagestabilization))"
                    self.profile.frame = CGRect(x:5, y:340, width: 400, height: 20)
                    self.profile.text =  "Encoding Profile:  \(String(describing: self.camera.encoder.profile))"
                    self.shutter.frame =  CGRect(x:5, y:386, width: 400, height: 20)
                    self.shutter.text =  "Shutter:  \(String(describing: self.sensor.shutterspeed))"
                    self.exposure.frame =  CGRect(x:5, y:271, width: 400, height: 20)
                    self.exposure.text = "AE Mode:  \(String(describing: self.sensor.automaticexposure))"
                    self.bitRate.frame =  CGRect(x:5, y:363, width: 400, height: 20)
                    self.bitRate.text = "Bitrate:  \(String(describing: self.camera.encoder.bitrate))"
                    self.currentZoom.frame = CGRect(x:5, y:225, width: 400, height: 20)
                    self.currentZoom.text = "Current Zoom:  \(String(describing: self.sensor.currentzoomlevel))"
                    self.afLabel.frame = CGRect(x:5, y:294, width: 400, height: 20)
                    self.afLabel.text = "Autofocus:  \(String(describing: self.sensor.autofocus))"
                    self.focusLevel.frame = CGRect(x:5, y:248, width: 400, height: 20)
                    self.focusLevel.text = "Current Focus:  \(String(describing: self.sensor.currentfocuslevel))"
                    self.whiteBalance.frame = CGRect(x:5, y:409, width: 400, height: 20)
                    self.whiteBalance.text = "White Balance:  \(String(describing: self.sensor.whitebalance))"
                    self.defog.frame = CGRect(x:5, y:431, width: 400, height: 20)
                    self.defog.text = "Defog Mode:  \(String(describing: self.sensor.defog))"
                    self.wdrLabel.frame = CGRect(x:5, y:454, width: 400, height: 20)
                    self.wdrLabel.text = "WDR Mode:  \(String(describing: self.sensor.widedynamicrange))"
                    self.mirrorMode.frame = CGRect(x:5, y:477, width: 400, height: 20)
                    self.mirrorMode.text = "Mirror Mode:  \(String(describing: self.sensor.mirror))"
                    self.dZoomMode.frame = CGRect(x:5, y:500, width: 400, height: 20)
                    self.dZoomMode.text = "Digital Zoom:  \(String(describing: self.sensor.digitalzoomenable))"
       }
    }
    
    
    
    
    
    
}
