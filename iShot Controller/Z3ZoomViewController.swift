//
//  Z3ZoomViewController.swift
//  RtspClient
//
//  Created by Brian Hamilton on 10/31/18.
//

import UIKit


class Z3ZoomViewController: UIViewController {
    static var z3textString = String()
    static  var segmentChoice = String()
    static  var currentZoomLevel = String()
    var zoomMultiplier = Int()
    var camera = Camera()
    let http = HttpService()
    var segmentChoice:Int = 0
    var textZoom = String()

    static var PrevZoomTime : Date = Date() // keep time of previous ethernet transmission
    
    @IBOutlet weak var zoomSlider: UISlider!
    
    @IBOutlet weak var mainZoomView: UIView!
    @IBOutlet weak var zoomLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        zoomGradient(view: mainZoomView)
     
      

   
    }
    
    @IBAction func zoomAction(_ sender: UISlider) {
        DispatchQueue.main.async(qos: .userInteractive) {
            
           
            self.segmentedControl(sender)  // Format Zoom/Iris/Focus selector text  // 8/8/18 SDE
            let zoomLevel = Int(sender.value)
            Z3ZoomViewController.currentZoomLevel = String(zoomLevel) // Update sting in class
            let zoomtext = zoomLevel * self.zoomMultiplier / 100
          
            //  See how much time was elapsed 8/8/18 SDE
            // We don't want to overwhelm the camera with zoom commands.
            // Must be longer than XX seconds or won't send  command.
            //  let zoomtext = zoomLevel *
            
            let secondsSinceLastSentCommand = Z3ZoomViewController.PrevZoomTime.timeIntervalSinceNow
            
            if ( abs(secondsSinceLastSentCommand) > 0.25)  {  // currently 1/4 second
                // Been enough time.  send command
             
                self.zoomLabel.text = "\(zoomtext)"
                    + "X"
                let request = z3Request()
                request.z3Zoom()    // This sends string out Ethernet
                Z3ZoomViewController.PrevZoomTime = Date()    // store fresh time for fresh delay
            }
        }
        
    }
    func zoomGradient(view:UIView) {
        
        _ = view
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame.size = self.view.frame.size
        gradient.colors = [UIColor.black.withAlphaComponent(0.6),UIColor.black.withAlphaComponent(0).cgColor] //Or any colors
        self.view.layer.addSublayer(gradient)
        
    }
    
    @IBAction func segmentedControl(_ sender: Any) {
        
        switch segmentChoice {
        case  0: segmentChoice = 0
        Z3ZoomViewController.segmentChoice = "action=CameraControl&command=zoom_direct "
        case 1: segmentChoice = 1
        zoomMultiplier = 100
        Z3ZoomViewController.segmentChoice = "action=CameraControl&command=focus_direct "
        case 2: segmentChoice = 2
        zoomMultiplier = 100
        Z3ZoomViewController.segmentChoice = "action=CameraControl&command=iris "
        zoomMultiplier = 17
        default:
            break
        }
    }
//    func cameraMultiplier ()  {
//        
//        switch  HDCameraViewController.camera.videoInput.CameraModelNumber {
//            
//        case  "FCB-EV7500":
//            zoomMultiplier  = 30
//        case  "Z8550":
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
