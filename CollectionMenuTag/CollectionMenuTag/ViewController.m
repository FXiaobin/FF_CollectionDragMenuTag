//
//  ViewController.m
//  CollectionMenuTag
//
//  Created by mac on 2018/7/20.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import "ViewController.h"
#import "MenuCollectionViewController.h"
#import "Test2ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 200, 50)];
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(present:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)present:(UIButton *)sender{
    MenuCollectionViewController *vc =[[MenuCollectionViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    
//    Test2ViewController *vc =[[Test2ViewController alloc] init];
//    [self presentViewController:vc animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
