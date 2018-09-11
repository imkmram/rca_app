//
//  E_VisaDetailVC.swift
//  RCA
//
//  Created by TWC on 03/08/18.
//  Copyright © 2018 TWC. All rights reserved.
//

import UIKit
import WebKit

class E_VisaDetailVC: BaseVC , WKNavigationDelegate{

   // @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tblDetails: UITableView!
    @IBOutlet weak var webViewContainer: UIView!
    
     var webView : WKWebView!
   
    var country:E_Visa = E_Visa()
    
    override func viewWillAppear(_ animated: Bool) {
        
        webViewContainer.layer.cornerRadius = 10.0
        addRightNavigationView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblDetails.registerCellNib(BottomCell.self)
        tblDetails.rowHeight = UITableViewAutomaticDimension
        tblDetails.estimatedRowHeight = 160
    
        initWEBView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.stopLoading()
    }
    
    func initWEBView() {
        
        //webViewContainer.bringSubview(toFront: indicator)
       // indicator.startAnimating()
        
        self.startLoading()
        
        let webConfiguration = WKWebViewConfiguration()
        let customFrame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 0.0, height: self.webViewContainer.frame.size.height))
        self.webView = WKWebView (frame: customFrame , configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.webViewContainer.addSubview(webView)
        webView.topAnchor.constraint(equalTo: webViewContainer.topAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: webViewContainer.rightAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: webViewContainer.leftAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: webViewContainer.bottomAnchor).isActive = true
        webView.heightAnchor.constraint(equalTo: webViewContainer.heightAnchor).isActive = true
        //webView.uiDelegate = self
        webView.navigationDelegate = self
        
        let myURL = URL(string: "https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("======== Finish Loading ========")
       // indicator.stopAnimating()
        self.stopLoading()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("============ Error =============")
        print(error.localizedDescription)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension E_VisaDetailVC : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: BottomCell.identifier) as! BottomCell
            cell.delegate = self
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension E_VisaDetailVC : BottomCellDelegate {
    
    func btnVoiceTapped(sender: UIButton) {
        let storyboard = UIStoryboard(name: Constant.STORYBOARD_E_Visa, bundle: nil)
        let voiceVC = storyboard.instantiateViewController(withIdentifier: "NewVoiceVC") as! NewVoiceVC
        setBackTitle(title: "\(String(describing: country.title ?? "")) eVisa")
        voiceVC.country = country
        self.navigationController?.pushViewController(voiceVC, animated: true)
    }
    
    func btnManualTapped(sender: UIButton) {
        
//        let storyboard = UIStoryboard(name: Constant.STORYBOARD_E_Visa, bundle: nil)
//        let manualVC = storyboard.instantiateViewController(withIdentifier: Constant.VIEWCONTROLLER_MANUAL) as! ManualVC
//        setBackTitle(title: "\(String(describing: country.title ?? "")) eVisa")
//        manualVC.country = country
//        self.navigationController?.pushViewController(manualVC, animated: true)
        
        
//        let storyboard = UIStoryboard(name: Constant.STORYBOARD_E_Visa, bundle: nil)
//        let formVC = storyboard.instantiateViewController(withIdentifier: Constant.VIEWCONTROLLER_TYPEDFORM) as! TypedFormVC
//        setBackTitle(title: "\(String(describing: country.title ?? "")) eVisa")
//        self.navigationController?.pushViewController(formVC, animated: true)
        
        let storyboard = UIStoryboard(name: Constant.STORYBOARD_E_Visa, bundle: nil)
        let paragraphVC = storyboard.instantiateViewController(withIdentifier: "ParagraphVC") as! ParagraphVC
        setBackTitle(title: "\(String(describing: country.title ?? "")) eVisa")
        self.navigationController?.pushViewController(paragraphVC, animated: true)
    }
}
