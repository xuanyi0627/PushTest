//
//  ViewController.m
//  PushTest
//
//  Created by Echo on 16/1/7.
//  Copyright © 2016年 Liu Xuanyi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//原始DeviceToken输入框
@property (nonatomic, weak) IBOutlet UITextField *originalDTField;

//原始DeviceToken输入框
@property (nonatomic, weak) IBOutlet UITextField *formatDTField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDeviceTokenNotification:) name:@"kReceiveDeviceTokenNotification" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)receiveDeviceTokenNotification:(NSNotification *)noti {
    NSDictionary *devicetokens = [noti object];
    _originalDTField.text = devicetokens[@"originalDT"];
    _formatDTField.text = devicetokens[@"formatDT"];
}

@end
