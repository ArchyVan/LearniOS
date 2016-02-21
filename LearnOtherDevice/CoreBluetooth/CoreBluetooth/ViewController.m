//
//  ViewController.m
//  CoreBluetooth
//
//  Created by Archy on 15/6/12.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController () <CBCentralManagerDelegate,CBPeripheralDelegate>
/**
 *  外设
 */
@property (nonatomic, strong) NSMutableArray *peripherals;
/**
 *  中心管理者
 */
@property (nonatomic, strong) CBCentralManager *manager;

@end

@implementation ViewController

-(NSMutableArray *)peripherals
{
    if (!_peripherals) {
        _peripherals = [NSMutableArray array];
    }
    return _peripherals;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    CBCentralManager *manager = [[CBCentralManager alloc]init];
    self.manager = manager;
    
    manager.delegate = self;
    
    // 2.利用中心设备扫描外部设备
    /*
     如果指定数组代表只扫描指定的设备
     */
    [manager scanForPeripheralsWithServices:nil options:nil];
}
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    if (![self.peripherals containsObject:peripheral]) {
        peripheral.delegate = self;
        [self.peripherals addObject:peripheral];
    }
}
- (void)start
{
    for (CBPeripheral *peripheral in self.peripherals) {
        [self.manager connectPeripheral:peripheral options:nil];
    }
}
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    [peripheral discoverServices:nil];
}
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"%s",__func__);
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    NSArray *services = peripheral.services;
    
    for (CBService *service in services) {
        if ([service.UUID.UUIDString isEqualToString:@"123"]) {
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    NSArray *characteristics = service.characteristics;
    
    for (CBCharacteristic *characteristic in characteristics) {
        if ([characteristic.UUID.UUIDString isEqualToString:@"8888"]) {
            NSLog(@"设置闹钟");
        }
    }
}
@end
