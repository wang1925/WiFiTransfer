//
//  ViewController.m
//  WiFiTransfer
//
//  Created by 王浩田 on 2018/5/20.
//  Copyright © 2018年 Owen. All rights reserved.
//

#import "ViewController.h"
#import "HTWiFiViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *wifiBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"WiFi Transfer";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configUI];
}
- (void)configUI{
    self.wifiBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 -50, 200, 100, 50)];
    [self.view addSubview:self.wifiBtn];
    self.wifiBtn.backgroundColor = [UIColor redColor];
    [self.wifiBtn setTitle:@"OPEN" forState:UIControlStateNormal];
    [self.wifiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.wifiBtn addTarget:self action:@selector(openWifiTransfer:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)openWifiTransfer:(UIButton *)sender{
    HTWiFiViewController *controller = [[HTWiFiViewController alloc]init];
    controller.title = self.title;
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
