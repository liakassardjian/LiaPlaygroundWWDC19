import Foundation
import UIKit

public class ViewSet {
    
    public init () {}
    
    public func setButton(position: (Int,Int), size: (Int,Int), name: String, tag: Int?) -> UIButton {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: name), for: .normal)
        button.frame = CGRect(x: position.0, y: position.1, width: size.0, height: size.1)
        if let t = tag{
            button.tag = t
        }
        return button
    }
    
    public func createDefaultLabel(position: (Int,Int), outText:String, fontSize: CGFloat) -> UILabel {
        
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2994747162, green: 0.2722252309, blue: 0.3381847143, alpha: 1)
        label.frame = CGRect(x: position.0, y: position.1, width: 300, height: Int(fontSize))
        label.font = UIFont(name: "Helvetica", size: fontSize)
        label.textAlignment = NSTextAlignment.left
        label.text = outText
        
        return label
    }
    
    public func setLabel(label: UILabel, outText:String, fontSize: CGFloat) {
        label.text = outText
        label.textColor = #colorLiteral(red: 0.2994747162, green: 0.2722252309, blue: 0.3381847143, alpha: 1)
        label.font = UIFont(name: "Helvetica", size: fontSize)
        label.textAlignment = NSTextAlignment.left
        
    }
    
    public func setImageView(position: (Int,Int), size: (Int,Int), imgName: String) -> UIImageView {
        let img = UIImage(named: imgName)
        let imgView = UIImageView(image: img)
        imgView.frame = CGRect(x: position.0, y: position.1, width: 300, height: size.1)
        
        return imgView
    }
    
    public func setTextField(position: (Int,Int), size: (Int,Int)) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.frame = CGRect(x: position.0, y: position.1, width: size.0, height: size.1)
        
        return textField
    }
    
}

