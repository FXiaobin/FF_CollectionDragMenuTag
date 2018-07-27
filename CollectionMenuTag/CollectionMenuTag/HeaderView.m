//
//  HeaderView.m
//  CollectionMenuTag
//
//  Created by mac on 2018/7/20.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import "HeaderView.h"
#import <Masonry.h>

#ifdef __IPHONE_11_0

@interface CustomLayer: CALayer
@end

@implementation CustomLayer

- (CGFloat)zPosition {
    return 0;
}

@end

#endif


@implementation HeaderView

#ifdef __IPHONE_11_0

+ (Class)layerClass {
    return [CustomLayer class];
}

#endif

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 20, 0, 20));
        }];
    }
    return self;
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
//        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

@end
