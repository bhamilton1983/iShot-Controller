//
//  MainVC.swift
//  iShot
//
//  Created by Brian Hamilton on 1/7/19.
//  Copyright © 2019 Brian Hamilton. All rights reserved.
//

import UIKit

class MainVC: UIViewController,VLCMediaPlayerDelegate {
    static var menuToggle = 0
    @IBOutlet weak var bottomContainer: UIView!
    @IBOutlet var topView: UIView!
    var infoToggle = 0
    var playToggle = 0
    @IBOutlet weak var movieView: UIView!
    var mediaPlayer: VLCMediaPlayer = VLCMediaPlayer(options: ["-vvvv"])
    let pause = UIImage(named: "pause_active_72.jpg")
    let play = UIImage(named: "play_active_72")
    
    @IBOutlet weak var vlcControlView: UIView!
    @IBOutlet weak var hueSlider: UISlider!
    
    @IBOutlet weak var contrastSlider: UISlider!
    @IBOutlet weak var brightnessSlider: UISlider!
    
    @IBOutlet weak var photoButton: UIButton!
    let sliderThumb = UIImage(named: "handle.png")
    var path = String()
    let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    
    @IBOutlet weak var sliderOp: UISlider!
    @IBOutlet weak var gammaSlider: UISlider!
    
    @IBOutlet weak var saturationSlider: UISlider!
    
    @IBOutlet weak var testButton: UIButton!
    
    
    @IBAction func hslide(_ sender: UISlider) {
        
        let value = Float(sender.value)
        mediaPlayer.hue = value
        
        
        
    }
    
    @IBAction func cSlide(_ sender: UISlider) {
        
        let value = Float(sender.value)
        mediaPlayer.brightness = value
        
    }
    
    
    @IBAction func contrast(_ sender: UISlider) {
        let value = Float(sender.value)
        mediaPlayer.contrast = value
    }
    
    
    
    func toggleVLCView ()
    {
        if MainVC.menuToggle == 0 {
            vlcControlView.isHidden = false
        } else {
            if MainVC.menuToggle == 1 {
                
                vlcControlView.isHidden = true
            }
        }
        
        
    }
    
    
    @IBAction func gamAction(_ sender: UISlider) {
        
        let value = Float(sender.value)
        
        mediaPlayer.gamma = value
    }
    
    @IBAction func saturationAction(_ sender: UISlider) {
        let value = Float(sender.value)
        
        mediaPlayer.saturation = value
    }
    
    @IBAction func test(_ sender: Any) {
        
        toggleVLCView()
        
    }
    
    @IBAction func opacityAction(_ sender:UISlider) {
        let value = Float(sender.value)
        
        mediaPlayer.pitch = value
    }
    @IBAction func startVideo(_ sender: Any) {
        
        
        if playToggle == 0 {
            playVideo()
            mediaPlayer.play()
            
            print("Playing")
            movieView.frame = UIScreen.main.bounds
            playButton.isHidden = true
            playButton.frame = CGRect(x: 20, y: 28, width: 60, height: 60)
            
            playButton.setImage(pause, for: .normal)
            playToggle = 1
        } else {
            
            if playToggle == 1 {
                playButton.setImage(play, for: .normal)
                playButton.frame = CGRect(x: 20, y: 28, width: 60, height: 60)
                mediaPlayer.pause()
                playToggle = 0
                
            }
        }
    }
    func playVideo () {
        
        
        self.movieView.backgroundColor = UIColor.black
        self.movieView.frame =  UIScreen.main.bounds
        topView.addSubview(movieView)
        
    }
    
    @IBAction func opacitySlider(_ sender: Any) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        //        testButton.mediumButton()
        //        photoButton.bigButton()
        //        sliderOp.setThumbImage(sliderThumb, for: .normal)
        //        hueSlider.setThumbImage(sliderThumb, for: .normal)
        //        contrastSlider.setThumbImage(sliderThumb, for: .normal)
        //        brightnessSlider.setThumbImage(sliderThumb, for: .normal)
        //        gammaSlider.setThumbImage(sliderThumb, for: .normal)
        //        saturationSlider.setThumbImage(sliderThumb, for: .normal)
        //
        //        testButton.isHidden = true
        
        //  Playing multicast UDP (you can multicast a video from VLC)
        //   let url = NSURL(string: "udp://admin:admin@237.0.0.1:4000")
        //Playing HTTP from internet
        //let url = NSURL(string: "http://streams.videolan.org/streams/mp4/Mr_MrsSmith-h264_aac.mp4")
        //Playing RTSP from internet
        
        
        let url = URL(string: "\(Login.rtsp)")
        
        if url == nil {
            print("Invalid URL")
            return
        }
        
        let media = VLCMedia(url: url! as URL)
        mediaPlayer.scaleFactor = 0
        mediaPlayer.media = media
        mediaPlayer.delegate = self
        mediaPlayer.drawable = self.movieView
        mediaPlayer.adjustFilterEnabled = true
        print(media.numberOfSentPackets)
        
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(MainVC.movieViewTapped(_:)))
        self.movieView.addGestureRecognizer(gesture)
        media.addOptions(["network-caching" : 0])
        media.addOptions(["transform-type" : 270])
        print(media.classForCoder)
    }
    
    @IBOutlet weak var playButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testButton.mediumButton()
        photoButton.bigButton()
        sliderOp.setThumbImage(sliderThumb, for: .normal)
        hueSlider.setThumbImage(sliderThumb, for: .normal)
        contrastSlider.setThumbImage(sliderThumb, for: .normal)
        brightnessSlider.setThumbImage(sliderThumb, for: .normal)
        gammaSlider.setThumbImage(sliderThumb, for: .normal)
        saturationSlider.setThumbImage(sliderThumb, for: .normal)
        saturationSlider.isHidden = true
        contrastSlider.isHidden = true
        gammaSlider.isHidden = true
        brightnessSlider.isHidden = true
        sliderOp.isHidden = true
        hueSlider.isHidden = true
        testButton.isHidden = true
        photoButton.isHidden = true
        
        bottomContainer.frame = CGRect(x:0, y:632 , width:1194, height: 180)
        bottomContainer.isHidden = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(MainVC.movieViewTapped(_:)))
        self.movieView.addGestureRecognizer(gesture)
        // toggleVLCView()
    }
    
    @IBAction func savePhotoTapped(_ sender: Any) {
        photoButton.blink()
        let image = UIImage(view: movieView)
        
        let imageRepresentation = image.pngData()
        let imageData = UIImage(data: imageRepresentation!)
        UIImageWriteToSavedPhotosAlbum(imageData!, nil, nil, nil)
        let alert = UIAlertController(title: "Completed", message: "Image has been saved!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func hideSide() {
        
        saturationSlider.isHidden = true
        contrastSlider.isHidden = true
        gammaSlider.isHidden = true
        brightnessSlider.isHidden = true
        sliderOp.isHidden = true
        hueSlider.isHidden = true
        testButton.isHidden = true
        photoButton.isHidden = true
        
        
    }
    
    func showSide () {
        saturationSlider.isHidden = false
        contrastSlider.isHidden = false
        gammaSlider.isHidden = false
        brightnessSlider.isHidden = false
        sliderOp.isHidden = false
        hueSlider.isHidden = false
        testButton.isHidden = false
        photoButton.isHidden = false
        
        
        
    }
    
    
    @objc func movieViewTapped(_ sender: UITapGestureRecognizer) {
        
        if infoToggle == 0 {
            
            showSide()
            movieView.frame = UIScreen.main.bounds
            bottomContainer.frame = CGRect(x:0, y:732 , width:1194, height: 190)
            bottomContainer.isHidden = false
            topView.addSubview(bottomContainer)
            playButton.isHidden = false
            bottomContainer.addSubview(playButton)
            testButton.isHidden = false
            bottomContainer.addSubview(vlcControlView)
            vlcControlView.isHidden = false
            playButton.frame = CGRect(x: 20, y: 28, width: 60, height: 60)
            bottomContainer.addSubview(testButton)
            topView.addSubview(vlcControlView)
            vlcControlView.frame = CGRect(x: 671, y: 718, width:433, height: 127)
            infoToggle = 1
        }
            
        else
            
            if infoToggle == 1 {
                hideSide()
                movieView.frame = UIScreen.main.bounds
                //     bottomContainer.isHidden = true
                infoToggle = 0
        }
        
    }
    
}
