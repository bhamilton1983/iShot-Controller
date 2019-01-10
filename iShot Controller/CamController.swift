//
//  CamController.swift
//  RtspClient
//
//  Created by Brian Hamilton on 12/21/18.
//

import UIKit

class CamController: UIViewController {


    @IBOutlet weak var ionodesControlView: UIView!
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
    @IBOutlet weak var basicControlView: UIView!
    @IBOutlet weak var hideBasic: UIButton!
    @IBOutlet weak var autoExpo: UIButton!
    @IBOutlet weak var hideSecondController: UIButton!
    @IBOutlet weak var autoFocus: UIButton!
    @IBOutlet weak var imageStabilzation: UIButton!
    @IBOutlet weak var defog: UIButton!
    @IBOutlet weak var wideDynamic: UIButton!
    
  
    
    
    
    
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
  
  
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setIONodes()
        setMain()
       
       
        
    }
    
  func  setMain () {
    
   
     ionodesControlView.addSubview(hideSecondController)
     secondControl.layer.cornerRadius = 5
     secondControl.layer.borderWidth = 0
     secondControl.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
     ionodesControlView.layer.borderWidth = 0
     ionodesControlView.layer.cornerRadius = 5
     ionodesControlView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
     ionodesControlView.layer.borderColor = #colorLiteral(red: 0.01767810062, green: 0.3144158125, blue: 0.9819859862, alpha: 1)
     secondControl.layer.borderColor = #colorLiteral(red: 0.01767810062, green: 0.3144158125, blue: 0.9819859862, alpha: 1)
     basicControlView.addSubview(zoomTele)
     basicControlView.addSubview(wideZoom)
     basicControlView.addSubview(focusWide)
     basicControlView.addSubview(focusNear)
     basicControlView.addSubview(openIris)
     basicControlView.addSubview(closeIris)
     basicControlView.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
     basicControlView.layer.cornerRadius = 10
     basicControlView.layer.borderWidth = 0
     basicControlView.layer.borderColor = #colorLiteral(red: 0.01767810062, green: 0.3144158125, blue: 0.9819859862, alpha: 1)
     ionodesControlView.addSubview(hideBasic)
    
    
    }
    
    
  func setIONodes () {
    
   
         whiteBalanceMode.sideButton()
         imageStabilzation.sideButton()
         defog.sideButton()
         wideDynamic.sideButton()
         icrMode.sideButton()
         mirrorButton.sideButton()
        //BigButton
         wideZoom.bigButton()
         zoomTele.bigButton()
        // med button
            focusWide.mediumButton()
            focusNear.mediumButton()
            openIris.mediumButton()
            closeIris.mediumButton()
           
      hideSecondController.isHidden = true
      secondControl.addSubview(mirrorButton)
      secondControl.addSubview(icrMode)
      secondControl.addSubview(whiteBalanceMode)
      secondControl.addSubview(imageStabilzation)
      secondControl.addSubview(defog)
      secondControl.addSubview(wideDynamic)
      autoFocus.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
      autoExpo.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
    
    
    
    
    
  
    
    
    }
    
    
    @IBAction func defogAction(_ sender: Any) {
        switch defogToggle {
        case 0:
             defog.setTitle("Defog On", for: .normal)
             control.defogOn(name: BasicCommands.LoginName)
             defog.cycle()
             defogToggle = 1
        case 1:
              defog.setTitle("Defog Off", for: .normal)
              control.defogOff(name: BasicCommands.LoginName)
              defogToggle = 0
        default:break
        }
        
        
    
    }
    
    
    @IBAction func wdrAction(_ sender: Any) {
        
        switch wdrToggle {
        case 0:
            wideDynamic.setTitle("WDR On", for: .normal)
            control.wdrOn(name: BasicCommands.LoginName)
            wideDynamic.cycle()
            wdrToggle = 1
        case 1:
              wideDynamic.setTitle("WDR Off", for: .normal)
             control.wdrOff(name: BasicCommands.LoginName)
             wdrToggle = 0
        default:break
        }
        
        
        
    }
    
    
    @IBAction func stabAction(_ sender: Any) {
        
        switch stabToggle {
        case 0:
        control.imageStabOn(name: BasicCommands.LoginName)
         imageStabilzation.setTitle("Stab On", for: .normal)
        imageStabilzation.cycle()
        stabToggle = 1
        case 1:
            control.imageStabOff(name: BasicCommands.LoginName)
          imageStabilzation.setTitle("Stab Off", for: .normal)
              stabToggle = 0
        default:break
        }
     
        
        
    }
    
    
    
    
    @IBAction func mirrorFlipper(_ sender: Any) {
        
        
        switch mirrorToggle {
        case 0:
        control.mirrorHorizontal(name: BasicCommands.LoginName )
        mirrorButton.cycle()
            mirrorButton.setTitle("Horizontal", for: .normal)
            mirrorToggle = 1
        case 1:
         control.eFlipOn(name: BasicCommands.LoginName )
          mirrorButton.cycle()
          mirrorButton.setTitle("Vertical", for: .normal)
            mirrorToggle = 2
        case 2:
            control.mirrorHorizontalOff(name: BasicCommands.LoginName)
             mirrorButton.cycle()
            mirrorButton.setTitle("Both", for: .normal)
            mirrorToggle = 0
        default: break
    }
    }
    @IBAction func icrFlipper(_ sender: Any) {
        
        switch icrToggle {
      
        case 0:
            icrMode.cycle()
            control.icrOn(name: BasicCommands.LoginName)
            icrMode.setTitle("ICR On", for: .normal)
            icrToggle = 1
        case 1:
             icrMode.cycle()
             control.icrOff(name: BasicCommands.LoginName)
             icrMode.setTitle("ICR Off", for: .normal)
             icrToggle = 0
        default:break
        }
        
        
    }
    @IBAction func whiteBalanceSelect(_ sender: Any) {
        
       var value = ""
        
        switch wbToggle {
        case 0:
            whiteBalanceMode.cycle()
            value = "auto"
            control.whiteBalance(name: BasicCommands.LoginName, value: value)
            wbToggle = 1
            whiteBalanceMode.setTitle("Auto", for: .normal)
        case 1:
            whiteBalanceMode.cycle()
            value = "indoor"
            control.whiteBalance(name: BasicCommands.LoginName, value: value)
            whiteBalanceMode.setTitle("Indoor", for: .normal)
            wbToggle = 2
            
        case 2:
            whiteBalanceMode.cycle()
            value = "outdoor"
             control.whiteBalance(name: BasicCommands.LoginName, value: value)
             whiteBalanceMode.setTitle("Outdoor", for: .normal)
             wbToggle = 3
        case 3:
            whiteBalanceMode.cycle()
            value = "sodiumlampauto"
             whiteBalanceMode.setTitle("Sodium Auto", for: .normal)
            control.whiteBalance(name: BasicCommands.LoginName, value: value)
            wbToggle = 4
            
        case 4:
            whiteBalanceMode.cycle()
            value = "sodiumlamp"
            whiteBalanceMode.setTitle("Sodium", for: .normal)
            control.whiteBalance(name: BasicCommands.LoginName, value: value)
            wbToggle = 0
        default: break
        }
        
        
        
    }
    
    
    
    
    
    
    @IBAction func focusCommand(_ sender: Any) {
      
        focusNear.cycle()
        let value = 1.0
        control.focusNear(name: BasicCommands.LoginName , value: Float(value))
      
    }
    
    

    
    
    @IBAction func zoomWideAction(_ sender: Any) {
         let value = 1.0
        wideZoom.cycle()
        if zoomWideToggle == 0 {
       
         control.zoomOut(name: BasicCommands.LoginName , value: Float(value))
         zoomWideToggle = 1
        } else {
            if zoomWideToggle == 1 {
            control.zoomStop(name: BasicCommands.LoginName , value: Float(value))
                zoomWideToggle = 0
        }
        }
    }
    
    @IBAction func closeIrisAction(_ sender: Any) {
      closeIris.cycle()
        let value = 1.0
        control.irisClose(name: BasicCommands.LoginName , value: Float(value))
        
        
    }
    
    @IBAction func afAction(_ sender: Any) {
       autoFocus.cycle()
        if afToggle == 0 {
            control.autoFocusOn(name: BasicCommands.LoginName)
            autoFocus.setTitle("Auto", for: .normal)
            afToggle = 1
        } else  {
            
            if afToggle == 1 {
                autoFocus.setTitle("Manual", for: .normal)
                control.autoFocusOn(name: BasicCommands.LoginName)
                afToggle = 0
        
          }
        }
    }
    @IBAction func aeAction(_ sender: Any) {
        autoExpo.cycle()
        if aeToggle == 0 {
         control.autoExporsureOn(name: BasicCommands.LoginName)
            autoExpo.setTitle("Auto", for: .normal)
           aeToggle = 1
        } else {
            
        if aeToggle == 1 {
            control.autoExporsureOff(name: BasicCommands.LoginName)
           autoExpo.setTitle("Manual", for: .normal)
           aeToggle = 0
        }
      }
    }
    
    @IBAction func wideFocusAct(_ sender: Any) {
        focusWide.cycle()
        let value = 1.0
       
        control.focusFar(name: BasicCommands.LoginName , value: Float(value))
    }
    @IBAction func zoomTeleAction(_ sender: Any) {
        let value = 1.0
     //  zoomTele.cycle()
        if zoomTeleToggle == 0 {
            control.zoom(name: BasicCommands.LoginName , value: Float(value))
            zoomTeleToggle = 1
            
        } else {
            if zoomTeleToggle == 1 {
              zoomTele.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
                control.zoomStop(name: BasicCommands.LoginName , value: Float(value))
                zoomTeleToggle = 0
            }
        }
    }
    
    @IBAction func openIrisAction(_ sender: Any) {
        openIris.cycle()
        let value = 1.0
        control.irisOpen(name: BasicCommands.LoginName , value: Float(value))
    }
    
    
    
    
 
}
extension UIView{
    func cycle () {
        
 
            self.layer.backgroundColor  =  #colorLiteral(red: 0.9757569432, green: 0, blue: 0.1222533509, alpha: 0.8677376761)
     
        self.alpha = 0.3
        UIView.animate(withDuration: 0.6, delay: 0.1, options: [.curveEaseIn], animations: {self.alpha = 1.0}, completion: nil)
        self.layer.backgroundColor =  #colorLiteral(red: 0.9757569432, green: 0, blue: 0.1222533509, alpha: 0.8677376761)
      
    }
}
extension UIButton {
    func sideButton () {
        self.layer.backgroundColor =  #colorLiteral(red: 0.9757569432, green: 0, blue: 0.1222533509, alpha: 0.8677376761)
        self.layer.cornerRadius = 3
        self.layer.borderWidth = 0
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        
       // self.frame =  CGRect(x:100, y:100, width:900, height: 600)
        
        
      
    }
}
extension UIButton {
    func bigButton () {
        self.layer.backgroundColor =  #colorLiteral(red: 0.9757569432, green: 0, blue: 0.1222533509, alpha: 0.8677376761)
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 0
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        
        
    }
}
extension UIButton {
    func mediumButton () {
        self.layer.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 0
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        
        
    }
}
extension UIButton {
    func menuButton () {
        self.layer.backgroundColor = #colorLiteral(red: 0.9746851325, green: 0.9641042352, blue: 0.9223961234, alpha: 0)
        self.layer.cornerRadius = 30
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        
        
    }
}


extension UIView{
    func blink() {
        
        self.alpha = 0.2
        UIView.animate(withDuration: 0.4, delay: 0.1, options: [.curveLinear], animations: {self.alpha = 1.0}, completion: nil)
    }
}


extension UIView{
    func blink1() {
        
        self.alpha = 1
        UIView.animate(withDuration: 1.4, delay: 0.1, options: [.curveLinear, .autoreverse], animations: {self.alpha = 1.0}, completion: nil)
    }
}
