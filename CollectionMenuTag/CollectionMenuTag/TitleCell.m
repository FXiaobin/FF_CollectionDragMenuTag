//
//  TitleCell.m
//  CollectionMenuTag
//
//  Created by mac on 2018/7/20.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import "TitleCell.h"
#import <Masonry.h>

@implementation TitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsZero);
        }];
    }
    return self;
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.backgroundColor = [UIColor orangeColor];
        _titleLabel.clipsToBounds = YES;
        _titleLabel.layer.cornerRadius = 20;
    }
    return _titleLabel;
}

@end
