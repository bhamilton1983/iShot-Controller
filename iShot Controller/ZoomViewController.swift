

//  ZoomViewController.swift
//  Created by Brian Hamilton on 5/30/18.
//  Updated 8/8/18  SDE


import UIKit


class ZoomViewController: UIViewController {
    static var z3textString = String()
    static  var segmentChoice = String()
    static  var currentZoomLevel = String()
    var zoomMultiplier = Int()
    var camera = Camera()
    let http = HttpService()
    var segmentChoice:Int = 0
    var textZoom = String()

    @IBOutlet var mainZoomView: UIView!



    
    
    @IBOutlet weak var z3Label: UILabel!
    
    // 8/8/18 SDE
    static var PrevZoomTime : Date = Date() // keep time of previous ethernet transmission
    
    @IBOutlet weak var angleLabel: UILabel!
    @IBOutlet weak var zoomLabel: UILabel!
    @IBOutlet weak var zoomSliderLevel: UISlider!
    @IBAction func ZoomSlider(_ sender: UISlider) {
        
            DispatchQueue.main.async(qos: .userInteractive) {
     
         
         
            let zoomLevel = Int(sender.value)
            ZoomViewController.currentZoomLevel = String(zoomLevel) // Update sting in class
            let zoomtext = zoomLevel * self.zoomMultiplier / 100
            let zoomDouble = Double(zoomtext)
            let angleText = 63.7 / zoomDouble
        
        //  See how much time was elapsed 8/8/18 SDE
        // We don't want to overwhelm the camera with zoom commands.
        // Must be longer than XX seconds or won't send  command.
        //  let zoomtext = zoomLevel *
        
            let secondsSinceLastSentCommand = ZoomViewController.PrevZoomTime.timeIntervalSinceNow
        
        if ( abs(secondsSinceLastSentCommand) > 0.25)  {  // currently 1/4 second
            // Been enough time.  send command
            self.angleLabel.text = "\(angleText)"
            self.zoomLabel.text = "\(zoomtext)"
                + "X"
            var xmlParser : zoomParser?
            xmlParser = zoomParser()
            xmlParser!.getZoomCameraCommand()           // This sends string out Ethernet
            ZoomViewController.PrevZoomTime = Date()    // store fresh time for fresh delay
        }
    }
    }
        override func viewDidLoad() {
        super.viewDidLoad()
            zoomGradient(view: mainZoomView)
            let titles = ["Zoom", "Focus", "Iris"]
            let frame = CGRect(x:32, y:55, width:217,  height: 31)
           
    }
    
    
    

    func zoomGradient(view:UIView) {
        
        _ = view
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame.size = self.view.frame.size
        gradient.colors = [UIColor.black.withAlphaComponent(0.6),UIColor.black.withAlphaComponent(0).cgColor] //Or any colors
        self.view.layer.addSublayer(gradient)
        
    }
    
    
//    func cameraMultiplier ()  {
//
//        switch  HDCameraViewController.camera.videoInput.CameraModelNumber {
//
//        case  "FCB-EV7500":
//            zoomMultiplier  = 30
//        case  "FCB-EV7100":
//            zoomMultiplier  = 10
//        case    "FCB-MA132":
//            zoomMultiplier = 16
//        case  "FCB-EV7520":
//            zoomMultiplier = 30
//        case "FCB-MA130":
//            zoomMultiplier = 16
//        case "KZ10":
//            zoomMultiplier = 10
//        case "AutoVisca":
//            zoomMultiplier = 1
//        case "None":
//            zoomMultiplier = 1
//        case "KT1080":
//            zoomMultiplier = 20
//        default: break
//        }
//
//    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

