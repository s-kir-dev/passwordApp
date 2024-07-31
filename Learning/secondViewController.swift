//
//  secondViewController.swift
//  Learning
//
//  Created by Кирилл Сысоев on 31.07.24.
//

import UIKit

class secondViewController: UIViewController {
    @IBOutlet weak var firstCircle: UIButton!
    
    @IBOutlet weak var secondCircle: UIButton!
    
    @IBOutlet weak var thirdCircle: UIButton!
    
    @IBOutlet weak var fourthCircle: UIButton!
    
    @IBOutlet weak var numberOne: UIButton!
    
    @IBOutlet weak var numberTwo: UIButton!
    
    @IBOutlet weak var numberThree: UIButton!
    
    @IBOutlet weak var numberFour: UIButton!
    
    @IBOutlet weak var numberFive: UIButton!
    
    @IBOutlet weak var numberSix: UIButton!
    
    @IBOutlet weak var numberSeven: UIButton!
    
    @IBOutlet weak var numberEight: UIButton!
    
    @IBOutlet weak var numberNine: UIButton!
    
    @IBOutlet weak var numberNull: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var removeLastNumber: UIButton!
    
    @IBOutlet weak var currentPassword: UILabel!
    
    var staticPassword : [Int] = []
    
    var firstViewController : FirstViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let numberButtons : [UIButton] = [numberOne, numberTwo, numberThree, numberFour, numberFive, numberSix, numberSeven, numberEight, numberNine, numberNull]
        
        for button in numberButtons {
            button.addTarget(self, action: #selector(numberTapped(_ :)), for: .touchUpInside)
        }
        
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        removeLastNumber.addTarget(self, action: #selector(removeLastNum), for: .touchUpInside)
        
    }
    
    @objc func clearButtonTapped() {
        currentPassword.isHidden = true
        makeColorCircle(0.3)
        staticPassword.removeAll()
    }
    
    @IBAction func confirmPassword(_ sender : UIButton) {
        if staticPassword.count == 4 {
            firstViewController?.staticPassword = staticPassword
            print("Пароль успешно изменен.")
        } else {
            print("Пароль не соответствует паролю")
        }
        self.dismiss(animated: true)
    }
    
    func makeColorCircle(_ alpha : Double = 1) {
        let circlesArray : [UIButton] = [firstCircle, secondCircle, thirdCircle, fourthCircle]
        for circle in 0..<staticPassword.count {
            circlesArray[circle].alpha = alpha
        }
    }
    
    func appendPassword(_ button : UIButton) {
        if staticPassword.count < 4 {
            if let title = button.titleLabel?.text {
                staticPassword.append(Int(title)!)
            }
        }
        
        if staticPassword.count == 4 {
            currentPassword.text = "Текущий пароль: \(staticPassword)"
            currentPassword.isHidden = false
        }
    }
    
    func makeEveryCircleGray() {
        let circlesArray : [UIButton] = [firstCircle, secondCircle, thirdCircle, fourthCircle]
        for circle in circlesArray {
            circle.alpha = 0.3
        }
    }
    
    @objc func numberTapped(_ sender : UIButton) {
        currentPassword.isHidden = true
        appendPassword(sender)
        makeColorCircle()
    }
    
    @objc func removeLastNum() {
        currentPassword.isHidden = true
        if !staticPassword.isEmpty {
            staticPassword.removeLast()
            makeEveryCircleGray()
            makeColorCircle()
        }
    }
}
