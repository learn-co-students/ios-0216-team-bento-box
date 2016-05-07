
import UIKit
import MobileCoreServices

@objc class ViewController: UIViewController,
UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var picView = UIImageView(image:UIImage(named:"default"))
    
    var beenHereBefore = false
    var controller: UIImagePickerController?
    
    
    
    
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String: AnyObject]){
        // Saving an opening pics; Want to use the time stamp to name pics with unique id
//                        let metadata = info[UIImagePickerControllerMediaMetadata]
//                            as? NSDictionary
//                        if let theMetaData = metadata{
//                            let image = info[UIImagePickerControllerOriginalImage]
//                                as? UIImage
//                            if let theImage = image{
//                                print("Image Metadata = \(theMetaData)")
//                                print("Image = \(theImage)")
//                                // Define the specific path, image name
//        
//                                let imagePath = fileInDocumentsDirectory("dd")
//                                saveImage(image!, path: imagePath)
//                                loadImageFromPath(imagePath)
//        
//        
//        
//                let imagePath = fileInDocumentsDirectory("dd")
//                var pic = loadImageFromPath(imagePath)
        
        
        //var picView:UIImageView = UIImageView(image: pic)
        
        //end of comment
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            

            picView.image =  image
            
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("Picker was cancelled")
        picker.dismissViewControllerAnimated(true, completion: nil)
        [submitButtonTapped()];
    }
    
    func createImageView()
    {
        self.view.addSubview(picView)
        picView.translatesAutoresizingMaskIntoConstraints = false
        picView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        picView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        picView.heightAnchor.constraintEqualToAnchor(view.heightAnchor, multiplier: 0.5).active = true
        picView.widthAnchor.constraintEqualToAnchor(picView.heightAnchor).active = true
        picView.contentMode = .ScaleAspectFit
        
        picView.userInteractionEnabled = true;

        //pic = UIImage(CGImage: pic!.CGImage!, scale: 1, orientation: .Up)
        
        //        picView.image = pic

    }
    
    func buildNavButtons() -> Void {
//        - (void)setFontsStyle {
//            

        let backButton = UIButton()
        let submitButton = UIButton()
        
        backButton.setTitle("Back", forState: .Normal)
        submitButton.setTitle("Submit", forState: .Normal)
        
        

        self.view.addSubview(submitButton);
        self.view.addSubview(backButton);
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        //            [self.submitButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-40].active = YES;
        
        submitButton.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor, constant: -40).active=true
        //            [self.submitButton.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:.25].active = YES;
        submitButton.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier:0.25).active=true

        
        //            [self.submitButton.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:.05].active = YES;
        
        
        submitButton.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.05).active=true
        //            [self.submitButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
        submitButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true

//            [self.backButton.bottomAnchor constraintEqualToAnchor:self.submitButton.topAnchor constant:-20].active = YES;
        
            backButton.bottomAnchor.constraintEqualToAnchor(submitButton.topAnchor, constant: -20).active = true
//            [self.backButton.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:.25].active = YES;
            backButton.widthAnchor .constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.25).active = true
//            [self.backButton.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:.05].active = YES;
            backButton.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.05).active = true
//            [self.backButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
            backButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        
        //            self.howQuestionTextLabel.font = [UIFont fontWithName:@"Baskerville" size:20];
        
        //
            submitButton.titleLabel!.font = UIFont(name: "Baskerville", size:20)
            backButton.titleLabel!.font = UIFont(name:"Baskerville", size:20)
        
        let buttonTitleColor = UIColor(red:255/255,green:254/255,blue:245.0/255.0, alpha:1)
        backButton.setTitleColor(buttonTitleColor, forState: .Normal)
        submitButton.setTitleColor(buttonTitleColor, forState: .Normal)
     
        
                    backButton.layer.cornerRadius = 12
                    backButton.clipsToBounds = true
        
                    submitButton.layer.cornerRadius = 12
                    submitButton.clipsToBounds = true
                    backButton.layer.borderWidth = 1
                    backButton.layer.borderColor = UIColor.whiteColor().CGColor
                    submitButton.layer.borderWidth = 1
                    submitButton.layer.borderColor = UIColor.whiteColor().CGColor
        

        let buttonBGColor = UIColor(red: 255/255, green: 254/255, blue: 245/255, alpha: 0.25)
        backButton.backgroundColor = buttonBGColor
        submitButton.backgroundColor = buttonBGColor
        
        let gr = UITapGestureRecognizer.init(target:self, action:#selector(submitButtonTapped))
        submitButton.addGestureRecognizer(gr);

    }
    
    
    func buildRedSubmitButton(){
        let picGR = UITapGestureRecognizer(target: self, action:#selector(picTapped));
        picView.addGestureRecognizer(picGR);
        let submitButton = UIButton();
        self.view.addSubview(submitButton);
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor , constant:20).active = true
        submitButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        submitButton.heightAnchor.constraintEqualToAnchor(view.heightAnchor, multiplier: 0.1).active = true
        submitButton.widthAnchor.constraintEqualToAnchor(picView.heightAnchor).active = true
        submitButton.backgroundColor = UIColor.redColor()
        submitButton.setTitle("Submit", forState: .Normal)
        let gr = UITapGestureRecognizer.init(target:self, action:#selector(submitButtonTapped))
        
        submitButton.addGestureRecognizer(gr);
    }
    
    func makeBackground() {

        self.view.backgroundColor = UIColor(red: 127/255, green: 235/255, blue: 197/255, alpha:1)
        


        let gradientMaskLayer = UIColor(red: 41/255,green:166/255,blue:122/255, alpha:1.0)
        
let gradientMask = CAGradientLayer();
gradientMask.frame = self.view.bounds;
gradientMask.colors = [gradientMaskLayer.CGColor,UIColor.clearColor().CGColor]
self.view.layer.insertSublayer(gradientMask, atIndex:0);

    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        if beenHereBefore{
//
//            return;
//        } else {
//            beenHereBefore = true
//        }
        makeBackground()
        createImageView()
        buildNavButtons()
        
        
        
    }
    
    //Writing to and reading from the documents folder
    func saveImage (image: UIImage, path: String ) -> Bool{
        
        let pngImageData = UIImagePNGRepresentation(image)
        let result = pngImageData!.writeToFile(path, atomically: true)
        
        return result
        
    }
    
    
    
    func getDocumentsURL() -> NSURL {
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        return documentsURL
    }
    
    func fileInDocumentsDirectory(filename: String) -> String {
        
        let fileURL = getDocumentsURL().URLByAppendingPathComponent(filename)
        return fileURL.path!
        
    }
    
    func loadImageFromPath(path: String) -> UIImage? {
        
        let image = UIImage(contentsOfFile: path)
        
        if image == nil {
            
            print("missing image at: \(path)")
        }
        print("Loading image from path: \(path)") 
        return image
        
    }
    
    
    func submitButtonTapped() -> Void {
        NSNotificationCenter.defaultCenter().postNotificationName("submitButtonHit", object:self)
    }
    
    func picTapped() -> Void {
        controller = UIImagePickerController()
        controller!.sourceType = .Camera
        controller!.allowsEditing = false
        controller!.delegate = self
        presentViewController(controller!, animated: true, completion: nil)
    }
    
    
    
    
}
