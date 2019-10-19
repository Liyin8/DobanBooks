//
//  UIAlartController.swift
//  DobanBooks
//
//  Created by 2017yd on 2019/10/19.
//  Copyright © 2019 2017yd. All rights reserved.
//

import UIKit
extension UIAlertController{
    static func showAlert(_ message:String,incontroller:UIAlertController){
        //警告框
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel))
        incontroller.present(alert, animated: true)
        
    }
    
    static func showConfirm(_message:String,incontorller:UIViewController,confirm:((UIAlertAction)->Void)?){
        //对话框
        let alert = UIAlertController(title: nil, message: _message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: confirm))
        incontorller.present(alert, animated: true)
        
    }
    
    static func showAlertAndDismiss(_ message:String,in controller:UIViewController,completion:(()->Void)? = nil){
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        controller.present(alert,animated: true,completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3, execute: {()->Void in controller.presentedViewController?.dismiss(animated: true, completion: completion)})
    }
}
