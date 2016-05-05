
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
        //pic = UIImage(CGImage: pic!.CGImage!, scale: 1, orientation: .Up)
        
        //        picView.image = pic

    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        if beenHereBefore{
//            
//            return;
//        } else {
//            beenHereBefore = true
//        }

        createImageView()
        
        
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
