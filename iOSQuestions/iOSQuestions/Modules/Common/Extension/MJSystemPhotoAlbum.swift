//
//  MJSystemPhotoAlbum.swift
//  MicroCoupletTaxi
//
//  Created by 郭明健 on 2020/9/11.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

import UIKit
import Photos

/// 拍照+打开相册
class MJSystemPhotoAlbum: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    typealias GetImageBlock = (_ image: UIImage) -> ()
    var getImageBlock: GetImageBlock?
    
    /// 相机拍照后，是否允许编辑图片
    var cameraIsAllowsEditing: Bool = true
    /// 相册选择照片后，是否允许编辑图片
    var photoIsAllowsEditing: Bool = true
    
    /// 单例
    static let shared: MJSystemPhotoAlbum = {
        let shared = MJSystemPhotoAlbum()
        return shared
    }()
    
    //MARK:- 相机权限
    /// 相机权限
    class func cameraPermissions(authorizedBlock: (()->())?,
                                 deniedBlock: (()->())?) {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        // .notDetermined  .authorized  .restricted  .denied
        if authStatus == .notDetermined {
            // 第一次触发授权 alert
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                self.cameraPermissions(authorizedBlock: authorizedBlock, deniedBlock: deniedBlock)
            })
        } else if authStatus == .authorized {
            if authorizedBlock != nil {
                authorizedBlock!()
            }
        } else {
            if deniedBlock != nil {
                deniedBlock!()
            }
        }
    }
    
    //MARK:- 相册权限
    /// 相册权限
    class func photoAlbumPermissions(authorizedBlock: (()->())?,
                                     deniedBlock: (()->())?) {
        let authStatus = PHPhotoLibrary.authorizationStatus()
        // .notDetermined  .authorized  .restricted  .denied
        if authStatus == .notDetermined {
            // 第一次触发授权 alert
            PHPhotoLibrary.requestAuthorization { (status:PHAuthorizationStatus) -> Void in
                self.photoAlbumPermissions(authorizedBlock: authorizedBlock, deniedBlock: deniedBlock)
            }
        } else if authStatus == .authorized {
            if authorizedBlock != nil {
                authorizedBlock!()
            }
        } else {
            if deniedBlock != nil {
                deniedBlock!()
            }
        }
    }
    
    //MARK:- 屏幕底部弹窗
    
    // =======（PS:UIAlertAction 存在约束冲突Bug）=======
    
    /// 拍照、相册、取消（不区分图片来自哪里）
    func showBottomAlert(getImageBlock: @escaping GetImageBlock) {
        self.showBottomAlert(takingPicturesBlock: getImageBlock, openLocalPhotosBlock: getImageBlock, deleteBlock: nil)
    }
    
    /// 拍照、相册、删除当前照片、取消（不区分图片来自哪里）
    func showBottomAlert(getImageBlock: @escaping GetImageBlock,
                         deleteBlock: (()->())?) {
        self.showBottomAlert(takingPicturesBlock: getImageBlock, openLocalPhotosBlock: getImageBlock, deleteBlock: deleteBlock)
    }
    
    /// 底部弹窗：拍照、相册、取消
    func showBottomAlert(takingPicturesBlock: @escaping GetImageBlock,
                         openLocalPhotosBlock: @escaping GetImageBlock) {
        self.showBottomAlert(takingPicturesBlock: takingPicturesBlock, openLocalPhotosBlock: openLocalPhotosBlock, deleteBlock: nil)
    }
    
    /// 底部弹窗：拍照、相册、删除当前照片、取消
    func showBottomAlert(takingPicturesBlock: @escaping GetImageBlock,
                         openLocalPhotosBlock: @escaping GetImageBlock,
                         deleteBlock: (()->())?) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let takingPictures = UIAlertAction(title:"拍照", style: .default) {
            action in
            // 拍照
            self.goToCamera(getImageBlock: takingPicturesBlock)
        }
        let localPhoto = UIAlertAction(title:"相册选择", style: .default) {
            action in
            // 打开相册
            self.goToPhotoAlbum(getImageBlock: openLocalPhotosBlock)
        }
        let cancel = UIAlertAction(title:"取消", style: .cancel) {
            action in
        }
        alertController.addAction(takingPictures)
        alertController.addAction(localPhoto)
        // 特殊业务
        if deleteBlock != nil {
            let delete = UIAlertAction(title:"删除当前图片", style: .default) {
                action in
                deleteBlock!()
            }
            alertController.addAction(delete)
        }
        alertController.addAction(cancel)
        DispatchQueue.main.async { [self] in
            let currentVC: UIViewController = topMostController()
            currentVC.present(alertController, animated:true, completion:nil)
        }
    }
    
    //MARK:- 打开相机
    
    /// 拍照(会首先检查是否开启相机权限)
    func goToCamera(getImageBlock: @escaping GetImageBlock) {
        // 检查相机权限
        MJSystemPhotoAlbum.cameraPermissions(authorizedBlock: {
            // 有权限
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.getImageBlock = getImageBlock
                // 在需要的地方present出来
                DispatchQueue.main.async { [self] in
                    let cameraPicker = UIImagePickerController()
                    cameraPicker.delegate = self
                    cameraPicker.allowsEditing = self.cameraIsAllowsEditing
                    cameraPicker.sourceType = .camera
                    //
                    let currentVC: UIViewController = self.topMostController()
                    currentVC.present(cameraPicker, animated: true, completion: nil)
                }
            } else {
                DispatchQueue.main.async {
                    self.nomalSystemAlert(content: "当前设备不支持拍照！")
                }
            }
        }, deniedBlock: {
            DispatchQueue.main.async {
                self.goToSettingSytemAlert(content: "未开启相机权限！")
            }
        })
        
    }
    
    //MARK:- 打开相册
    
    /// 相册选择(会首先检查是否开启相册权限)
    func goToPhotoAlbum(getImageBlock: @escaping GetImageBlock) {
        // 检查相册权限
        MJSystemPhotoAlbum.photoAlbumPermissions(authorizedBlock: {
            // 有权限
            self.getImageBlock = getImageBlock
            // 在需要的地方present出来
            DispatchQueue.main.async { [self] in
                let photoPicker =  UIImagePickerController()
                photoPicker.delegate = self
                photoPicker.allowsEditing = self.photoIsAllowsEditing
                photoPicker.sourceType = .photoLibrary
                photoPicker.modalPresentationStyle = .fullScreen
                //
                let currentVC: UIViewController = self.topMostController()
                currentVC.present(photoPicker, animated: true, completion: nil)
            }
        }, deniedBlock: {
            DispatchQueue.main.async {
                self.goToSettingSytemAlert(content: "未开启相册权限！")
            }
        })
    }
    
    //MARK:- 保存图片到相册
    ///
    func saveImageToPhotoLibrary(image: UIImage,
                                 complete: ((_ isSuccess: Bool, _ errorMsg: String?)->())?) {
        // 检查相册权限
        MJSystemPhotoAlbum.photoAlbumPermissions(authorizedBlock: {
            // 有权限
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAsset(from: image)
            }, completionHandler: { (isSuccess, error) in
                if complete != nil {
                    complete!(isSuccess, nil)
                }
            })
        }, deniedBlock: {
            DispatchQueue.main.async {
                self.goToSettingSytemAlert(content: "未开启相册权限！")
            }
            if complete != nil {
                complete!(false, "未开启相册权限！")
            }
        })
    }
    
    //MARK:- 系统弹窗
    
    /// 前往设置权限
    func goToSettingSytemAlert(content: String) {
        let alert = UIAlertController(title: "提示", message: content, preferredStyle: UIAlertController.Style.alert)
        let cancel = UIAlertAction(title: "取消", style: .default, handler: nil)
        let goToSetting = UIAlertAction.init(title: "前往设置", style: .default) { (alertAction) in
            // 前往设置权限
            if #available(iOS 10, *) {
                UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:],
                                          completionHandler: {
                                            (success) in
                                          })
            } else {
                UIApplication.shared.openURL(URL.init(string: UIApplication.openSettingsURLString)!)
            }
        }
        alert.addAction(cancel)
        alert.addAction(goToSetting)
        DispatchQueue.main.async { [self] in
            let currentVC: UIViewController = topMostController()
            currentVC.present(alert, animated: true, completion: nil)
        }
    }
    
    /// 普通系统提示弹窗
    func nomalSystemAlert(content: String) {
        let alert = UIAlertController(title: "提示", message: content, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "我知道了", style: .default, handler: nil)
        alert.addAction(btnOK)
        DispatchQueue.main.async { [self] in
            let currentVC: UIViewController = topMostController()
            currentVC.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK:- 获取当前控制器
    func topMostController() -> UIViewController {
        var keyWindow: UIWindow? = nil
        //
        if #available(iOS 13.0, *) {
            for windowScene:UIWindowScene in ((UIApplication.shared.connectedScenes as? Set<UIWindowScene>)!) {
                if windowScene.activationState == .foregroundActive {
                    keyWindow = windowScene.windows.first
                    break
                }
            }
        } else {
            keyWindow = UIApplication.shared.keyWindow
        }
        if keyWindow != nil {
            //
            var topVC = keyWindow!.rootViewController
            while ((topVC?.presentingViewController) != nil) {
                topVC = topVC?.presentingViewController
            }
            return topVC!
        } else {
            let vc = UIView.findCurrentViewController()
            return vc
        }
    }
    
    //MARK:- UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var image : UIImage = UIImage.init()
        if (info[UIImagePickerController.InfoKey.editedImage] != nil) {
            image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        } else {
            image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        }
        // 回调图片
        if getImageBlock != nil {
            getImageBlock!(image)
        }
        let currentVC: UIViewController = topMostController()
        currentVC.dismiss(animated: true, completion: nil)
    }
    
}
