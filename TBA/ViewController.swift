
import UIKit
import MobileCoreServices

@objc class ViewController: UIViewController,
UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    /* We will use this variable to determine if the viewDidAppear:
     method of our view controller is already called or not. If not, we will
     display the camera view */
    var beenHereBefore = false
    var controller: UIImagePickerController?
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String: AnyObject]){
        
//        if let mediaType = info[UIImagePickerControllerMediaType] as? String {
//            if mediaType == kUTTypeImage {
//                /* Let's get the metadata. This is only for images. Not videos */
//                let metadata = info[UIImagePickerControllerMediaMetadata]
//                    as? NSDictionary
//                if let theMetaData = metadata{
//                    let image = info[UIImagePickerControllerOriginalImage]
//                        as? UIImage
//                    if let theImage = image{
//                        print("Image Metadata = \(theMetaData)")
//                        print("Image = \(theImage)")
//                        // Define the specific path, image name
//                        
//                        let imagePath = fileInDocumentsDirectory("dd")
//                        saveImage(image!, path: imagePath)
//                        loadImageFromPath(imagePath)
//                    }
//                }
//            }
//        }
//        
//        picker.dismissViewControllerAnimated(true, completion: nil);
//        
//        
//        let imagePath = fileInDocumentsDirectory("dd")
//        var pic = loadImageFromPath(imagePath)
        
        
        
        

        
        
        
        //let width = UIScreen.mainScreen().bounds.size.width
        //let height = UIScreen.mainScreen().bounds.size.height
//        let height = self.view.frame.size.height
//        let width = self.view.frame.size.width
        
        
        //var picView:UIImageView = UIImageView(image: pic)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            //        var picView = UIImageView(frame: CGRectMake(0, 0, width, height))
            let picView = UIImageView(image: image)
            self.view.addSubview(picView)
            picView.translatesAutoresizingMaskIntoConstraints = false
            picView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
            picView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
            picView.heightAnchor.constraintEqualToAnchor(view.heightAnchor, multiplier: 0.5).active = true
            picView.widthAnchor.constraintEqualToAnchor(picView.heightAnchor).active = true
            picView.contentMode = .ScaleAspectFit
            //pic = UIImage(CGImage: pic!.CGImage!, scale: 1, orientation: .Up)
            
            //        picView.image = pic

        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("Picker was cancelled")
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func isCameraAvailable() -> Bool{
        return UIImagePickerController.isSourceTypeAvailable(.Camera)
    }
    
    func cameraSupportsMedia(mediaType: String,
                             sourceType: UIImagePickerControllerSourceType) -> Bool{
        
        let availableMediaTypes =
            UIImagePickerController.availableMediaTypesForSourceType(sourceType) as
                [String]?
        
        if let types = availableMediaTypes{
            for type in types{
                if type == mediaType{
                    return true
                }
            }
        }
        
        return false
    }
    
    func doesCameraSupportTakingPhotos() -> Bool{
        return cameraSupportsMedia(kUTTypeImage as String, sourceType: .Camera)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if beenHereBefore{
        
            return;
        } else {
            beenHereBefore = true
        }
        
        if isCameraAvailable() && doesCameraSupportTakingPhotos(){
            
            controller = UIImagePickerController()
            
            if let theController = controller{
                theController.sourceType = .Camera
                
//                theController.mediaTypes = [kUTTypeImage as String]
                
                theController.allowsEditing = false
                theController.delegate = self
                
                presentViewController(theController, animated: true, completion: nil)
            }
            
        } else {
            print("Camera is not available")
        }
        
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
        print("Loading image from path: \(path)") // this is just for you to see the path in case you want to go to the directory, using Finder.
        return image
        
    }
    

    
    
    

    
   
}

