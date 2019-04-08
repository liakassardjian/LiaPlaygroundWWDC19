/*:
 [Previous](@previous)
 # This is me
 
 My name is Lia Kassardjian, I'm from São Paulo, Brazil, and I'm currently studying Computer Science. Also, I'm a student at Apple Developer Academy | Mackenzie.
 I've been surrounded by music my hole life, from my grandmother's piano lessons to performing in a musical. Because of that, I've decided to make a playground based on music.
 I believe that music is essencial for a child's development and that it can be very effective in learning. I've decided, then, to  use music as an educational method by connecting it to mathematical concepts. Music teaches us how learning can be fun.
 */

//#-hidden-code
import Foundation
import UIKit
import PlaygroundSupport

class ViewController : UIViewController, UITextViewDelegate {

    let auto = AutoLayout()
    let set = ViewSet()
    
    override func loadView() {
        
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9689446092, green: 0.9900891185, blue: 0.997474134, alpha: 1)
        
        let label = set.createDefaultLabel(position: (0,0), outText: "This is me!", fontSize: 50)
        view.addSubview(label)
        auto.setAutoLayout(subView: label, view: view, topC: 70, centerC: 0, widthC: nil, heightC: nil)
        
        let picture = set.setImageView(position: (0,0), size: (30,30), imgName: "picture")
        view.addSubview(picture)
        auto.setAutoLayout(subView: picture, view: view, topC: 200, centerC: 0, widthC: 300, heightC: 300)

        self.view = view
    }

}
//#end-hidden-code

PlaygroundPage.current.liveView = ViewController()

