//
//  WebViewer.swift
//  Employee Details
//
//  Created by Sooraj R on 30/10/24.
//

import UIKit
import WebKit
class WebViewer: UIViewController {
    // MARK: - IBOUTLETS
    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var pageTitleLbl: UILabel!

    // MARK: - CONSTANTS AND VARIABLES
    var urlString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print(urlString)
        let url: URL
        if urlString.hasPrefix("/") {
            url = URL(fileURLWithPath: urlString)
        } else {
            url = URL(string: urlString)!
        }
        webview.load(URLRequest(url: url))
    }

    // MARK: - BUTTON ACTIONS
    @IBAction func backAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
