//
//  BottomController.swift
//  iShot
//
//  Created by Brian Hamilton on 1/7/19.
//  Copyright © 2019 Brian Hamilton. All rights reserved.
//

import UIKit

class BottomController: UIViewController {
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var resolutionbutton: UIButton!
    @IBOutlet weak var moreFeatures: UIButton!
    let main = MainVC()
    let camera = Camera()
    
    @IBOutlet weak var zoomTele: UIButton!
    @IBOutlet weak var wideZoom: UIButton!
    @IBOutlet weak var focusNear: UIButton!
    @IBOutlet weak var focusWide: UIButton!
    @IBOutlet weak var closeIris: UIButton!
    @IBOutlet weak var whiteBalanceMode: UIButton!
    @IBOutlet weak var icrMode: UIButton!
    @IBOutlet weak var mirrorButton: UIButton!
    @IBOutlet weak var secondControl: UIView!
    @IBOutlet weak var openIris: UIButton!
    @IBOutlet weak var digitalZoom: UIButton!
    
    @IBOutlet weak var checkValues: UIButton!
    @IBOutlet weak var secondSet: UIView!
    
    @IBOutlet weak var showEncoder: UIButton!
    @IBOutlet weak var autoExpo: UIButton!
    @IBOutlet weak var hideSecondController: UIButton!
    @IBOutlet weak var autoFocus: UIButton!
    @IBOutlet weak var imageStabilzation: UIButton!
    @IBOutlet weak var defog: UIButton!
    @IBOutlet weak var wideDynamic: UIButton!
    let onState =  #colorLiteral(red: 0.9757569432, green: 0, blue: 0.1222533509, alpha: 0.8677376761)
    
    let offState = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 0.8896621919)
    let control = BasicCommands()
    var aeToggle = 0
    var afToggle = 0
    var basicToggle = 0
    var secondToggle = 0
    var icrToggle = 0
    var mirrorToggle = 0
    var wbToggle = 0
    var stabToggle = 0
    var  defogToggle = 0
    var wdrToggle = 0
    var zoomTeleToggle = 0
    var zoomWideToggle = 0
    var showToggle = 0
    var dzoomToggle = 0
    
    override func viewWillLayoutSubviews() {
        showEncoder.mediumButton()
        moreFeatures.mediumButton()
        zoomTele.bigButton()
        wideZoom.bigButton()
        focusNear.bigButton()
        focusWide.bigButton()
        openIris.bigButton()
        closeIris.bigButton()
        defog.sideButton()
        digitalZoom.sideButton()
        whiteBalanceMode.sideButton()
        autoExpo.sideButton()
        autoFocus.sideButton()
        icrMode.sideButton()
        wideDynamic.sideButton()
        mirrorButton.sideButton()
        imageStabilzation.sideButton()
        defog.isHidden = true
        whiteBalanceMode.isHidden = true
        autoExpo.isHidden = true
        icrMode.isHidden = true
        autoFocus.isHidden = true
        mirrorButton.isHidden = true
        imageStabilzation.isHidden = true
        wideDynamic.isHidden = true
        digitalZoom.isHidden = true
        checkValues.layer.cornerRadius = 3
        checkValues.backgroundColor = #colorLiteral(red: 0.3156842589, green: 0.6092572212, blue: 0.9345738292, alpha: 1)
        secondSet.addSubview(digitalZoom)
        secondSet.addSubview(imageStabilzation)
        secondSet.addSubview(autoFocus)
        secondSet.addSubview(autoExpo)
        secondSet.addSubview(icrMode)
        secondSet.addSubview(mirrorButton)
        secondSet.addSubview(defog)
        secondSet.addSubview(wideDynamic)
        secondSet.addSubview(whiteBalanceMode)
        mainView.addSubview(closeIris)
        mainView.addSubview(openIris)
        mainView.addSubview(zoomTele)
        mainView.addSubview(wideZoom)
        mainView.addSubview(focusNear)
        mainView.addSubview(focusWide)
        mainView.addSubview(checkValues)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        checkValues.addTarget(self, action: #selector(self.on(_:)), for: .touchDown)
        checkValues.addTarget(self, action: #selector(self.off(_:)), for: .touchUpInside)
        focusWide.addTarget(self, action: #selector(focusFar(_:)), for: .touchUpInside)
        focusNear.addTarget(self, action: #selector(focusNear(_:)), for: .touchUpInside)
        focusWide.addTarget(self, action: #selector(focusStop(_:)), for: .touchDown)
        focusNear.addTarget(self, action: #selector(focusStop(_:)), for: .touchDown)
        camera.discoverIP(ip: Login.ip)
        
        hideThird()
    }
    @IBAction func on(_ sender: UIButton?) -> Void {
        
        
        
        defog.setTitle(self.camera.sensor.defog, for: .normal)
        wideDynamic.setTitle(self.camera.sensor.defog, for:.normal)
        digitalZoom.setTitle(camera.sensor.digitalzoomenable, for: .normal)
        autoExpo.setTitle(camera.sensor.automaticexposure, for: .normal)
        imageStabilzation.setTitle(camera.sensor.imagestabilization, for: .normal)
        autoFocus.setTitle(camera.sensor.autofocus, for: .normal)
        icrMode.setTitle(camera.sensor.autoicr, for: .normal)
        whiteBalanceMode.setTitle(camera.sensor.whitebalance, for: .normal)
        mirrorButton.setTitle(camera.sensor.mirror, for: .normal)
        zoomTele.setTitle(camera.sensor.currentzoomlevel, for: .normal)
        wideZoom.setTitle(camera.sensor.currentzoomlevel, for: .normal)
        openIris.setTitle(camera.sensor.currentirislevel, for: .normal)
        closeIris.setTitle(camera.sensor.currentirislevel, for: .normal)
        focusNear.setTitle(camera.sensor.currentfocuslevel, for: .normal)
        focusWide.setTitle(camera.sensor.currentfocuslevel, for: .normal)
        
    }
    
    @IBAction func focusStop(_ sender: UIButton?) -> Void {
        
        
    }
    @IBAction func focusFar(_ sender: UIButton?) -> Void {
        control.focusFar(name: BasicCommands.LoginName, value: 0.0 )   }
    @IBAction func focusNear(_ sender: UIButton?) -> Void {
        control.focusNear(name: BasicCommands.LoginName, value: 0.0 )   }
    
    
    @IBAction func off(_ sender: UIButton?) -> Void {
        
        
        defog.setTitle("Defog", for: .normal)
        wideDynamic.setTitle("WDR", for:.normal)
        digitalZoom.setTitle("Digital Zoom", for: .normal)
        autoExpo.setTitle("AutoExposure", for: .normal)
        imageStabilzation.setTitle("Stabilzation", for: .normal)
        autoFocus.setTitle("AutoFocus", for: .normal)
        icrMode.setTitle("ICR", for: .normal)
        whiteBalanceMode.setTitle("White Balance", for: .normal)
        mirrorButton.setTitle("Mirror", for: .normal)
        zoomTele.setTitle("Tele", for: .normal)
        wideZoom.setTitle("Wide", for: .normal)
        openIris.setTitle("Open", for: .normal)
        closeIris.setTitle("Close", for: .normal)
        focusNear.setTitle("Near", for: .normal)
        focusWide.setTitle("Far", for: .normal)
        
        
        
        
        
        
    }
    @IBAction func checkState(_ sender: Any) {
        camera.discoverIP(ip: Login.ip)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.on(self.checkValues)
            self.off(self.checkValues)
            
        }
        
    }
    
    
    
    @IBAction func showEncoderAction(_ sender: Any) {
        
        hideFirst()
        hideSecond()
        resolutionbutton.setTitle(self.camera.encoder.resolution, for: .normal)
        
    }
    
    
    @IBAction func dzoomEnable(_ sender: Any) {
        
        if dzoomToggle == 0 {
            let value = "true"
            control.digitalZoom(name: BasicCommands.LoginName , value: value)
            digitalZoom.setTitle("Enabled", for: .normal)
            dzoomToggle = 1
        } else {
            if dzoomToggle == 1 {
                let value = "false"
                digitalZoom.setTitle("Disabled", for: .normal)
                control.digitalZoomOff(name: BasicCommands.LoginName)
                dzoomToggle = 0
                
            }
            
            
        }
    }
    
    
    @IBAction func setResolution(_ sender: Any) {
    }
    
    
    
    
    
    
    @IBAction func showMore(_ sender: Any) {
        
        if MainVC.menuToggle == 0 {
            defog.isHidden = false
            whiteBalanceMode.isHidden = false
            autoExpo.isHidden = false
            icrMode.isHidden = false
            autoFocus.isHidden = false
            mirrorButton.isHidden = false
            imageStabilzation.isHidden = false
            wideDynamic.isHidden = false
            digitalZoom.isHidden = false
            MainVC.menuToggle = 1
            
            
            
            
            
            wideZoom.isHidden = true
            focusNear.isHidden = true
            zoomTele.isHidden = true
            focusWide.isHidden = true
            openIris.isHidden = true
            closeIris.isHidden = true
            secondSet.isHidden = false
            secondSet.frame = CGRect(x: 95, y: -10, width: 513, height: 156)
            
            moreFeatures.setTitle("Back", for: .normal)
            
            
        } else {
            
            if MainVC.menuToggle == 1 {
                moreFeatures.setTitle("More", for: .normal)
                digitalZoom.isHidden = true
                defog.isHidden = true
                whiteBalanceMode.isHidden = true
                autoExpo.isHidden = true
                icrMode.isHidden = true
                autoFocus.isHidden = true
                wideZoom.isHidden = false
                focusNear.isHidden = false
                zoomTele.isHidden = false
                focusWide.isHidden = false
                openIris.isHidden = false
                closeIris.isHidden = false
                mirrorButton.isHidden = true
                imageStabilzation.isHidden = true
                wideDynamic.isHidden = true
                secondSet.isHidden = true
                MainVC.menuToggle = 0
                
                
            }
            
        }
    }
    
    
    @IBAction func defogAction(_ sender: UIButton) {
        defog.cycle()
        switch defogToggle {
        case 0:
            defog.setTitle("Defog On", for: .normal)
            control.defogOn(name: BasicCommands.LoginName)
            defog.backgroundColor =  onState
            
            defogToggle = 1
        case 1:
            defog.setTitle("Defog Off", for: .normal)
            control.defogOff(name: BasicCommands.LoginName)
            defog.backgroundColor =  onState
            defogToggle = 0
        default:break
        }
        
        
        
    }
    
    
    @IBAction func wdrAction(_ sender: Any) {
        wideDynamic.cycle()
        switch wdrToggle {
        case 0:
            wideDynamic.setTitle("WDR On", for: .normal)
            control.wdrOn(name: BasicCommands.LoginName)
            wideDynamic.cycle()
            wideDynamic.backgroundColor =  onState
            wdrToggle = 1
        case 1:
            wideDynamic.setTitle("WDR Off", for: .normal)
            control.wdrOff(name: BasicCommands.LoginName)
            wideDynamic.backgroundColor =  onState
            wdrToggle = 0
        default:break
        }
        
        
        
    }
    
    
    @IBAction func stabAction(_ sender: Any) {
        imageStabilzation.cycle()
        switch stabToggle {
        case 0:
            control.imageStabOn(name: BasicCommands.LoginName)
            imageStabilzation.setTitle("Stab On", for: .normal)
            imageStabilzation.backgroundColor =  onState
            stabToggle = 1
        case 1:
            control.imageStabOff(name: BasicCommands.LoginName)
            imageStabilzation.setTitle("Stab Off", for: .normal)
            imageStabilzation.backgroundColor =  onState
            stabToggle = 0
        default:break
        }
        
        
        
    }
    
    
    
    
    @IBAction func mirrorFlipper(_ sender: Any) {
        
        mirrorButton.cycle()
        switch mirrorToggle {
        case 0:
            control.mirrorHorizontal(name: BasicCommands.LoginName )
            mirrorButton.cycle()
            mirrorButton.setTitle("Horizontal", for: .normal)
            mirrorButton.backgroundColor =  onState
            mirrorToggle = 1
        case 1:
            control.eFlipOn(name: BasicCommands.LoginName )
            mirrorButton.cycle()
            mirrorButton.setTitle("Vertical", for: .normal)
            mirrorButton.backgroundColor =  onState
            mirrorToggle = 2
        case 2:
            control.mirrorHorizontalOff(name: BasicCommands.LoginName)
            mirrorButton.cycle()
            mirrorButton.setTitle("Both", for: .normal)
            mirrorButton.backgroundColor = onState
            mirrorToggle = 0
        default: break
        }
    }
    @IBAction func icrFlipper(_ sender: Any) {
        icrMode.cycle()
        switch icrToggle {
            
        case 0:
            icrMode.cycle()
            control.icrOn(name: BasicCommands.LoginName)
            icrMode.setTitle("ICR On", for: .normal)
            icrMode.backgroundColor = onState
            icrToggle = 1
        case 1:
            icrMode.cycle()
            control.icrOff(name: BasicCommands.LoginName)
            icrMode.backgroundColor =  onState
            icrMode.setTitle("ICR Off", for: .normal)
            icrToggle = 0
        default:break
        }
        
        
    }
    
    
    
    
    
    
    
    @IBAction func whiteBalanceSelect(_ sender: Any) {
        whiteBalanceMode.cycle()
        var value = ""
        
        switch wbToggle {
        case 0:
            whiteBalanceMode.cycle()
            value = "auto"
            control.whiteBalance(name: BasicCommands.LoginName, value: value)
            wbToggle = 1
            whiteBalanceMode.setTitle("Auto", for: .normal)
            whiteBalanceMode.backgroundColor = onState
        case 1:
            whiteBalanceMode.cycle()
            value = "indoor"
            control.whiteBalance(name: BasicCommands.LoginName, value: value)
            whiteBalanceMode.setTitle("Indoor", for: .normal)
            whiteBalanceMode.backgroundColor =  onState
            wbToggle = 2
            
        case 2:
            whiteBalanceMode.cycle()
            value = "outdoor"
            control.whiteBalance(name: BasicCommands.LoginName, value: value)
            whiteBalanceMode.setTitle("Outdoor", for: .normal)
            whiteBalanceMode.backgroundColor =  onState
            wbToggle = 3
        case 3:
            whiteBalanceMode.cycle()
            value = "sodiumlampauto"
            whiteBalanceMode.setTitle("Sodium Auto", for: .normal)
            control.whiteBalance(name: BasicCommands.LoginName, value: value)
            whiteBalanceMode.backgroundColor = onState
            wbToggle = 4
            
        case 4:
            whiteBalanceMode.cycle()
            value = "sodiumlamp"
            whiteBalanceMode.setTitle("Sodium", for: .normal)
            control.whiteBalance(name: BasicCommands.LoginName, value: value)
            whiteBalanceMode.backgroundColor =  onState
            wbToggle = 0
        default: break
        }
        
        
        
    }
    
    
    
    
    
    var focusToggleNear = 0
    var focusToggleFar = 0
    @IBAction func focusCommand(_ sender: UIButton) {
        
        if focusToggleNear == 0 {
            focusNear.cycle()
            let value = 20.0
            focusNear.backgroundColor = onState
            control.focusNear(name: BasicCommands.LoginName , value: Float(value))
            focusToggleNear = 1
            
        } else {
            if focusToggleNear == 1 {
                let http = HttpService()
                http.postFocusStop()
                focusToggleNear = 0
            }
            
        }
    }
    
    
    
    
    
    @IBAction func zoomWideAction(_ sender: Any) {
        let value = 1.0
        wideZoom.cycle()
        if zoomWideToggle == 0 {
            wideZoom.backgroundColor = onState
            control.zoomOut(name: BasicCommands.LoginName , value: Float(value))
            zoomWideToggle = 1
        } else {
            if zoomWideToggle == 1 {
                wideZoom.backgroundColor = onState
                control.zoomStop(name: BasicCommands.LoginName , value: Float(value))
                zoomWideToggle = 0
            }
        }
    }
    
    @IBAction func closeIrisAction(_ sender: Any) {
        closeIris.cycle()
        let value = 1.0
        closeIris.backgroundColor = onState
        control.irisClose(name: BasicCommands.LoginName , value: Float(value))
        
        
    }
    
    @IBAction func afAction(_ sender: Any) {
        autoFocus.cycle()
        if afToggle == 0 {
            control.autoFocusOn(name: BasicCommands.LoginName)
            autoFocus.setTitle("Auto", for: .normal)
            autoFocus.backgroundColor = onState
            afToggle = 1
        } else  {
            
            if afToggle == 1 {
                autoFocus.setTitle("Manual", for: .normal)
                control.autoFocusOn(name: BasicCommands.LoginName)
                autoFocus.backgroundColor = offState
                afToggle = 0
                
            }
        }
    }
    @IBAction func aeAction(_ sender: Any) {
        autoExpo.cycle()
        if aeToggle == 0 {
            control.autoExporsureOn(name: BasicCommands.LoginName)
            autoExpo.setTitle("Auto", for: .normal)
            autoExpo.backgroundColor = onState
            aeToggle = 1
        } else {
            
            if aeToggle == 1 {
                autoExpo.backgroundColor = onState
                
                control.autoExporsureOff(name: BasicCommands.LoginName)
                autoExpo.setTitle("Manual", for: .normal)
                aeToggle = 0
            }
        }
    }
    
    @IBAction func wideFocusAct(_ sender: Any) {
        
        if focusToggleFar == 0 {
            
            focusWide.cycle()
            let value = 20
            focusWide.backgroundColor = onState
            control.focusFar(name: BasicCommands.LoginName , value: Float(value))
            focusToggleFar = 1
        } else {
            if focusToggleFar == 1 {
                
                let http = HttpService()
                http.postFocusStop()
                focusToggleFar = 0
                
            }
        }
    }
    
    @IBAction func zoomTeleAction(_ sender: Any) {
        let value = 1.0
        zoomTele.cycle()
        if zoomTeleToggle == 0 {
            zoomTele.backgroundColor = onState
            control.zoom(name: BasicCommands.LoginName , value: Float(value))
            zoomTeleToggle = 1
            
        } else {
            if zoomTeleToggle == 1 {
                control.zoomStop(name: BasicCommands.LoginName , value: Float(value))
                zoomTeleToggle = 0
                zoomTele.backgroundColor = onState
            }
        }
    }
    
    @IBAction func openIrisAction(_ sender: Any) {
        openIris.cycle()
        let value = 1.0
        control.irisOpen(name: BasicCommands.LoginName , value: Float(value))
        openIris.backgroundColor = onState
    }
    
    
    func showFirst () {
        wideZoom.isHidden = false
        focusNear.isHidden = false
        zoomTele.isHidden = false
        focusWide.isHidden = false
        openIris.isHidden = false
        closeIris.isHidden = false
        
    }
    
    func hideFirst () {
        
        wideZoom.isHidden = true
        focusNear.isHidden = true
        zoomTele.isHidden = true
        focusWide.isHidden = true
        openIris.isHidden = true
        closeIris.isHidden = true
        
    }
    
    
    
    
    
    
    
    func showSecond () {
        
        defog.isHidden = false
        whiteBalanceMode.isHidden = false
        autoExpo.isHidden = false
        icrMode.isHidden = false
        autoFocus.isHidden = false
        mirrorButton.isHidden = false
        imageStabilzation.isHidden = false
        wideDynamic.isHidden = false
        digitalZoom.isHidden = false
        
    }
    
    
    func  hideSecond() {
        
        defog.isHidden = true
        whiteBalanceMode.isHidden = true
        autoExpo.isHidden = true
        icrMode.isHidden = true
        autoFocus.isHidden = true
        mirrorButton.isHidden = true
        imageStabilzation.isHidden = true
        wideDynamic.isHidden = true
        digitalZoom.isHidden = true
        
        
    }
    
    func  hideThird() {
        
        resolutionbutton.isHidden = true
        
    }
    
    
    
}
