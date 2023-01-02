////
////  EditScanViewController.swift
////  QuickCapture
////
////  Created by cumulations on 21/12/22.
////
//
//import UIKit
//import PDFKit
//public class EditScanViewController: UIViewController {
//    var cameraView = customImagesViewController()
//    public var completionHandler:((UIImage?)->Void)?
//    var i = 0
//    @IBOutlet weak var imageview: UIImageView!
//    var image:UIImage?
//    var imagesArray = [UIImage]()
//    public override func viewDidLoad() {
//        super.viewDidLoad()
//        if let image = image{
//            self.imageview.image = image
//        }
//    }
//    public func saveData(image:UIImage){
//        self.image = image
//        completionHandler?(image)
//        let faces = detectImages(images: image) ?? nil
//        guard let face = faces else{return}
//        if(face.count>0){
//            let width = face[0].bounds.width
//            let height = face[0].bounds.height
//            let x = face[0].bounds.minX
//            let y = face[0].bounds.minY
//
//            let rect = CGRect(x: x, y: y, width: width, height: height)
////            let rect = face[0].bounds
////            print(rect)
////            print(image.size)
//        guard let cimage = image.cgImage else{return}
//        let imageRef: CGImage = cimage.cropping(to: rect)!
//        let imagea: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
//        self.image = imagea
//        }
//        else{
//            self.image = image
//        }
//        self.imagesArray.append(image)
//    }
//    func detectImages(images:UIImage) -> [CIFeature]?{
//        print(images)
//        guard let CImage = CIImage(image: images) else {
//            return nil
//        }
//        let DocumentDetector = CIDetector(ofType: CIDetectorTypeRectangle, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])
//        let Documents = DocumentDetector!.features(in: CImage)
//        print("\(Documents)")
//        return Documents
//    }
//    func saveImagetodirectory(){
//        do {
//            // get the documents directory url
//            let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//            print("documentsDirectory:", documentsDirectory.path)
//            // choose a name for your image
//            let fileName = "image\(i).jpg"
//            i+=1
//            // create the destination file url to save your image
//            let fileURL = documentsDirectory.appendingPathComponent(fileName)
//            // get your UIImage jpeg data representation and check if the destination file url already exists
//            if let data = image?.jpegData(compressionQuality:  1),
//               !FileManager.default.fileExists(atPath: fileURL.path) {
//                // writes the image data to disk
//                try data.write(to: fileURL)
//                print("file saved")
//            }
//        } catch {
//            print("error:", error)
//        }
//    }
//    @IBAction func addmoreImages(_ sender: Any) {
//        //        cameraView.handleAuthorisedd()
//        navigationController?.popViewController(animated: true)
//    }
//
//    @IBAction func saveImages(_ sender: Any) {
//        saveImagetodirectory()
//        //        navigationController?.popViewController(animated: true)
//        let vc2  = storyboard?.instantiateViewController(withIdentifier: "customimg") as! customImagesViewController
//        vc2.sender(sender: self)
//        guard let navigationController = navigationController else {return}
//        let count = navigationController.viewControllers.count
//        var navigationarray = navigationController.viewControllers
//        if(count >= 2){
//            navigationarray.remove(at: count-2)
//        }
//        navigationController.viewControllers = navigationarray
//        navigationController.popViewController(animated: false)
//        print("EditScanViewController->Images array = \(imagesArray)")
//        //        let vc = storyboard?.instantiateViewController(withIdentifier: "lower") as! imagepickerViewController
//        //        navigationController?.pushViewController(vc, animated: false)
//    }
//    /*
//     // MARK: - Navigation
//
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     // Get the new view controller using segue.destination.
//     // Pass the selected object to the new view controller.
//     }
//     */
//
//}
