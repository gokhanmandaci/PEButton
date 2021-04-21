# PEButton
A Button class that has a configurable press effect.

You can configure the press effect and the animation options as you wish.

Built using XCode 12.4 (Swift 5)

## Example

To run the example project, clone the repo and open `ButtonPressEffect` test project. Run-on a simulator or your device to configure the animation.

## Installation

### Manual

1. Clone this repo
2. Navigate to the project folder
3. Copy `Source` to your project

## Usage
1. Add the `Source` folder to your project.
2. Create a button using a storyboard or programmatically. Use Class named `PEButton`.
3. Update configuration parameters if necessary. Detailed usage example added.
4. Activate press effect with `Button.activate()`
5. You can add a pressing effect to views while activation.
6. On your `Button` target, use `Button.pressEffect { // Callback - Animation has finished. }`

### Configuration

#### Basic Usage

```
@IBOutlet weak var peButton: PEButton!
@IBAction func peButtonAction(_ sender: PEButton) {
    sender.pressEffect {
        // Code
    }
}
override func viewDidLoad() {
    super.viewDidLoad()
    
    // Button animates
    peButton.activate()
    
    // Custom View animates when peButton clicked
    peButton.activate(on: customView)
}

// For deactivation call
peButton.deactivate()
```

#### Customized Usage

```
@IBOutlet weak var peButton: PEButton!
@IBAction func btnTestAction(_ sender: PEButton) {
    sender.pressEffect {
        // Code
    }
}
override func viewDidLoad() {
    super.viewDidLoad()
    
    // Button animates
    peButton.activate()
    
    // Customization methods of Press Effect Options
    // Set all options with a PEOptions instance
    peButton.options = PEOptions(touchDownDuration: customDurationValue,
                                touchUpDuration: customDurationValue,
                                touchDownScaleX: customScaleXValue,
                                touchDownScaleY: customScaleYValue,
                                touchUpScaleX: customScaleXValue,
                                touchUpScaleY: customScaleYValue,
                                touchDownAlpha: customAlphaValue,
                                touchUpAlpha: customAlphaValue)
                                
    // Set some options with a PEOptions instance
    peButton.options = PEOptions(touchDownDuration: customDurationValue,
                                touchUpDuration: customDurationValue,
                                touchUpAlpha: customAlphaValue)
                                
    // Update default values directly
    peButton.options.touchDownAlpha = customAlphaValue
                        
    // Customization methods of Press Animation Options
    // Set all options with a PEAnimationOptions instance
    peButton.animationOptions = PEAnimationOptions(touchDownDelay: customDelayValue,
                                                  touchDownUsingSpringWithDamping: customUsingSpringWithDampingValue,
                                                  touchDownInitialSpringVelocity: customInitialSpringVelocityValue,
                                                  touchDownOptions: customOptions,
                                                  touchUpDelay: customDelayValue,
                                                  touchUpUsingSpringWithDamping: customUsingSpringWithDampingValue,
                                                  touchUpInitialSpringVelocity: customInitialSpringVelocityValue,
                                                  touchUpOptions: customOptions)
                                                  
                                                  
    // Set some options with a PEAnimationOptions instance
    peButton.animationOptions = PEAnimationOptions(touchDownDelay: customDelayValue,
                                                  touchDownUsingSpringWithDamping: customUsingSpringWithDampingValue,
                                                  touchUpOptions: customOptions)
                                                  
    // Update default values directly
    peButton.animationOptions.touchDownDelay = customDelayValue
}

```

## Configuration Parameters

We have two types of configuration parameters. One of them configures press effect, another type configures animation and duration.

### Press Effect Configuration Parameters:
```
/// Duration of down scale animation. Default value = 0.1
var touchDownDuration: TimeInterval = 0.1
/// Duration of up scale animation. Default value = 0.1
var touchUpDuration: TimeInterval = 0.1
    
/// Scale factor for X axis. Touch Down. Default 0.9
var touchDownScaleX: CGFloat = 0.9
/// Scale factor for Y axis. Touch Down. Default 0.9
var touchDownScaleY: CGFloat = 0.9
/// Scale factor for X axis. Touch Up. Default 0.9
var touchUpScaleX: CGFloat?
/// Scale factor for Y axis. Touch Up. Default 0.9
var touchUpScaleY: CGFloat?
    
/// Touch down alpha value. Default 0.8
var touchDownAlpha: CGFloat = 0.8
/// Touch down alpha value. Default 1
var touchUpAlpha: CGFloat = 1
```

### Press Animation Configuration Parameters:
```
/// Delays down animation if necessary. Default 0
var touchDownDelay: TimeInterval = 0
/// Down spring with damping value. Default 1.0
var touchDownUsingSpringWithDamping: CGFloat = 1.0
/// Down initial spring velocity value. Default 1.0
var touchDownInitialSpringVelocity: CGFloat = 1.0
/// Down animation option. Default .curveEaseInOut
var touchDownOptions: UIView.AnimationOptions = .curveEaseInOut
/// Delays up animation if necessary. Default 0
var touchUpDelay: TimeInterval = 0
/// Up spring with damping value. Default 1.0
var touchUpUsingSpringWithDamping: CGFloat = 1.0
/// Up initial spring velocity value. Default 1.0
var touchUpInitialSpringVelocity: CGFloat = 1.0
/// Up animation option. Default .curveEaseInOut
var touchUpOptions: UIView.AnimationOptions = .curveEaseInOut
```
