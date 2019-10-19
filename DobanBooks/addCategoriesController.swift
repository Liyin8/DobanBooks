//
//  addCategoriesController.swift
//  DobanBooks
//
//  Created by 2017yd on 2019/10/19.
//  Copyright © 2019 2017yd. All rights reserved.
//

import UIKit

let imgDir = "/Documents/"

class addCategoriesController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    var selectedImge : UIImage?
    let factory = CategoryFactory.getInstance(UIApplication.shared.delegate as! AppDelegate)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func categorySava() {
        let name = txtName.text
        if name == nil || name!.count == 0 {
            
        }
        let categoty = VMCategory()
        categoty.name = name
        categoty.image = categoty.id.uuidString + ".jpg"
        let (success,info) = factory.addCategory(category: categoty)
        if !success {
          UIAlertController.showAlertAndDismiss("类别不能为空", in: self)
        }
//        if selectedImge ==  {
//            <#code#>
//        }
        saveImage(image: selectedImge!, fileNmae: categoty.image!)
    }
    
    func saveImage (image: UIImage, fileNmae : String){
        //compressionQuality 压缩率
        if let imgData = image.jpegData(compressionQuality: 1) as NSData? {
            let path = NSHomeDirectory().appending(imgDir).appending(fileNmae)
            imgData.write(toFile: path, atomically: true)
        }
    }
    
    @IBAction func pickfromPhotolibrary(_ sender: Any) {
        let imgController = UIImagePickerController()
        imgController.sourceType = .photoLibrary
        imgController.delegate  = self
       
        ///自带对话框
        present(imgController, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imgCover.image = image
        selectedImge = image
        dismiss(animated: true, completion: nil)
    }
}
