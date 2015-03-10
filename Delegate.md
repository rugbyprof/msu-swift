
##### Method to not allow row to be selected so it won't turn gray.

```swift
override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
```

##### Make certain field get focus when view loads:

```swift
override func viewWillAppear(animated: Bool) {
```

#### Add "Done" and "Cancel" to your new ViewController

```swift
@IBAction func done(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
}


@IBAction func cancel(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
}
```

#### Must connect the text field to the `done()` action method.

Select the text field, then the `Connections Inspector`, then connect 
`Did End On Exit` by connecting it to the method.

### How to Become a Delegate

1. You declare yourself capable of being a delegate. To become the delegate

#### Make your controller a delegate for the text field (add `UITextFieldDelegate` to the end):

```
class DelegateViewController: UITableViewController, UITextFieldDelegate
```

"Now this class can be a delegate for Text Fields"

#### We still need to HOOK up the class to be a delegate.

#### Make a connection to the "Done" button:

```
@IBOutlet weak var doneBarButton: UIBarButtonItem!
```

#### Add this code to enable and disable done button if text box is empty or has data:

```swift
func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
```

## Important Stuff

#### Place this at top of DelegateViewController:

```swift
protocol DelegateItemViewControllerDelegate: class {
```

>A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol doesn’t actually provide an implementation for any of these requirements—it only describes what an implementation will look like. The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to conform to that protocol.

>Protocols can require that conforming types have specific instance properties, instance methods, type methods, operators, and subscripts.

#### The controller needs a property to `refer` to the delegate:

```swift
weak var delegate: DelegateViewControllerDelegate?
``` 

#### Replace the current `done` and `cancel` methods with these:

```swift
@IBAction func cancel() {
    
        
```

### Make MainViewController to Promise to handle stuff from the delegate:

```swift

```