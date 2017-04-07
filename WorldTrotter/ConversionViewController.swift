// IB


import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var fahrenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32) * (5/9)
        }
        else {
            return nil
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view")
        
        
        let date = Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([NSCalendar.Unit.hour], from: date)
        //Set background color accordingly
        let currentHour = components.hour
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        let color1 = UIColor(red: 255/255, green: 228/255, blue: 122/255, alpha: 1.0).cgColor as CGColor//morni
        let color2 = UIColor(red: 61/255, green: 126/255, blue: 170/255, alpha: 1.0).cgColor as CGColor//ng
        let color3 = UIColor(red: 230/255, green: 218/255, blue: 218/255, alpha: 1.0).cgColor as CGColor//eveni
        let color4 = UIColor(red: 39/255, green: 64/255, blue: 70/255, alpha: 1.0).cgColor as CGColor//ng
        
        if currentHour! <= 15 {
            gradientLayer.colors = [color3, color4]
            //self.view.layer.addSublayer(gradientLayer)
            view.layer.insertSublayer(gradientLayer, at:0)
            //self.view.backgroundColor = UIColor(red:0.09, green:0.13, blue:0.20, alpha:1.0) //a dark color
        } else {
            gradientLayer.colors = [color1, color2]
//            self.view.layer.addSublayer(gradientLayer)
            view.layer.insertSublayer(gradientLayer, at:0)
            //self.view.backgroundColor = UIColor(red:0.85, green:0.86, blue:0.90, alpha:1.0) //a light color
        }
        

    }
    
    @IBAction func dismissKeyboard(_ sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: value))
        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentLocale = Locale.current
        let decimalSeparator = (currentLocale as NSLocale).object(forKey: NSLocale.Key.decimalSeparator) as! String
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
        
        
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
            return false
        }
        else {
            return true
        }
    }
    
    @IBAction func fahrenheitFieldEditingChanges(_ textField: UITextField) {
        if let text = textField.text, let number = numberFormatter.number(from: text) {
            fahrenheitValue = number.doubleValue
        }
        else {
            fahrenheitValue = nil
        }
    }
    
}
