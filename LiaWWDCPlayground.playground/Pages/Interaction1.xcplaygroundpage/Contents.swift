/*:
 # The Sound of Numbers - part 1
 
 ## Introduction
 
 Music and math are intrinsically connect. Everything in music is based on mathematics. Also, music is considered by specialists as a very effective educational method. Based on that, we can use music and math together to create a new educational system. In this playground, the sum concept is applied along with music symbols, teaching how to sum values and how to solve a simple mathematical expression.
 Music sheets are divided in measures; each measure has a specific time signature and it can be identified by adding the values of the notes. Each note represents a certain amount of beats. In the picture below, we can observe how many beats each symbol represents:
 ![notes](imagem_texto.png)
 
 In this playground, five symbols are used. These are their values:
 * Whole note - 4 beats
 
 ![notes](semibreve.png)
 
 * Half note - 2 beats
 
 ![notes](minima12.png)
 
 * Quarter note - 1 beat
 
 ![notes](seminima12.png)
 
 * Eighth note - 1/2 beat
 
 ![notes](colcheia12.png)
 
 * Sixteenth note - 1/4 beat
 
 ![notes](semicolcheia12.png)
 
 
 ## Counting times in a measure
 
 Notes’ values can be added to get a measures’ time signature. Here’s how it works:

 ![notes](sum1.png)
 
 ![notes](sum2.png)
 
 ![notes](sum3.png)
 
 The measure below, as an example, has four beats. It’s important to remember that the G clef is not related to the time signature.
 ![notes](example.png)
 
 In this first interaction, a measure is shown and the user must choose the correct option for the number of beats in that measure. The *play* button allows the user to hear the measure written above. The user must click on the *next* button to move to the next measure.
 
 [Next](@next)
 */

//#-hidden-code
import UIKit
import AVFoundation
import PlaygroundSupport

class ViewController : UIViewController, UITextViewDelegate {

    let y = [650,470,470,470,530,530,530,590,590,590]
    let x = [-150,-90,-30,30,90,150]
    let auto = AutoLayout()
    let set = ViewSet()
    let names = ["measure1","measure2","measure3","measure4"]
    let buttons = ["b0","b1","b2","b3","b4","b5"]
    let answers = [4,4,3,3]
    var scene : Int = 0
    var nextButton : UIButton!
    var measureView : UIImageView!
    var numberKeyboard : [UIButton]!
    var correctLabel : UILabel!
    var moveLabel : UILabel!
    var player : AVAudioPlayer?
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9689446092, green: 0.9900891185, blue: 0.997474134, alpha: 1)
        
        let subTitle = "Can you count the beats in these measures?"
        let statement = "Select the number that correctly represents \n the time count in the measures below."

        let l1 = set.createDefaultLabel(position:(0,0),outText:"Let's sum!",fontSize:30)
        let l2 = set.createDefaultLabel(position:(0,0),outText:subTitle,fontSize:20)
        let l3 = set.createDefaultLabel(position:(0,0),outText:statement,fontSize:20)
        l3.numberOfLines = 2
        l3.textAlignment = .center
        let l4 = set.createDefaultLabel(position:(0,0),outText:"Remember:",fontSize:20)
        
        let imgView = set.setImageView(position: (0, 0), size: (300,225), imgName: "imagem_texto.png")
        
        view.addSubview(l1)
        view.addSubview(l2)
        view.addSubview(l3)
        view.addSubview(l4)
        view.addSubview(imgView)
        
        measureView = UIImageView()
        measureView.image = UIImage(named: names[scene])
        view.addSubview(measureView)
        
        var playButton = UIButton(type: .system)
        playButton = set.setButton(position: (0,0), size: (50,50), name: "botao.png", tag: nil)
        playButton.addTarget(self, action: #selector(playAudio), for: .touchUpInside)
        view.addSubview(playButton)
        
        correctLabel = UILabel()
        set.setLabel(label: correctLabel, outText: "", fontSize: 30)
        view.addSubview(correctLabel)
        
        nextButton = UIButton(type: .system)
        nextButton.setBackgroundImage(nil, for: .disabled)
        view.addSubview(nextButton)
        
        moveLabel = UILabel()
        set.setLabel(label:moveLabel, outText: "", fontSize: 20)
        view.addSubview(moveLabel)
        
        auto.setAutoLayout(subView: l1, view: view, topC: 10, centerC: 0, widthC: nil, heightC: nil)
        auto.setAutoLayout(subView: l2, view: l1, topC: 50, centerC: 0, widthC: nil, heightC: nil)
        auto.setAutoLayout(subView: l3, view: l2, topC: 40, centerC: 0, widthC: nil, heightC: nil)
        auto.setAutoLayout(subView: l4, view: l3, topC: 90, centerC: -160, widthC: nil, heightC: nil)
        auto.setAutoLayout(subView: imgView, view: l3, topC: 60, centerC: 0, widthC: 200, heightC: 90)
        auto.setAutoLayout(subView: measureView, view: imgView, topC: 110, centerC: 0, widthC: 450, heightC: 135)
        auto.setAutoLayout(subView: playButton, view: measureView, topC: 145, centerC: 0, widthC: 50, heightC: 50)
        auto.setAutoLayout(subView: correctLabel, view: playButton, topC: 80, centerC: 0, widthC: nil, heightC: nil)
        auto.setAutoLayout(subView: nextButton, view: correctLabel, topC: 50, centerC: 0, widthC: 200, heightC: 90)
        auto.setAutoLayout(subView: moveLabel, view: correctLabel, topC: 100, centerC: 0, widthC: nil, heightC: nil)
        
        numberKeyboard = []
        for i in 0...5{
            numberKeyboard.append(UIButton(type: .system))
            numberKeyboard[i].setBackgroundImage(UIImage(named: buttons[i]), for: .normal)
            numberKeyboard[i].tag = i
            numberKeyboard[i].addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
            
            view.addSubview(numberKeyboard[i])
            auto.setAutoLayout(subView: numberKeyboard[i], view: playButton, topC: 90, centerC: CGFloat(x[i]), widthC: 50, heightC: 50)
        }
        
        self.view = view
    }
    
    @objc func playAudio() {
        let soundURL = Bundle.main.url(forResource: names[scene], withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
            guard let soundPlayer = player else { return }
            soundPlayer.prepareToPlay()
            soundPlayer.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @objc func changeScene(sender: UIButton) {
        if (scene < 3) {
            scene += 1
        }
        correctLabel.text = ""
        viewKeyboard()
        measureView.image = UIImage(named: names[scene])
        sender.setBackgroundImage(nil, for: .normal)
        nextButton.removeTarget(self, action: #selector(changeScene), for: .touchUpInside)
    }
    
    
    @objc func checkAnswer(sender: UIButton) {
        let animation = CABasicAnimation(keyPath: "position")
        
        if (answers[scene] == sender.tag){
            correctLabel.text = "Correct answer!"
            playAudio()
            hideKeyboard()
            if (scene < 3){
                nextButton.setBackgroundImage(UIImage(named: "next"), for: .normal)
                nextButton.addTarget(self, action: #selector(changeScene), for: .touchUpInside)
            }
            else {
                moveLabel.text = "Move to the next page for more!"
            }
        }
        else{
            animation.duration = 0.06
            animation.repeatCount = 2
            animation.autoreverses = true
            animation.fromValue = CGPoint(x: sender.center.x - 5, y: sender.center.y)
            animation.toValue = CGPoint(x: sender.center.x + 5, y: sender.center.y)
        }
        sender.layer.add(animation, forKey: "position")
    }
    
    func viewKeyboard(){
        for i in 0...5{
            numberKeyboard[i].isHidden = false
        }
    }
    
    func hideKeyboard(){
        for i in 0...5 {
            numberKeyboard[i].isHidden = true
        }
    }

}
let window = UIWindow(frame: CGRect(x: 0,
                                    y: 0,
                                    width: 768,
                                    height: 1024))
let viewController = ViewController()
window.rootViewController = viewController
window.makeKeyAndVisible()

PlaygroundPage.current.liveView = window
//PlaygroundPage.current.liveView = ViewController()


//#end-hidden-code


