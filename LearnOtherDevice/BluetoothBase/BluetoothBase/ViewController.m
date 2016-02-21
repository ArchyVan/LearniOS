//
//  ViewController.m
//  BluetoothBase
//
//  Created by Archy on 15/6/12.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import <GameKit/GameKit.h>

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,GKPeerPickerControllerDelegate>

@property (nonatomic, strong) GKSession *session;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)send
{
    UIImage *image = [UIImage imageNamed:@"123"];
    NSData *data = UIImagePNGRepresentation(image);
    
    /*
     GKSendDataReliable, 数据安全的发送模式, 慢
     GKSendDataUnreliable, 数据不安全的发送模式, 快
     */
    
    /*
     data: 需要发送的数据
     DataReliable: 是否安全的发送数据(发送数据的模式)
     error: 是否监听发送错误
     */
    [self.session sendDataToAllPeers:data withDataMode:GKSendDataReliable error:nil];
}
- (void)selectedPhoto
{
    UIImagePickerController *imagePk = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        imagePk.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        imagePk.delegate = self;
        
        [self presentViewController:imagePk animated:YES completion:nil];
    }
}
- (void)connect
{
    GKPeerPickerController *peerPk = [[GKPeerPickerController alloc] init];
    
    peerPk.delegate = self;
    
    [peerPk show];
}
#pragma mark - GKPeerPickerControllerDelegate
// 4.实现dialing方法
/**
 *  当蓝牙设备连接成功就会调用
 *
 *  @param picker  触发时间的控制器
 *  @param peerID  连接蓝牙设备的ID
 *  @param session 连接蓝牙的会话(可用通讯), 以后只要拿到session就可以传输数据
 */
- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session
{
    NSLog(@"%@",peerID);
    // 1.保存会话
    self.session = session;
    
    // 2.设置监听接收传递过来的数据
    /*
     Handler: 谁来处理接收到得数据
     withContext: 传递数据
     */
    [self.session setDataReceiveHandler:self withContext:nil];
    
    [picker dismiss];
}

- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context
{
    UIImage *image = [UIImage imageWithData:data];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker
{
    NSLog(@"%s",__func__);
}
@end
