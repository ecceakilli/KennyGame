//
//  ViewController.swift
//  KennyGame
//
//  Created by ece on 26.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 10
    var kennyArray = [UIImageView]()
    var highScore = 0

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        scoreLabel.text = "Score \(score)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
      
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "High Score:\(highScore)"
        }
        
        //0 ve nil değilse
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "High Score:\(highScore)"
        }
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        
        kenny1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageController(_:))))
        kenny2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageController(_:))))
        kenny3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageController(_:))))
        kenny4.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageController(_:))))
        kenny5.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageController(_:))))
        kenny6.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageController(_:))))
        kenny7.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageController(_:))))
        kenny8.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageController(_:))))
        kenny9.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageController(_:))))
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(kennyHide), userInfo: nil, repeats: true)
        
        kennyArray = [kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
        
        kennyHide()
    }
    
    @objc func kennyHide(){
        
        for kennyarray in kennyArray {
            kennyarray.alpha = 0
        }
        let random = Int.random(in: 0..<kennyArray.count)
        print(random)
        kennyArray[random].alpha = 1
        
    }
        

    @IBAction func imageController(_ sender: UITapGestureRecognizer) {
        score += 1
        scoreLabel.text = "Score: \(score)"
        }
    
    @objc func timerFunc(){
        
        counter -= 1
        timeLabel.text = "\(counter)"
        
        
        if counter == -1 {
            timer.invalidate()
            hideTimer.invalidate()
            timeLabel.text = "Time over"
            
            
            for kennyarray in kennyArray {
                kennyarray.isHidden = true
            }
            
            if self.score > self.highScore{
                self.highScore = self.score
                highScoreLabel.text = "High Score:\(self.highScore)"
                //highcsor'u userDefaultta tuttum
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
        
        
        let alert = UIAlertController(title: "Uyarı", message: "Süreniz sona erdi", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction.init(title: "Replay", style: UIAlertAction.Style.default, handler: { UIAlertAction in
            
            self.score = 0
            self.scoreLabel.text = "Score: \(self.score)"
            self.counter = 10
            self.timeLabel.text = String(self.counter)
            
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunc), userInfo: nil, repeats: true)
            self.hideTimer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(self.kennyHide), userInfo: nil, repeats: true)
            
        }))
        self.present(alert, animated: true, completion: nil)
        }
    }
    }


    


