//
//  HTWiFiViewController.m
//  WiFiTransfer
//
//  Created by 王浩田 on 2018/5/20.
//  Copyright © 2018年 Owen. All rights reserved.
//

#import "HTWiFiViewController.h"
#import "NSString+IPAddress.h"
#import "GCDWebUploader.h"

@interface HTWiFiViewController ()<GCDWebUploaderDelegate>
@property (nonatomic, strong) UILabel *msgLab;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) GCDWebUploader *webServer;

@end

@implementation HTWiFiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // ⚠️ Before Test Download Or Rename, Please Upload a file first.
    
    [self configUI];
    [self startWifiTransfer];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self stopWifiTransfer];
}
- (void)configUI{
    self.msgLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, self.view.frame.size.width-40, 200)];
    [self.view addSubview:self.msgLab];
    self.msgLab.textColor = [UIColor blackColor];
    self.msgLab.font = [UIFont systemFontOfSize:14];
    self.msgLab.text = @"Devices and computers need to be in the same Wi-Fi";
    
    self.contentLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 210, self.view.frame.size.width-40, 50)];
    [self.view addSubview:self.contentLab];
    self.contentLab.textColor = [UIColor redColor];
    self.contentLab.font = [UIFont systemFontOfSize:14];
    self.contentLab.numberOfLines = 0;
    self.contentLab.text = @"On your computer's browser go to:";
    
    self.closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 -50, 300, 100, 50)];
    [self.view addSubview:self.closeBtn];
    self.closeBtn.backgroundColor = [UIColor redColor];
    [self.closeBtn setTitle:@"Turn Off" forState:UIControlStateNormal];
    [self.closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(closeWifiTransfer:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)closeWifiTransfer:(UIButton *)sender{
    [self stopWifiTransfer];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- Wifi Transfer
- (void)startWifiTransfer{
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    _webServer = [[GCDWebUploader alloc] initWithUploadDirectory:documentsPath];
    _webServer.delegate = self;
    _webServer.allowHiddenItems = YES;
    if ([_webServer start]) {
        NSString *msgStr = [NSString stringWithFormat:@"http://%@:%i",[NSString ht_deviceIPAddress],(int)_webServer.port];
        NSLog(@"IP地址：%@",msgStr);
        self.contentLab.text = [NSString stringWithFormat:@"%@\n%@",@"On your computer's browser go to:",msgStr];
    } else {
        self.contentLab.text = @"GCDWebServer not running!";
    }
}
- (void)stopWifiTransfer{
    [_webServer stop];
    _webServer = nil;
}
#pragma mark- Delegate
- (void)webUploader:(GCDWebUploader*)uploader didUploadFileAtPath:(NSString*)path {
    NSLog(@"[UPLOAD] %@", path);
}

- (void)webUploader:(GCDWebUploader*)uploader didMoveItemFromPath:(NSString*)fromPath toPath:(NSString*)toPath {
    NSLog(@"[MOVE] %@ -> %@", fromPath, toPath);
}

- (void)webUploader:(GCDWebUploader*)uploader didDeleteItemAtPath:(NSString*)path {
    NSLog(@"[DELETE] %@", path);
}

- (void)webUploader:(GCDWebUploader*)uploader didCreateDirectoryAtPath:(NSString*)path {
    NSLog(@"[CREATE] %@", path);
}
#pragma mark-
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
