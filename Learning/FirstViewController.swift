//
//  FirstViewController.swift
//  Learning
//
//  Created by Кирилл Сысоев on 31.07.24.
//

import UIKit

class FirstViewController: UIViewController {

        @IBOutlet weak var labelEnterPassword: UILabel!
        
        @IBOutlet weak var sucessfulLabel: UILabel!
        
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
        
        @IBOutlet weak var showPasswordButton: UIButton!
            
        @IBOutlet weak var currentPassword: UILabel!
        
    @IBOutlet weak var changePasswordButton: UIButton!
    
        var password : [Int] = []
        
        var staticPassword : [Int] = [1, 2, 3, 4]
        
        var countSameNumbers = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let numberButtons : [UIButton] = [numberOne, numberTwo, numberThree, numberFour, numberFive, numberSix, numberSeven, numberEight, numberNine, numberNull]
            
            for button in numberButtons {
                button.addTarget(self, action: #selector(numberTapped(_ :)), for: .touchUpInside)
            }
            
            clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
            removeLastNumber.addTarget(self, action: #selector(removeLastNum), for: .touchUpInside)
            showPasswordButton.addTarget(self, action: #selector(showCurrentPassword), for: .touchUpInside)
            changePasswordButton.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        }
        
        func hideMessageLabel(_ hide : Bool = true) {
                labelEnterPassword.isHidden = hide
        }
        
        @IBAction func backToEnteringPassword(_ sender : UIStoryboardSegue) {
            print("Вернулся на первый экран.")
        }
    
        @objc func changePassword() {
            print("Перешел на второй экран.")
            clearButtonTapped()
        }
    
        func showSuccessfulLabel(_ hide : Bool = false) {
            let circlesArray : [UIButton] = [firstCircle, secondCircle, thirdCircle, fourthCircle]
            sucessfulLabel.isHidden = hide
            for circle in circlesArray {
                circle.isHidden = !hide
            }
        }
        
        func appendPassword(_ button : UIButton) {
            if password.count < 4 {
                if let title = button.titleLabel?.text {
                    password.append(Int(title)!)
                }
            }
            
            if password.count == 4 {
                checkingPassword()
            }
        }
        
        func checkingPassword() {
            countSameNumbers = 0
            for number in 0..<staticPassword.count {
                if staticPassword[number] == password[number] {
                   countSameNumbers += 1
                }
            }
            if countSameNumbers < 4 {
                sucessfulLabel.text = "Неправильный пароль"
                showSuccessfulLabel()
            } else if countSameNumbers == 4 {
                 sucessfulLabel.text = "Вход выполнен успешно"
                 showSuccessfulLabel()
             }
        }
        
        @objc func clearButtonTapped() {
            currentPassword.isHidden = true
            showSuccessfulLabel(true)
            hideMessageLabel(false)
            makeColorCircle(0.3)
            password.removeAll()
            countSameNumbers = 0
        }
        
        func makeColorCircle(_ alpha : Double = 1) {
            let circlesArray : [UIButton] = [firstCircle, secondCircle, thirdCircle, fourthCircle]
            for circle in 0..<password.count {
                circlesArray[circle].alpha = alpha
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
            hideMessageLabel()
            appendPassword(sender)
            makeColorCircle()
        }
        
        @objc func showCurrentPassword() {
            currentPassword.isHidden = !currentPassword.isHidden
                currentPassword.text = "Текущий пароль: \(staticPassword)"
        }
        
        @objc func removeLastNum() {
            currentPassword.isHidden = true
            if !password.isEmpty {
                if password.last == staticPassword[password.count-1] {
                    countSameNumbers -= 1
                }
                password.removeLast()
                makeEveryCircleGray()
                makeColorCircle()
                showSuccessfulLabel(true)
            }
            
            if password.isEmpty {
                hideMessageLabel(false)
            }
        }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destinationVC = segue.destination as? secondViewController {
            destinationVC.firstViewController = self
            }
        }

    }

