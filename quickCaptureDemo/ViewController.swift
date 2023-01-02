//
//  ViewController.swift
//  quickCaptureDemo
//
//  Created by cumulations on 22/12/22.
//

import UIKit
import quickCaptureFramework
import VisionKit
class ViewController: UIViewController {
    @IBOutlet weak var imageview: UIImageView!
    var images:[UIImage]?
    var image = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
//        print("imagess = \(images)")
        if(images?.count ?? 0 > 0){
        self.imageview.image = images?.last
        }
    }
    func configureDocument(){
        let frameworkBundle = Bundle(identifier: "com.cumulations.quickCaptureFramework")
        let storyboard = UIStoryboard(name: "main", bundle: frameworkBundle)
//        if #available(iOS 13.0, *) {
//            let vc = storyboard.instantiateViewController(withIdentifier: "documentcapture") as! DocumentCaptureViewController
//            vc.sender(sender: self)
//            vc.completionHandlerImages = {imagesArr in
//                self.images = imagesArr
////                print("completionHandler\(self.images)")
//            }
//            navigationController?.pushViewController(vc, animated: true)
//        } else {
        let vc  = storyboard.instantiateViewController(withIdentifier: "ImagepickerVC") as! customImagesViewController
        vc.sender(sender: self)
        vc.completionHandler = {imgs in
            self.images = imgs
        }
        navigationController?.pushViewController(vc, animated: true)
//        }
    }
    @IBAction func actionSaveImages(_ sender: Any) {
        if(self.images != nil){
        let object = saveImagesToLibrary()
            object.saveImages(imagesArray: images!) { Status in
                if(Status){
                    let alert = UIAlertController(title: "Alert", message: "Images saved successfully", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        else{
            let alert = UIAlertController(title: "Alert", message: "No images found", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func actionSavePdf(_ sender: Any) {
        if((images) != nil){
            let obj = SavePdfHandler()
            obj.SaveAsPdf(sender: sender, imagesArray: images!, viewcontroller: self)
        }
        else{
            let alert = UIAlertController(title: "Alert", message: "No images found", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func actionCapture(_ sender: Any) {
//        print("action capture")
        configureDocument()
    }
    
}

