
//  LoginTable.swift
//  Created by Brian Hamilton on 7/27/18.


import UIKit
import CocoaAsyncSocket



class loginCellClass: UITableViewCell    {


    @IBOutlet weak var boardModel: UILabel!
    
    @IBOutlet weak var rtspPort: UILabel!
    

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var macAddress: UILabel!
    @IBOutlet weak var firstSub: UIView!
    
    
}

class LoginTable: UIViewController, UITableViewDataSource,UITableViewDelegate,NetServiceBrowserDelegate, NetServiceDelegate, URLSessionDelegate, GCDAsyncUdpSocketDelegate, GCDAsyncSocketDelegate {

    let info = InfoController()
    let ssdpAddres = "239.255.255.250"
    let ssdpPort:UInt16 = 3702
    var ssdpSocket:GCDAsyncUdpSocket!
    
   
    let higherPriority = DispatchQueue.global(qos: .userInitiated)
    let lowerPriority = DispatchQueue.global(qos: .utility)
    var popCamera = Camera()
    var camera = Camera()
    var z3Camera = zCamera()
    static var loadingLocker = false
    let index = IndexPath()
    let indexSet = IndexSet()
    var mutableData : NSMutableData = NSMutableData()
    var cameraArray = [Camera]()
    var mainDict = [String:[Camera]]()
    var http = HttpService()
    static var servicePort:Int?
    static var hostname:String?
    @IBOutlet weak var tableView: UITableView!
    var nsb : NetServiceBrowser!
    var services = [NetService]()
    var ipaddress1:String?
    static var ipaddress2:String?
    var data: [String] = []
    static var newArray: [String] = []
    static var zoomMultiplier = Int()
    var onvifIP:String?
    var onvifName:String?
    var OnvifArray:[String] = []
    var PortArray:[Int] = []
    var CameraName:[String] = []
    var collection:[String:String]  = [:]
    var name:String?
    var watec:String?
    var micro:String?
    var dual:String?
    var z3:String?

    func textFieldShouldReturn(ipaddress: UITextField) -> Bool {
        self.view.endEditing(true)
        return true;
    }

    let ionodesImage = UIImage(named: "ionodes-logo-hire.jpg")
    let watecImage = UIImage(named: "Watec-Logo.jpg")
    let z3Image = UIImage(named: "z3Logo.jpg")
  
    
  
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return OnvifArray.count   }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OnvifArray.count
    }
    
    
    
  
    
        func tableView(_ tableView: UITableView, cellForRowAt index: IndexPath) -> UITableViewCell {
            
            
                        let cell = tableView.dequeueReusableCell(withIdentifier:"loginCell", for: index) as! loginCellClass //1.
                        cell.backgroundColor = UIColor.clear
          
                      
            
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        let track_Button = UIButton()
                       
                        track_Button.layer.cornerRadius = 8
                        track_Button.layer.backgroundColor = #colorLiteral(red: 0.9279846549, green: 0.0148168318, blue: 0.0004645651497, alpha: 1)
                        track_Button.setTitle("Live View", for: UIControl.State.normal)
                        track_Button.frame = CGRect(x: 300, y: 60, width: 100, height: 50)
                                track_Button.addTarget(self, action: #selector(self.track_Button_Pressed(sender:)), for: UIControl.Event.touchDown)
                                track_Button.addTarget(self, action: #selector(self.tapped), for: .touchUpInside)
                                track_Button.tag = index.row
                            track_Button.blink()
                                cell.addSubview(track_Button)
                            let recordingButton = UIButton()
                            recordingButton.addTarget(self, action: #selector(self.recordingButtonPressed(sender:)), for: UIControl.Event.touchDown)
                            recordingButton.addTarget(self, action: #selector(self.tapped), for: .touchUpInside)
                            recordingButton.tag = index.row
                            cell.addSubview(recordingButton)
                           
                            recordingButton.layer.cornerRadius = 8
                            recordingButton.layer.backgroundColor = #colorLiteral(red: 0.9279846549, green: 0.0148168318, blue: 0.0004645651497, alpha: 1)
                            recordingButton.setTitle("Recording", for: UIControl.State.normal)
                      
                            
                            let settingButton = UIButton()
                            settingButton.addTarget(self, action: #selector(self.settingButtonPressed(sender:)), for: UIControl.Event.touchDown)
                            settingButton.addTarget(self, action: #selector(self.tapped), for: .touchUpInside)
                               settingButton.tag = index.row
                                cell.addSubview(settingButton)
                         
                              settingButton.layer.cornerRadius = 8
                            settingButton.layer.backgroundColor = #colorLiteral(red: 0.9279846549, green: 0.0148168318, blue: 0.0004645651497, alpha: 1)
                            settingButton.setTitle("Settings", for: UIControl.State.normal)
                        //    settingButton.frame = CGRect(x: 400, y: 40, width: 120, height: 30)
                            cell.firstSub.layer.borderWidth = 2.0
                            cell.firstSub.layer.cornerRadius = 8
                            cell.firstSub.layer.borderColor = UIColor.white.cgColor
                            cell.firstSub.layer.backgroundColor = UIColor.black.cgColor
                        
                            cell.macAddress.text = ("Port  \(self.PortArray[index.row])")
                            cell.rtspPort.text = ("Device IP:" +  self.OnvifArray[index.row])
                            cell.boardModel.text = ("Board: " + self.CameraName[index.row])
                   
                            }
            
            
            
            
                            self.tableView.removeBlurLoader()
            
            
                            return cell //4.
            
                            }
    
  
 
 
            @objc func tapped() {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        
    }
    func tableGradient(view:UIView) {
        
        _ = view
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame.size = self.view.frame.size
        gradient.colors = [UIColor.black.withAlphaComponent(0.3),UIColor.black.withAlphaComponent(0.7).cgColor] //Or any colors
        self.view.layer.addSublayer(gradient)
        
    }

    
    func loadShow () {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating();
        present(alert, animated: true, completion: nil)
        self.dismiss(animated: false, completion: nil)

 
        }
    
        

 
    
    
        @objc func track_Button_Pressed(sender: UIButton!) {
            
                                    let buttonPosition = sender.convert(CGPoint.zero, to: self.tableView)
                                    let index = self.tableView.indexPathForRow(at: buttonPosition)!
                                    let position = index.row
                                    let name = "\(CameraName[index.row])"
                                    Login.ip = self.OnvifArray[index.row]
                                    self.setRTSP(type: name)
                                    print(Login.rtsp)
            
            
                                    performSegue(withIdentifier: "main", sender: self)
            
                                    self.tableView.reloadData()
            
            
            
            }
    
    
    
    
    func setRTSP(type:String) {
        
        
        if type == "ATOMAS-DUAL" {
        Login.rtsp = "rtsp://admin:admin@\(Login.ip)/videoinput_1/h264_1/media.stm"
            camera.discoverIP(ip: Login.ip)
            BasicCommands.LoginName = "IONODES"
            
            
            
        
    }
        else {
            if type == " ATOMAS-MICRO" {
        Login.rtsp = "rtsp://admin:admin@\(Login.ip)/videoinput_1/h264_1/media.stm"
               
                 BasicCommands.LoginName = "IONODES"
        }
            else {
                if type == "Z8550&#xA;" {
                     Login.rtsp =   "rtsp://\(Login.ip)/z3-1.sdp"
                    
                     BasicCommands.LoginName = "ZCAM"
       
                }
             else {
                if type == "Watec 933" {
               Login.rtsp =   "rtsp://root:1234@\(Login.ip)/h264"
                 //  Login.rtsp =   "rtsp://root:1234@169.254.51.240/h264"
                
                } else {
                    if type == "ATOMAS-MINI" {
                               Login.rtsp = "rtsp://admin:admin@\(Login.ip)/videoinput_1/h264_1/media.stm"
                                camera.discoverIP(ip: Login.ip)
                         //     HDCameraViewController.usesTCP = false
                              BasicCommands.LoginName = "IONODES"
                        
                    } else {
                        if type == "GPCZ710A4NT" {
                            Login.rtsp = "rtsp://root:root@\(Login.ip)/cam0_0"
                           
                        
                    
                    } else {
                        if type == "Z8550" {
                                    Login.rtsp =   "rtsp://\(Login.ip)/z3-1.sdp"
                                   camera.z3Info(ip:Login.ip)
                               //  camera.videoInput.z3Info(ip: Login.ip)
                              //  camera.encoder.z3EncoderInfo(ip: Login.ip)
                              //      HDCameraViewController.usesTCP = true
                                    BasicCommands.LoginName = "ZCAM"
                            
                            
                        }else {
                            if type == "ATOMAS-MICRO" {
                                Login.rtsp = "rtsp://admin:admin@\(Login.ip)/videoinput_1/h264_1/media.stm"
                               //    HDCameraViewController.usesTCP = false
                                   camera.discoverIP(ip: Login.ip)
                                   BasicCommands.LoginName = "IONODES"
                                
                            } else {
                                if type == "IPCamera" {
                                    Login.rtsp = "rtsp://admin:admin@\(Login.ip):554/stream0"
                                //   HDCameraViewController.usesTCP = false
                                
                            }
                             else {
                                
                                if type == "Red Mamba" {
                                  Login.rtsp = "rtsp://\(Login.ip):9099/stream"
                                BasicCommands.LoginName = "TWIGA"
                                 
                                    
                            }
                            }
            }
    
    }
    }
        }
                
    }
    }
    }
    }
    }
        
    
    @objc func settingButtonPressed(sender: UIButton!) {
        
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableView)
        let index = self.tableView.indexPathForRow(at: buttonPosition)!
        let position = index.row
        Login.ip = self.OnvifArray[index.row]
        info.setLabels(string:Login.ip)
        
    }
    
        @objc func recordingButtonPressed(sender: UIButton!){
            let buttonPosition = sender.convert(CGPoint.zero, to: self.tableView)
            let index = self.tableView.indexPathForRow(at: buttonPosition)!
            let position = index.row
            Login.ip = LoginTable.newArray[position]
            Login.rtsp = "rtsp://admin:admin@\(LoginTable.newArray[position])/videoinput_1/h264_1/media.stm"
            performSegue(withIdentifier: "showClips", sender: self)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        Login.username = "admin"
        Login.password = "admin"
        tableView.layer.borderWidth  = 2
        tableView.layer.borderColor = UIColor.white.cgColor
        tableView.layer.cornerRadius = 10
        tableView.backgroundColor = UIColor.black
        tableView.separatorColor = UIColor.white
        tableView.rowHeight = 140
        tableView.dataSource = self
        tableGradient(view: tableView)
        self.tableView.addSubview(self.refreshControl)

    }

    
    func updateInterface () {
        for service in self.services {
            if service.port == -1 {
                print("service \(service.name) of type \(service.type)" +
                    " not yet resolved")
                service.delegate = self
                service.resolve(withTimeout:20)
            } else {
                LoginTable.servicePort = service.port
                LoginTable.hostname = service.name
             
               
             
                
            }
            
        }
    }
    
    
   
    
    
    func onvif() {
        
        
   
      

        let zMessage = "<?xml version=\"1.0\" encoding=\"utf-8\"?><s:Envelope xmlns:s=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:a=\"http://schemas.xmlsoap.org/ws/2004/08/addressing\"><s:Header><a:Action s:mustUnderstand=\"1\">http://schemas.xmlsoap.org/ws/2005/04/discovery/Probe</a:Action><a:MessageID>uuid:95055bc6-0342-4825-9e13-871f039429ee</a:MessageID><a:ReplyTo><a:Address>http://schemas.xmlsoap.org/ws/2004/08/addressing/role/anonymous</a:Address></a:ReplyTo><a:To s:mustUnderstand=\"1\">urn:schemas-xmlsoap-org:ws:2005:04:discovery</a:To></s:Header><s:Body><Probe xmlns=\"http://schemas.xmlsoap.org/ws/2005/04/discovery\"><d:Types xmlns:d=\"http://schemas.xmlsoap.org/ws/2005/04/discovery\" xmlns:dp0=\"http://www.onvif.org/ver10/network/wsdl\"></d:Types></Probe></s:Body></s:Envelope>".data(using: String.Encoding.utf8)!
        
  
        do {
            ssdpSocket = GCDAsyncUdpSocket(delegate: self, delegateQueue: .main)
            ssdpSocket.send(zMessage, toHost: ssdpAddres, port: ssdpPort, withTimeout: 20, tag: 0)
          
            try ssdpSocket.bind(toPort: ssdpPort)
            try ssdpSocket.joinMulticastGroup(ssdpAddres)
            try ssdpSocket.beginReceiving()
        } catch {
            print(error)
        }
        
        let otherSocket = GCDAsyncSocket(delegate: self, delegateQueue: .main)
        
        do {
            try otherSocket.accept(onPort: ssdpPort)
        } catch {
            print(error)
           ssdpSocket.closeAfterSending()
           
        }
      
    }
    
    func udpSocketDidClose(_ sock: GCDAsyncUdpSocket, withError error: Error?) {
        print("socket closed")
    }
   

    func udpSocket(_ sock:GCDAsyncUdpSocket,didConnectToAddress data : Data){
        print("didConnectToAddress")
        print(data)
    }
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didSendDataWithTag tag: Int) {
        
    }
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didReceive data: Data, fromAddress address: Data, withFilterContext filterContext: Any?) {
     
        
        var host: NSString?
        var port1: UInt16 = 0
        GCDAsyncUdpSocket.getHost(&host, port: &port1, fromAddress: address )
    
       
        let string = host!
       
     
        
        onvifIP = string as String
        // OnvifArray.append(onvifIP!)

        let gotdata: NSString = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)!
        //print(gotdata)
        let text = gotdata as String
        onvifIP = text.sliceByString(from: "XAddrs>http://", to: "/onvif/")
        
        
        if text.range(of:"MambaA") != nil {
           
            onvifName = "Red Mamba"
        }
        if text.range(of:"ATOMAS-DUAL") != nil {
            
            onvifName = "ATOMAS-DUAL"
        }

        if text.range(of:"ATOMAS-MINI") != nil {
           
            onvifName = "ATOMAS-MINI"
        }
        if text.range(of:"Z8550") != nil {
           
            onvifName = "Z8550"
        }
        if text.range(of:"ATOMAS-MICRO") != nil {
           
            onvifName = " ATOMAS-MICRO"
        }
        if text.range(of:"WAT") != nil {
            
            onvifName = "Watec 933"
        }

        self.buildOnvifArray(ip: host! as String, name:self.onvifName!)
        self.buildPortArray(port: Int(port1))
    }
    
    func buildPortArray (port:Int) {
        
         PortArray.append(Int(port))
        
    }
    
    func buildOnvifArray (ip:String, name:String) {
        
        collection.updateValue(ip, forKey: name)
        OnvifArray.append(ip)
        CameraName.append(name)
        printValues()
        self.tableView.reloadData()
       
        }
    
    func printValues() {
        
            watec = self.collection["WAT933"]
            micro = self.collection["ATOMAS-MICRO-CNCT"]
            dual = self.collection["ATOMAS-DUAL-Q"]
            z3 = self.collection["Z8550&#xA;"]
         print(collection)
        }
    
    func netServiceDidResolveAddress(_ sender: NetService) {
        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
        guard let data = sender.addresses?.first else { return }
        data.withUnsafeBytes { (pointer:UnsafePointer<sockaddr>) -> Void in
            guard getnameinfo(pointer, socklen_t(data.count), &hostname, socklen_t(hostname.count), nil, 0, NI_NUMERICHOST) == 0 else {
                return
            }
        }
     
                ipaddress1 = String(cString:hostname)
                LoginTable.newArray.append(ipaddress1!)
                self.camera.discoverIP(ip: ipaddress1!)
                cameraArray.append(camera)
                self.updateInterface()
    }

    
    func netServiceBrowser(_ aNetServiceBrowser: NetServiceBrowser, didFind aNetService: NetService, moreComing: Bool) {
        print("adding a service")
        self.services.append(aNetService)
        if !moreComing {
            self.updateInterface()
        }
    }
    
    func netServiceBrowser(_ aNetServiceBrowser: NetServiceBrowser, didRemove aNetService: NetService, moreComing: Bool) {
        if let ix = self.services.index(of:aNetService) {
            self.services.remove(at:ix)
            print("removing a service")
            if !moreComing {
               
            }
        }
        }
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(LoginTable.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.white
        
        return refreshControl
    }()
  
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
       
        onvif()
        self.tableView.showBlurLoader()
        print("listening for services...")
        self.services.removeAll()
        self.nsb = NetServiceBrowser()
        self.nsb.delegate = self
        self.updateInterface()
        refreshControl.endRefreshing()
   
        
    
    

}
    

}





