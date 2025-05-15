//
//  ViewController.swift
//  DynamicAppIcon
//
//  Created by Nirzar Gandhi on 13/05/25.
//

import UIKit

struct AppIcon {
    
    static let AppIconMoonStar  = "AppIconMoonStar"
    static let AppIconNature    = "AppIconNature"
    static let AppIconStore     = "AppIconStore"
}

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var changeAppIconBtn: UIButton!
    
    
    // MARK: - Properties
    fileprivate lazy var appIcon = 0
    
    
    // MARK: -
    // MARK: - View init Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setControlsProperty()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.tintColor = .white
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
    }
    
    fileprivate func setControlsProperty() {
        
        self.view.backgroundColor = .white
        self.view.isOpaque = false
        
        // Scan Plate Buttton
        self.changeAppIconBtn.backgroundColor = .black
        self.changeAppIconBtn.setTitleColor(.white, for: .normal)
        self.changeAppIconBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        self.changeAppIconBtn.titleLabel?.lineBreakMode = .byClipping
        self.changeAppIconBtn.layer.masksToBounds = true
        self.changeAppIconBtn.layer.cornerRadius = 10.0
        self.changeAppIconBtn.showsTouchWhenHighlighted = false
        self.changeAppIconBtn.adjustsImageWhenHighlighted = false
        self.changeAppIconBtn.adjustsImageWhenDisabled = false
        self.changeAppIconBtn.setTitle("Change App Icon", for: .normal)
    }
}


// MARK: - Call back
extension ViewController {
    
    fileprivate func setAppIcon(to iconName: String?) {
        
        guard UIApplication.shared.supportsAlternateIcons else {
            print("Alternate icons not supported.")
            return
        }
        
        // Avoid reapplying the same icon to prevent animation/pop-up
        if UIApplication.shared.alternateIconName == iconName {
            print("Icon is already set to \(iconName ?? "primary"), skipping.")
            return
        }
        
        DispatchQueue.main.async {
            
            UIApplication.shared.setAlternateIconName(iconName) { error in
                if let error = error {
                    print("Error setting alternate icon: \(error.localizedDescription)")
                } else {
                    print("App icon changed to \(iconName ?? "primary").")
                }
            }
        }
    }
}


// MARK: - Button Touch & Action
extension ViewController {
    
    @IBAction func changeAppIconBtnTouch(_ sender: Any) {
        
        self.appIcon += 1
        
        switch self.appIcon {
            
        case 1:
            self.setAppIcon(to: AppIcon.AppIconMoonStar)
            
        case 2:
            self.setAppIcon(to: AppIcon.AppIconNature)
            
        case 3:
            self.setAppIcon(to: AppIcon.AppIconStore)
            
        default:
            self.setAppIcon(to: nil)
        }
        
        if self.appIcon == 4 {
            self.appIcon = 0
        }
    }
}
