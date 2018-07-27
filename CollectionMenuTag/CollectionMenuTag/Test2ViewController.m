//
//  Test2ViewController.m
//  CollectionMenuTag
//
//  Created by mac on 2018/7/20.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import "Test2ViewController.h"
#import <JQCollectionViewAlignLayout.h>
#import "TitleCell.h"
#import "HeaderView.h"

@interface Test2ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,JQCollectionViewAlignLayoutDelegate,UICollectionViewDelegateFlowLayout>


@property (nonatomic,strong) UICollectionView *collectionView;


@property (nonatomic,strong) NSIndexPath *dragingIndexPath;


@property (nonatomic,strong) NSIndexPath *targetIndexPath;


@property (nonatomic,strong) NSMutableArray *dataArr;


@property (nonatomic,strong) UILabel *bigLabel;


@end

@implementation Test2ViewController

-(UILabel *)bigLabel{
    if (_bigLabel == nil) {
        _bigLabel = [[UILabel alloc] init];
        _bigLabel.textColor = [UIColor whiteColor];
        _bigLabel.backgroundColor = [UIColor redColor];
        _bigLabel.hidden = YES;
        _bigLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _bigLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"X" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.dataArr = [NSMutableArray array];
    NSMutableArray *section0 = [NSMutableArray arrayWithArray:@[@"发生大幅度",@"发的说法",@"大声道",@"地方",@"范德萨",@"教育厅",@"杨瑞瑞",@"日日日",@"俄而嗯嗯",@"通天塔"]];
    NSMutableArray *section1 = [NSMutableArray arrayWithArray:@[@"ffd",@"突然",@"好友推荐",@"简介",@"未付",@"而非",@"鬼地方个",@"风格"]];
    NSMutableArray *section2 = [NSMutableArray arrayWithArray:@[@"看看",@"挂号费",@"人缘好",@"规划法规",@"人与人",@"任天野",@"发过火",@"地方",@"忐忑",@"特甜热热",@"号回访电话"]];
    
    [self.dataArr addObject:section0];
    [self.dataArr addObject:section1];
    [self.dataArr addObject:section2];
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView addSubview:self.bigLabel];
}

-(void)close:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (JQCollectionViewItemAlignment)layout:(JQCollectionViewAlignLayout *)layout itemAlignmentInSection:(NSInteger)section{
    
    return JQCollectionViewItemAlignmentLeft;
}

-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        JQCollectionViewAlignLayout *layout = [[JQCollectionViewAlignLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20);
        layout.delegate = self;
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 50);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, CGRectGetHeight(self.view.frame) - 60) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[TitleCell class] forCellWithReuseIdentifier:@"TitleCell"];
        [_collectionView registerClass:[HeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        
        UILongPressGestureRecognizer *longPresssGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        [_collectionView addGestureRecognizer:longPresssGes];
    }
    return _collectionView;
}

- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    
    CGPoint point = [longPress locationInView:_collectionView];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    TitleCell *cell = (TitleCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:{
            
            self.dragingIndexPath = [self.collectionView indexPathForItemAtPoint:point];
            
            if (!self.dragingIndexPath || self.dragingIndexPath.section > 0) {
                break;
            }

            self.bigLabel.hidden = NO;
            self.bigLabel.text = cell.titleLabel.text;
            self.bigLabel.frame = cell.frame;
            self.bigLabel.center = cell.center;
          
            [UIView animateWithDuration:0.3 animations:^{
                [self.bigLabel setTransform:CGAffineTransformMakeScale(1.2, 1.2)];
            }];
            
        } break;
            
        case UIGestureRecognizerStateChanged:
            self.targetIndexPath = [self.collectionView indexPathForItemAtPoint:point];
            self.bigLabel.center = point;
            
            ///只让第一组可以拖动(起始位置和结束位置都在第一组) 其他组不能拖动
            if (!self.targetIndexPath  || self.dragingIndexPath.section > 0 || self.targetIndexPath.section > 0) {
                break;
            }
            
            if (self.targetIndexPath && self.dragingIndexPath) {
                [self.collectionView moveItemAtIndexPath:self.dragingIndexPath toIndexPath:self.targetIndexPath];
                ///重要点就是 cell交换后 数据源也要对应的交换
                ///交换cell时会调用计算cell size的方法 所以要想显示的cell的size不出错 在cell交换后 数据源也要交换
                NSMutableArray *arr = self.dataArr.firstObject;
                NSString *title = arr[self.dragingIndexPath.item];
                [arr removeObject:title];
                [arr insertObject:title atIndex:self.targetIndexPath.item];
                
                self.dragingIndexPath = self.targetIndexPath;
                
            }
            
            break;
            
        case UIGestureRecognizerStateEnded: {
            
            [UIView animateWithDuration:0.3 animations:^{
                self.bigLabel.transform = CGAffineTransformIdentity;
                TitleCell *targetCell = (TitleCell *)[self.collectionView cellForItemAtIndexPath:self.dragingIndexPath];
                self.bigLabel.center = targetCell.center;
                
            } completion:^(BOOL finished) {
                self.bigLabel.hidden = YES;
            }];
            
        } break;
            
        default:{
            
            [UIView animateWithDuration:0.3 animations:^{
                self.bigLabel.transform = CGAffineTransformIdentity;
                TitleCell *targetCell = (TitleCell *)[self.collectionView cellForItemAtIndexPath:self.dragingIndexPath];
                
                self.bigLabel.center = targetCell.center;
                
            } completion:^(BOOL finished) {
                self.bigLabel.hidden = YES;
            }];
            
            
        } break;
    }
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArr.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *arr = self.dataArr[section];
    return arr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TitleCell" forIndexPath:indexPath];
    
    NSArray *arr = self.dataArr[indexPath.section];
    cell.titleLabel.text = arr[indexPath.item];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //return CGSizeMake(100, 40);
    NSArray *arr = self.dataArr[indexPath.section];
    NSString *title = arr[indexPath.item];
    CGFloat w = [title sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}].width + 30;
    return CGSizeMake(w , 40);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    HeaderView *header = (HeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    
    header.titleLabel.text = @"已订购的频道";
    
    return header;
    
}

-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return YES;
    }
    return NO;
}

-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    
}

///重要点就是 cell交换后 数据源也要对应的交换
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section > 0) {
        NSMutableArray *arr = self.dataArr[indexPath.section];
        NSString *title = arr[indexPath.item];
        [arr removeObject:title];
        NSMutableArray *section0 = self.dataArr[0];
        [section0 addObject:title];
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:section0.count - 1 inSection:0]];
        
    }
    ///test
    else if (indexPath.section == 0){
        NSMutableArray *arr = self.dataArr[indexPath.section];
        NSString *title = arr[indexPath.item];
        [arr removeObject:title];
        NSMutableArray *section1 = self.dataArr[1];
        [section1 addObject:title];
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:section1.count - 1 inSection:1]];
        
    }
}

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
