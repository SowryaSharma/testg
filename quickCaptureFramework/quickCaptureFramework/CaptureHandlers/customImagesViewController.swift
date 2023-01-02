//
//  customImagesViewController.swift
//  QuickCapture
//
//  Created by cumulations on 20/12/22.
//

import UIKit

public class customImagesViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageview: UIImageView!
    var imgArray = NSMutableArray()
    var controller:UIViewController?
    public var completionHandler:(([UIImage]?)->Void)?
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    public override func viewWillAppear(_ animated: Bool) {
        //        handleAuthorisedd()
        HandleUI(controller: controller!)
        navigationController?.navigationBar.isHidden = true
//        print(navigationController?.viewControllers)
    }
    public func sender(sender:UIViewController){
//        print("sender = \(sender.title)")
        self.controller = sender
    }
    public func HandleUI(controller:UIViewController){
//        print("controller.title=\(controller.title),\(controller)")
//        let vc  =  EditScanViewController()
//        print(controller,vc)
        if(controller == self){
//            print(controller)
            navigationController?.popViewController(animated: false)
        }
        else{
            handleAuthorisedd()
        }
    }
    func handleAuthorisedd(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = false
        vc.delegate = self
        present(vc, animated: false)
    }
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: false)
//        print(info)
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        let DocumentDirectory = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        let DirPath = DocumentDirectory.appendingPathComponent("QuickCapture\(Date())")
        let data = image.jpegData(compressionQuality:  1)
        do
        {
            try FileManager.default.createDirectory(atPath: DirPath!.path, withIntermediateDirectories: false, attributes: nil)
        }
        catch let error as NSError
        {
            print("Unable to create directory \(error.debugDescription)")
        }
        print("Path = \(DirPath!)")
        
        let docURL = DirPath!.appendingPathComponent("Scanned-Docs\(Date()).pdf")
        
        do{
            try data?.write(to: docURL)
            print(docURL)
        }catch(let error){
            print("error is \(error.localizedDescription)")
        }
//        print(image.size)
//        self.imgArray.append(image)
        let vc = storyboard?.instantiateViewController(withIdentifier: "cropVC") as! cropViewController
        vc.saveData2(image: image)
        vc.completionHandler = {status in
            self.completionHandler?(ImagesDataModel.shared.ImagesArray)
            ImagesDataModel.shared.ImagesArray.removeAll()
        }
        navigationController?.pushViewController(vc, animated: false)
    }
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        navigationController?.popViewController(animated: true)
    }
}
