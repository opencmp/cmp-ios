import UIKit
import WebKit


protocol CMProtocol: class {
    func getConsent()
    func setConsent(info: [String: AnyObject])
    func showUI()
    func hideUI()
}

@available(iOS 9.0, *)
class WebPrezenterViewController: UIViewController {

    enum WebViewKeyPath: String {
      case estimatedProgress
    }
    enum CMProtocolEnum: String {
        case getConsent
        case setConsent
        case showUI
        case hideUI
    }
    
    private lazy var container = UIView(frame: CGRect.zero)
    private lazy var progressView = UIProgressView(progressViewStyle: .bar)
    private(set) lazy var webView: WKWebView =  WKWebView(frame: UIScreen.main.bounds, configuration: config)
    private let settings = OpenCmpSettings()
    
    private var config: WKWebViewConfiguration {
        let contentController = WKUserContentController();
        contentController.add(
            self,
            name: CMProtocolEnum.getConsent.rawValue
        )
        contentController.add(
            self,
            name: CMProtocolEnum.setConsent.rawValue
        )
        contentController.add(
            self,
            name: CMProtocolEnum.showUI.rawValue
        )
        contentController.add(
            self,
            name: CMProtocolEnum.hideUI.rawValue
        )
        
        let config = WKWebViewConfiguration()
        let prefs = WKPreferences()
        prefs.javaScriptEnabled = true
        config.preferences = prefs
        config.userContentController = contentController
        return config
    }
    
    private lazy var toolbar: UIView = {
      let v = UIView(frame: CGRect.zero)
      v.isUserInteractionEnabled = true
      v.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
      v.translatesAutoresizingMaskIntoConstraints = false
          
      let blurEffect = UIBlurEffect(style: .light)
      let blurEffectView = UIVisualEffectView(effect: blurEffect)
      v.addSubview(blurEffectView)
      blurEffectView.bindFrameToSuperviewBounds()
      return v
    }()
    
    private lazy var urlLabel:UILabel = {
      let lbl = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 250.0, height: 10.0))
      lbl.adjustsFontSizeToFitWidth = true
      lbl.minimumScaleFactor = 0.9
      lbl.textAlignment = .center
      lbl.font = UIFont.systemFont(ofSize: 10)
      return lbl
    }()

    private let topMargin:CGFloat = 10.0
    private var lastLocation:CGPoint = .zero
    public var request: String!
   
    
    var detail:String? {
      didSet {
        urlLabel.text = detail
      }
    }
    
    
    override public func loadView() {
      super.loadView()
      setupMainLayout()
      setupToolbar()
    }
    

    override public func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        webView.loadHTMLString(request, baseURL: nil)
        // test function that present webview with configuration
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showUI()
            
        }
 
    }
    
        
    public override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      addWebViewObservers()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      removeWebViewObservers()
    }
    
    private func setupToolbar() {

      let titleStackView = UIStackView(arrangedSubviews: [ urlLabel])
      titleStackView.axis = .vertical

      let toolbarStackView = UIStackView(arrangedSubviews: [ titleStackView])
      toolbarStackView.spacing = 2.0
      toolbarStackView.axis = .horizontal
      toolbar.addSubview(toolbarStackView)

      toolbarStackView.translatesAutoresizingMaskIntoConstraints = false
      toolbarStackView.topAnchor.constraint(equalTo: toolbar.topAnchor, constant: 5).isActive = true
      toolbarStackView.leadingAnchor.constraint(equalTo: toolbar.leadingAnchor, constant: 5).isActive = true
      toolbarStackView.bottomAnchor.constraint(equalTo: toolbar.bottomAnchor, constant: -5).isActive = true
      toolbarStackView.trailingAnchor.constraint(equalTo: toolbar.trailingAnchor, constant:  -49).isActive = true
    }
      
    
    private func setupMainLayout() {
      view = UIView()
      view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
      view.backgroundColor = .clear
      view.addSubview(container)
      container.translatesAutoresizingMaskIntoConstraints = false
      container.topAnchor.constraint(
        equalTo: view.safeTopAnchor, constant: topMargin).isActive = true
      container.bottomAnchor.constraint(
        equalTo: view.bottomAnchor).isActive = true
      container.leadingAnchor.constraint(
        equalTo: view.safeLeadingAnchor, constant: 0).isActive = true
      container.trailingAnchor.constraint(
        equalTo: view.safeTrailingtAnchor, constant: 0).isActive = true
      container.layer.cornerRadius = 16.0
      container.clipsToBounds = true
      
      let progressViewContainer = UIView()
      progressViewContainer.addSubview(progressView)
      progressView.bindFrameToSuperviewBounds()
      progressViewContainer.heightAnchor.constraint(equalToConstant: 1)
          .isActive = true
      
      let mainStackView = UIStackView(arrangedSubviews: [
          toolbar,
          progressViewContainer,
          webView])
      
      mainStackView.axis = .vertical
      container.addSubview(mainStackView)
      mainStackView.bindFrameToSuperviewBounds()

    }
    
    private func addWebViewObservers() {
      webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
      webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
      webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack), options: .new, context: nil)
      webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward), options: .new, context: nil)
    }
    
    private func removeWebViewObservers() {
      webView.removeObserver(self, forKeyPath:  #keyPath(WKWebView.estimatedProgress))
      webView.removeObserver(self, forKeyPath:  #keyPath(WKWebView.title))
      webView.removeObserver(self, forKeyPath:  #keyPath(WKWebView.canGoBack))
      webView.removeObserver(self, forKeyPath:  #keyPath(WKWebView.canGoForward))
    }
    
        
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?,
      change: [NSKeyValueChangeKey : Any]?,
      context: UnsafeMutableRawPointer?) {
      
      switch keyPath {
      case WebViewKeyPath.estimatedProgress.rawValue:
        progressView.progress = Float(webView.estimatedProgress)
        if progressView.progress == 1.0 {
          progressView.alpha = 0.0
        } else if progressView.alpha != 1.0 {
          progressView.alpha = 1.0
        }

      default:
        break
      }
    }
  }

@available(iOS 9.0, *)
extension WebPrezenterViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let cmpEnum = CMProtocolEnum(rawValue: message.name ) {
            switch cmpEnum {
            case .getConsent:
                getConsent()
            case .setConsent:
                if let result = convertStringToDictionary(text: message.body as? String ?? "")  {
                setConsent(info: result)
                }
            case .showUI:
                showUI()
            case .hideUI:
                hideUI()
            }
        } else {
            print("There isn't a CMP procol")
        }
    }
    
}

@available(iOS 9.0, *)
extension WebPrezenterViewController: WKNavigationDelegate {
    
    public func webView(
      _ webView: WKWebView,
      decidePolicyFor navigationAction: WKNavigationAction,
      decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
      
      switch navigationAction.navigationType {
      case .linkActivated:
        webView.load(navigationAction.request)
      default:
        break
      }
      decisionHandler(.allow)
    }
}

@available(iOS 9.0, *)
extension WebPrezenterViewController {
    func convertStringToDictionary(text: String) -> [String: AnyObject]? {
        if let data = text.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("error JSONSerialization")
            }
        }
        return nil
    }
}

@available(iOS 9.0, *)
extension WebPrezenterViewController: CMProtocol {
    
    func getConsent() {
        let dict = UserDefaults.standard.dictionaryRepresentation()
        let jsonData = try! JSONSerialization.data(withJSONObject: dict, options: [])
        let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)!

        // Send update to the page
        self.webView.evaluateJavaScript("getConsent(\(jsonString))") { result, error in
            if let jsError =  error  {
                print(jsError)
                return
            }
        }
    }

   
    
    func setConsent(info: [String: AnyObject]) {
        do {
            try settings.savePropertyList(info)
        } catch {
            print(error)
        }        
    }
    
    func showUI() {
        UIApplication.topViewController()?.present(self, animated: true, completion: nil)
    }
    
    func hideUI() {
        dismiss(animated: true, completion: nil)
    }
    
}



