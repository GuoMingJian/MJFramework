//
//  MJImageClipView.h
//  MJFramework
//
//  Created by 郭明健 on 2018/6/2.
//  Copyright © 2018年 GuoMingJian. All rights reserved.
//

//========用法============
/*
 注意:iOS 10 增加了新的安全设定，需要在plist文件添加相应的字段：
 1.Privacy - Photo Library Usage Description 我们需要使用您的相册
 2.Privacy - Camera Usage Description 我们需要使用您的相机
 3.实现<UIImagePickerControllerDelegate , UINavigationControllerDelegate>
 
 #pragma mark -
 
 - (void)setupAlertAction
 {
 UIAlertAction *photoLibrary = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
 UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
 [pickerVC setAllowsEditing:NO];
 [pickerVC setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
 [pickerVC setDelegate:self];
 [self presentViewController:pickerVC animated:YES completion:nil];
 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
 self.tabBarController.tabBar.hidden = YES;
 });
 }];
 UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
 if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
 {
 UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
 [pickerVC setAllowsEditing:NO];
 [pickerVC setSourceType:UIImagePickerControllerSourceTypeCamera];
 [pickerVC setDelegate:self];
 [self presentViewController:pickerVC animated:YES completion:nil];
 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
 self.tabBarController.tabBar.hidden = YES;
 });
 }
 else
 {
 //NSLog(@"该设备无摄像头");
 //[MJCommon showTipView:@"当前设备无摄像头"];
 }
 }];
 UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
 //
 UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
 [alertC addAction:photoLibrary];
 [alertC addAction:camera];
 [alertC addAction:cancel];
 [self presentViewController:alertC animated:YES completion:nil];
 }
 
 #pragma mark - UIImagePickerControllerDelegate
 
 - (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
 {
 [self dismissViewControllerAnimated:YES completion:nil];
 self.tabBarController.tabBar.hidden = NO;
 }
 
 - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
 {
 UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
 [self dismissViewControllerAnimated:YES completion:nil];
 
 //处理图片剪切
 MJImageClipView *mjClipView = [[MJImageClipView alloc] initWithFrame:self.navigationController.view.bounds];
 [self.navigationController.view addSubview:mjClipView];
 
 mjClipView.clipType = ImageClipCircle;
 //
 [mjClipView clipImage:image callBack:^(UIImage *image, BOOL isSuccess)
 {
 self.tabBarController.tabBar.hidden = NO;
 if (isSuccess && image)
 {
 }
 }];
 }
 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImageClipType)
{
    ImageClipCircle = 0,    //切圆形，一般用户处理头像
    ImageClipHerizonRect,
    ImageClipVerticalRect
};

@interface MJImageClipView : UIView

/**
 圆形镂空的宽度
 */
@property(nonatomic, assign)CGFloat circleWidth;

/**
 需要剪切的图片
 */
@property(nonatomic, strong)UIImage *needClipImage;

/**
 剪切图片的样式
 */
@property(nonatomic, assign)ImageClipType clipType;

#pragma mark - private

/**
 图片剪切 [默认头像剪切]
 */
- (void)clipImage:(UIImage *)needClipImage
         callBack:(void(^)(UIImage *image, BOOL isSuccess))callBack;

/**
 图片剪切
 
 @param needClipImage 需要剪切的图片对象
 @param clipType 剪切类型
 @param callBack 图片处理后的回调，点击取消时，回调的image对象为nil
 */
- (void)clipImage:(UIImage *)needClipImage
         clipType:(ImageClipType)clipType
         callBack:(void(^)(UIImage *image, BOOL isSuccess))callBack;

@end

