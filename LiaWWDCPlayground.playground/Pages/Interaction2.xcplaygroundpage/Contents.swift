/*:
 [Previous](@previous)
 # The Sound of Numbers - part 2

 Measures can be compared to mathematical expression: if we now how many beats a measure should have, we can place the correct symbols in them. adding their values to get to the time signature.
 
 In this interaction, an incomplete measure is shown and the user must choose the note that completes the measure correctly by clicking on it. The Playground tells the user how many beats that measure should have, so the correct option will be chosen.
 
 [Next](@next)
*/

//#-hidden-code
import UIKit
import PlaygroundSupport
import AVFoundation

class ViewController : UIViewController, UITextViewDelegate {

    let auto = AutoLayout()
    let set = ViewSet()
    
    let imageName = ["measure5m.png","measure6m.png","measure7m.png","measure8m.png"]
    let names = ["measure5","measure6","measure7","measure8"]
    let answers = [4,3,2,1]
    let times = [2,2,3,4]
    var scene : Int = 0
    var l3 : UILabel!
    var measureView : UIImageView!
    var correctLabel : UILabel!
    var endLabel : UILabel!
    var nextButton : UIButton!
    var player : AVAudioPlayer?

    override func loadView() {
        
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9689446092, green: 0.9900891185, blue: 0.997474134, alpha: 1)
        
        let subTitle = "Click on the note that correcty completes the measure"
        
        let l1 = set.createDefaultLabel(position:(0,0), outText:"Try it yourself!", fontSize:30)
        let l2 = set.createDefaultLabel(position:(0,0), outText:subTitle, fontSize:20)
        l3 = UILabel()
        set.setLabel(label: l3, outText: "Make a measure with \(times[scene]) times", fontSize: 20)
        
        
        var notes : [UIButton] = [set.setButton(position: (0,0), size: (30,30), name: "wholenote", tag: 0),
                                  set.setButton(position: (0,0), size: (30,30), name: "halfnote", tag: 1),
                                  set.setButton(position: (0,0), size: (30,30), name: "quarternote", tag: 2),
                                  set.setButton(position: (0,0), size: (30,30), name: "eighthnote", tag: 3),
                                  set.setButton(position: (0,0), size: (30,30), name: "sixteenthnote", tag: 4)]
        
        notes[0].addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
        notes[1].addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
        notes[2].addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
        notes[3].addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
        notes[4].addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
        
        view.addSubview(l1)
        view.addSubview(l2)
        view.addSubview(l3)
        view.addSubview(notes[0])
        view.addSubview(notes[1])
        view.addSubview(notes[2])
        view.addSubview(notes[3])
        view.addSubview(notes[4])

        measureView = UIImageView()
        measureView.image = UIImage(named: imageName[scene])
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
        
        endLabel = UILabel()
        set.setLabel(label: endLabel, outText: "", fontSize: 30)
        view.addSubview(endLabel)

        auto.setAutoLayout(subView: l1, view: view, topC: 10, centerC: 0, widthC: nil, heightC: nil)
        auto.setAutoLayout(subView: l2, view: l1, topC: 50, centerC: 0, widthC: nil, heightC: nil)
        auto.setAutoLayout(subView: notes[0], view: l2, topC: 60, centerC: -140, widthC: 40, heightC: 120)
        auto.setAutoLayout(subView: notes[1], view: l2, topC: 60, centerC: -70, widthC: 40, heightC: 120)
        auto.setAutoLayout(subView: notes[2], view: l2, topC: 60, centerC: 0, widthC: 40, heightC: 120)
        auto.setAutoLayout(subView: notes[3], view: l2, topC: 60, centerC: 70, widthC: 50, heightC: 120)
        auto.setAutoLayout(subView: notes[4], view: l2, topC: 60, centerC: 140, widthC: 50, heightC: 120)
        auto.setAutoLayout(subView: l3, view: l2, topC: 210, centerC: 0, widthC: nil, heightC: nil)
        auto.setAutoLayout(subView: measureView, view: l3, topC: 40, centerC: 0, widthC: 450, heightC: 135)
        auto.setAutoLayout(subView: playButton, view: measureView, topC: 150, centerC: 0, widthC: 50, heightC: 50)
        auto.setAutoLayout(subView: correctLabel, view: playButton, topC: 80, centerC: 0, widthC: nil, heightC: nil)
        auto.setAutoLayout(subView: nextButton, view: correctLabel, topC: 50, centerC: 0, widthC: 200, heightC: 90)
        auto.setAutoLayout(subView: endLabel, view: correctLabel, topC: 100, centerC: 0, widthC: nil, heightC: nil)
        
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
        measureView.image = UIImage(named: imageName[scene])
        correctLabel.text = ""
        l3.text = "Make a measure with \(times[scene]) beats"
        sender.setBackgroundImage(nil, for: .normal)
        nextButton.removeTarget(self, action: #selector(changeScene), for: .touchUpInside)
    }
    
    @objc func checkAnswer(sender: UIButton) {
        let animation = CABasicAnimation(keyPath: "position")
        if (answers[scene] == sender.tag){
            correctLabel.text = "Correct answer!"
            if (scene < 3){
                nextButton.setBackgroundImage(UIImage(named: "next"), for: .normal)
                nextButton.addTarget(self, action: #selector(changeScene), for: .touchUpInside)
            }
            else {
                endLabel.text = "The End."
            }
            measureView.image = UIImage(named: names[scene])
            playAudio()
            animation.duration = 0.3
            animation.repeatCount = 1
            animation.autoreverses = true
            animation.fromValue = CGPoint(x: sender.center.x, y: sender.center.y)
            animation.toValue = CGPoint(x: sender.center.x, y: sender.center.y - 15)
            
            
        }
        else{
            animation.duration = 0.06
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = CGPoint(x: sender.center.x - 10, y: sender.center.y)
            animation.toValue = CGPoint(x: sender.center.x + 10, y: sender.center.y)
        }
        sender.layer.add(animation, forKey: "position")
        
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


