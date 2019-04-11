import Foundation
import UIKit
import PlaygroundSupport

public class AutoLayout{
    
    public init () {}
    
    public func setAutoLayout(subView: UIView, view: UIView, topC: CGFloat, centerC: CGFloat, widthC: CGFloat?, heightC: CGFloat?) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.topAnchor.constraint(equalTo: view.topAnchor, constant: topC).isActive = true
        subView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: centerC).isActive = true
        if let w = widthC, let h = heightC {
            subView.widthAnchor.constraint(equalToConstant: w).isActive = true
            subView.heightAnchor.constraint(equalToConstant: h).isActive = true
        }
        
    }
}

