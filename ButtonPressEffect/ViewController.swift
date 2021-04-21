//
//  ViewController.swift
//  ButtonPressEffect
//
//  Created by Gökhan Mandaci on 20.04.2021.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Parameters
    // Options Test Parameters
    private var touchDownDuration: TimeInterval = 0.1
    private var touchUpDuration: TimeInterval = 0.1
    private var touchDownScaleX: CGFloat = 0.9
    private var touchDownScaleY: CGFloat = 0.9
    private var touchUpScaleX: CGFloat?
    private var touchUpScaleY: CGFloat?
    private var touchDownAlpha: CGFloat = 0.8
    private var touchUpAlpha: CGFloat = 1
    // Animation Options Test Parameters
    private var touchDownDelay: TimeInterval = 0
    private var touchDownUsingSpringWithDamping: CGFloat = 1.0
    private var touchDownInitialSpringVelocity: CGFloat = 1.0
    private var touchDownOptions: UIView.AnimationOptions = .curveLinear
    private var touchUpDelay: TimeInterval = 0
    private var touchUpUsingSpringWithDamping: CGFloat = 1.0
    private var touchUpInitialSpringVelocity: CGFloat = 1.0
    private var touchUpOptions: UIView.AnimationOptions = .curveLinear
    // 4 of the UIView.AnimationOptions added for testing purposes.
    var picker: UIPickerView?
    private let pickerOptions: [[String: UIView.AnimationOptions]] = [["CurveEaseIn": .curveEaseIn],
                                                        ["CurveEaseOut": .curveEaseOut],
                                                        ["CurveEaseInOut": .curveEaseInOut],
                                                        ["CurveLinear": .curveLinear]]
    private var pickerForDown: Bool = true
    
    // MARK: - Outlets
    // Press Effect Outlets
    @IBOutlet weak var segOptions: UISegmentedControl!
    @IBOutlet weak var stkPressEffectParams: UIStackView!
    @IBOutlet weak var stkAnimationParams: UIStackView!
    @IBOutlet weak var txtTouchDownDuration: UITextField!
    @IBOutlet weak var txtTouchUpDuration: UITextField!
    @IBOutlet weak var txtTouchDownAlpha: UITextField!
    @IBOutlet weak var txtTouchUpAlpha: UITextField!
    @IBOutlet weak var txtTouchDownScaleX: UITextField!
    @IBOutlet weak var txtTouchDownScaleY: UITextField!
    @IBOutlet weak var txtTouchUpScaleX: UITextField!
    @IBOutlet weak var txtTouchUpScaleY: UITextField!
    // Animation Options Outlets
    @IBOutlet weak var txtTouchDownDelay: UITextField!
    @IBOutlet weak var txtTouchUpDelay: UITextField!
    @IBOutlet weak var txtTouchDownUsingSpringWithDamping: UITextField!
    @IBOutlet weak var txtTouchUpUsingSpringWithDamping: UITextField!
    @IBOutlet weak var txtTouchDownInitialSpringVelocity: UITextField!
    @IBOutlet weak var txtTouchUpInitialSpringVelocity: UITextField!
    @IBOutlet weak var btnTouchDownOptions: UIButton!
    @IBOutlet weak var btnTouchUpOptions: UIButton!
    @IBOutlet weak var sldOnView: UISwitch!
    // Test Views
    @IBOutlet weak var vwTest: UIView!
    @IBOutlet weak var btnTest: PEButton!
    @IBOutlet weak var btnSetParameters: UIButton!
    
    // MARK: - Actions
    @IBAction func segOptionsAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            stkAnimationParams.isHidden = true
            stkPressEffectParams.isHidden = false
            btnSetParameters.setTitle("Set Press Effect Options", for: .normal)
        } else {
            stkPressEffectParams.isHidden = true
            stkAnimationParams.isHidden = false
            btnSetParameters.setTitle("Set Animation Options", for: .normal)
        }
    }
    @IBAction func sldOnViewAction(_ sender: UISwitch) {
        if sender.isOn {
            // Activates animation on a given view.
            btnTest.activate(on: vwTest)
        } else {
            // By default activates animation on button.
            btnTest.activate()
        }
    }
    @IBAction func setConfigParametersAction(_ sender: Any) {
        if segOptions.selectedSegmentIndex == 0 {
            setPressEffectParameters()
            setOptions()
        } else {
            setAnimationParameters()
            setAnimationOptions()
        }
    }
    @IBAction func btnTestAction(_ sender: PEButton) {
        sender.pressEffect {
            print("Hello World!")
        }
    }
    @IBAction func btnTouchDownOptionsAction(_ sender: Any) {
        pickerForDown = true
        showPicker()
    }
    @IBAction func btnTouchUpOptionsAction(_ sender: Any) {
        pickerForDown = false
        showPicker()
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Activate animation on button
        btnTest.activate()
        
    }
}

// MARK: - Class Methods
extension ViewController {
    private func setPressEffectParameters() {
        if let tdDuration = txtTouchDownDuration.text,
           !tdDuration.isEmpty {
            touchDownDuration = Double(tdDuration) ?? 0.1
        }
        if let tuDuration = txtTouchUpDuration.text,
           !tuDuration.isEmpty {
            touchUpDuration = Double(tuDuration) ?? 0.1
        }
        if let tdScaleX = txtTouchDownScaleX.text,
           !tdScaleX.isEmpty {
            touchDownScaleX = CGFloat(Double(tdScaleX) ?? 0.9)
        }
        if let tdScaleY = txtTouchDownScaleY.text,
           !tdScaleY.isEmpty {
            touchDownScaleY = CGFloat(Double(tdScaleY) ?? 0.9)
        }
        if let tuScaleX = txtTouchUpScaleX.text,
           !tuScaleX.isEmpty {
            touchUpScaleX = CGFloat(Double(tuScaleX) ?? 1)
        } else {
            // touchUpScaleX can be nil which will works as transform .identity
            touchUpScaleX = nil
        }
        if let tuScaleY = txtTouchUpScaleY.text,
           !tuScaleY.isEmpty {
            touchUpScaleY = CGFloat(Double(tuScaleY) ?? 1)
        } else {
            // touchUpScaleY can be nil which will works as transform .identity
            touchUpScaleY = nil
        }
        if let tdAlpha = txtTouchDownAlpha.text,
           !tdAlpha.isEmpty {
            touchDownAlpha = CGFloat(Double(tdAlpha) ?? 0.8)
        }
        if let tuAlpha = txtTouchUpAlpha.text,
           !tuAlpha.isEmpty {
            touchUpAlpha = CGFloat(Double(tuAlpha) ?? 1)
        }
    }
    
    private func setAnimationParameters() {
        if let tdDelay = txtTouchDownDelay.text,
           !tdDelay.isEmpty {
            touchDownDelay = Double(tdDelay) ?? 0.0
        }
        if let tuDelay = txtTouchUpDelay.text,
           !tuDelay.isEmpty {
            touchUpDelay = Double(tuDelay) ?? 0.0
        }
        if let tdSpring = txtTouchDownUsingSpringWithDamping.text,
           !tdSpring.isEmpty {
            touchDownUsingSpringWithDamping = CGFloat(Double(tdSpring) ?? 1.0)
        }
        if let tuSpring = txtTouchUpUsingSpringWithDamping.text,
           !tuSpring.isEmpty {
            touchUpUsingSpringWithDamping = CGFloat(Double(tuSpring) ?? 1.0)
        }
        if let tdVelocity = txtTouchDownInitialSpringVelocity.text,
           !tdVelocity.isEmpty {
            touchDownInitialSpringVelocity = CGFloat(Double(tdVelocity) ?? 1.0)
        }
        if let tuVelocity = txtTouchUpInitialSpringVelocity.text,
           !tuVelocity.isEmpty {
            touchUpInitialSpringVelocity = CGFloat(Double(tuVelocity) ?? 1.0)
        }
    }
    
    private func setOptions() {
        // Example Usage 1 - For the test app we will update all config parameters
        btnTest.options = PEOptions(touchDownDuration: touchDownDuration,
                                    touchUpDuration: touchUpDuration,
                                    touchDownScaleX: touchDownScaleX,
                                    touchDownScaleY: touchDownScaleY,
                                    touchUpScaleX: touchUpScaleX,
                                    touchUpScaleY: touchUpScaleY,
                                    touchDownAlpha: touchDownAlpha,
                                    touchUpAlpha: touchUpAlpha)
        
        // Example Usage 2
//        btnTest.options = PEOptions(touchDownScaleY: touchDownScaleY,
//                                    touchUpScaleX: touchUpScaleX)
        
        // Example Usage 3
//        btnTest.options.touchDownAlpha = 0.4
        
        // Example Usage 4
//        var options = PEOptions()
//        options.touchDownDuration = 2
//        btnTest.options = options
        
        view.endEditing(true)
        
        let alertController = UIAlertController(title: "Ready",
                                                message: "Press effect parameters set.",
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Okay", style: .default))
        self.present(alertController, animated: true)
    }
    
    private func setAnimationOptions() {
        // Example Usage 1 - For the test app we will update all config parameters
        btnTest.animationOptions = PEAnimationOptions(touchDownDelay: touchDownDelay,
                                                      touchDownUsingSpringWithDamping: touchDownUsingSpringWithDamping,
                                                      touchDownInitialSpringVelocity: touchDownInitialSpringVelocity,
                                                      touchDownOptions: touchDownOptions,
                                                      touchUpDelay: touchUpDelay,
                                                      touchUpUsingSpringWithDamping: touchUpUsingSpringWithDamping,
                                                      touchUpInitialSpringVelocity: touchUpInitialSpringVelocity,
                                                      touchUpOptions: touchUpOptions)
        
        // Example Usage 2
//        btnTest.animationOptions = PEAnimationOptions(touchDownDelay: touchDownDelay,
//                                                      touchUpDelay: touchUpDelay)
        
        // Example Usage 3
//        btnTest.animationOptions.touchDownDelay = 0.4
        
        // Example Usage 4
//        var options = PEAnimationOptions()
//        options.touchDownOptions = .curveLinear
//        btnTest.options = options
        
        view.endEditing(true)
        
        let alertController = UIAlertController(title: "Ready",
                                                message: "Animation parameters set.",
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Okay", style: .default))
        self.present(alertController, animated: true)
    }
    
    private func showPicker() {
        picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 250))
        picker!.delegate = self
        picker!.dataSource = self
        picker!.backgroundColor = .white
        view.addSubview(picker!)
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerOptions.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        guard let str = pickerOptions[row].keys.first else { return ""}
        return str
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let opt = pickerOptions[row].values.first {
            if pickerForDown {
                btnTouchDownOptions.setTitle(pickerOptions[row].keys.first ?? "", for: .normal)
                touchDownOptions = opt
            } else {
                btnTouchUpOptions.setTitle(pickerOptions[row].keys.first ?? "", for: .normal)
                touchUpOptions = opt
            }
        }
        if picker != nil {
            picker?.removeFromSuperview()
        }
    }
}
