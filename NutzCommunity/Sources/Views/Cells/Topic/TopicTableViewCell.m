//
//  TopicTableViewCell.m
//  NutzCommunity
//
//  Created by DuWei on 15/12/23.
//  Copyright (c) 2015年 nutz.cn. All rights reserved.
//

#import "TopicTableViewCell.h"
#import "UIView+Common.h"
#import "NSDate+TimeAgo.h"

@interface TopicTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation TopicTableViewCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupViews];
}

- (void)setupViews {
    //[self addLine:YES];
    [self addLine:NO];
    self.backgroundColor             = KCOLOR_CLEAR;
    self.category.backgroundColor    = KCOLOR_MAIN_TEXT;
    self.category.layer.cornerRadius = 3;
    self.category.textColor          = KCOLOR_WHITE;

    self.avatar.layer.borderWidth    = 1;
    self.avatar.layer.borderColor    = KCOLOR_WHITE.CGColor;
    self.avatar.layer.cornerRadius   = 35 / 2;

    self.topicTitle.font = [UIFont fontWithName:FONT_DEFAULE size:16];
    self.topicTitle.textColor        = KCOLOR_MAIN_TEXT;
}

- (void)addLine:(BOOL)top {
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [KCOLOR_LIGHT_GRAY colorWithAlphaComponent:0.4];
    [self.bgView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView).offset(48);
        make.right.equalTo(_bgView).offset(-0);
        make.height.mas_equalTo(0.5);
        if(top) {
            make.top.equalTo(_bgView);
        } else {
            make.bottom.equalTo(_bgView);
        }
        
    }];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    // 置顶
    if(self.topic.top){
        self.category.backgroundColor    = KCOLOR_MAIN_BLUE;
        self.category.layer.cornerRadius = 3;
        self.category.textColor          = KCOLOR_WHITE;
    }else{
        self.category.backgroundColor    = KCOLOR_CLEAR;
        self.category.layer.cornerRadius = 3;
        self.category.textColor          = KCOLOR_MAIN_BLUE;
        self.category.layer.borderColor  = KCOLOR_MAIN_BLUE.CGColor;
        self.category.layer.borderWidth  = 0.5;
    }
    // 精华
    if(!self.topic.good){
        self.jinghua.hidden = YES;
    }else{
        self.jinghua.hidden = NO;
    }
}

#pragma mark Setter
- (void)setTopic:(Topic *)topic {
    
    _topic = topic;
    self.topicTitle.text = topic.title;

    self.nickname.text = topic.author.loginname;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:topic.author.avatarUrl]];
    
    if(topic.top){
        self.category.text =  @"置顶";
    }else{
        self.category.text =  [Topic tabTypeName:topic.tab];
    }
    
    self.counts.text = [NSString stringWithFormat:@"%d / %d", topic.replyCount, topic.visitCount];
    self.publishTime.text = [topic.createAt timeAgo];
    self.lastPost.text = [topic.lastReplyAt timeAgo];
}

@end
