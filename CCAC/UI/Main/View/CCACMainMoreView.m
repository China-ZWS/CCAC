//
//  CCACMainMoreView.m
//  CCAC
//
//  Created by 周文松 on 2017/3/29.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import "CCACMainMoreView.h"

#import "DDAvatarView.h"

#define kHeaderHeight      DDLayoutIphone6Pixels(180.f)
#define kHeaderIconWidth   DDLayoutIphone6Pixels(80.f)

@interface CACCMainMoreHeader : UIView <DDAvatarViewDelegate>

@property (nonatomic, strong) DDAvatarView *avatarIcon;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, copy) dispatch_block_t changeFace;
@property (nonatomic, assign) BOOL hasFirst;
- (void)reloadData;

@end

@implementation CACCMainMoreHeader

- (instancetype) init {
    if ((self = [super init])) {
        _hasFirst = YES;
        self.backgroundColor = DDClearColor;
        _avatarIcon = DDAvatarView.new;
//        _avatarIcon.avatarInsets = UIEdgeInsetsMake(1, 1, 1, 1);
        _avatarIcon.dd_size = CGSizeMake(kHeaderIconWidth, kHeaderIconWidth);
        _avatarIcon.delegate = self;
        [self addSubview:_avatarIcon];
        
        _nameLb = UILabel.new;
        _nameLb.font = DDBoldFont(DDLayoutIphone6Pixels(15));
        _nameLb.textAlignment = NSTextAlignmentCenter;
        _nameLb.textColor = DDWhiteColor(1);
        _nameLb.dd_size = CGSizeMake(150, _nameLb.font.lineHeight);
        _nameLb.shadowColor = DDTextColor;
        _nameLb.shadowOffset = CGSizeMake(DD_ScreenScale, DD_ScreenScale);
        [self addSubview:_nameLb];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_hasFirst) {
        _hasFirst = NO;
    } else {
        return;
    }
    _avatarIcon.dd_origin = CGPointMake((self.dd_width - _avatarIcon.dd_width) / 2, (self.dd_height - _avatarIcon.dd_height - _nameLb.dd_height) / 2 + DDLayoutIphone6Pixels(8));
    _nameLb.dd_top = _avatarIcon.dd_bottom + DDLayoutIphone6Pixels(8);
    _nameLb.dd_left = (self.dd_width - 150) / 2;
}

- (void)reloadData {
    if (kUserDidLogin()){
        _avatarIcon.avatarUrl = [AppServer server].menberModel.headimgurl;
        if ([AppServer server].menberModel.real_name.length) {
            _nameLb.text = [AppServer server].menberModel.real_name;
        } else {
            _nameLb.text = NSLocalizedString(@"userInfo.name",nil);
        }
    } else {
        _avatarIcon.avatarUrl = nil;
        _nameLb.text = @"未登录";
    }
}


- (void)clickEvent
{
    if (kUserDidLogin()) {
        if (_changeFace) {
            _changeFace();
        } else {
            DD_Assert(_changeFace != nil);
        }
    }
}

@end

#define kCellHeight   DDLayoutIphone6Pixels(50.f)
#define kCellTextSize DDLayoutIphone6Pixels(15.f)

@interface CCACMainMoreCell : UITableViewCell

@property (nonatomic, strong) CALayer *line;


@end

@implementation CCACMainMoreCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier])) {
        self.backgroundColor = DDClearColor;
        _line = CALayer.new;
        _line.backgroundColor = DDLineColor.CGColor;
        [self.layer addSublayer:_line];
        
        self.textLabel.font = DDFont(kCellTextSize);
        self.textLabel.textColor = DDWhiteColor(1);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _line.frame = CGRectMake(10, self.dd_height - DD_ScreenScale, self.dd_width - 20, DD_ScreenScale);
    self.imageView.dd_left = DDLayoutIphone6Pixels(30);
    self.textLabel.dd_left = self.imageView.dd_right + DDLayoutIphone6Pixels(15);
}

- (void)dd_configWithItemModel:(id)itemModel {
    if (![itemModel isKindOfClass:[NSDictionary class]]) return;
    NSDictionary *data = itemModel;
    self.imageView.image = DDImageName(data[@"image"]);
    self.textLabel.text = NSLocalizedString(data[@"title"],nil);
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        self.backgroundColor = DDColorAlpha(DDSelectBKColor,.7);
    } else {
        self.backgroundColor = DDClearColor;
    }
}

@end


@interface CCACMainMoreView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *moreLocalList;
@property (nonatomic, strong) CACCMainMoreHeader *headView;

@end

@implementation CCACMainMoreView

- (CACCMainMoreHeader *)headView {
    return _headView = ({
        CACCMainMoreHeader *view = nil;
        if (_headView) {
            view = _headView;
        } else {
            view = CACCMainMoreHeader.new;
            view.changeFace = ^{
                [CCACGo pushWithParameter:@{@"linkUrl":@"index.html#changeFace"}];
            };
            view.dd_height = kHeaderHeight;
            [view reloadData];
        }
        view;
    });
}

- (void)moreViewRefreshHeadImg {
    [_headView reloadData];
}


- (instancetype) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame style:UITableViewStylePlain])) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor =DDColorAlpha(CCACRedColor, .7);
        self.delegate = self;
        self.dataSource = self;
        self.tableHeaderView = self.headView;
        _moreLocalList = [DataConfigManager getMainMoreList];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _moreLocalList.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   CCACMainMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:[CCACMainMoreCell dd_reusableIdentifier]];
    if (cell == nil) {
        [tableView registerClass:[CCACMainMoreCell class] forCellReuseIdentifier:[CCACMainMoreCell dd_reusableIdentifier]];
        cell = [tableView dequeueReusableCellWithIdentifier:[CCACMainMoreCell dd_reusableIdentifier]];
    }
    
    if (indexPath.row <  _moreLocalList.count) {
        [cell dd_configWithItemModel:_moreLocalList[indexPath.row]];
    } else {
        cell.textLabel.text = [@"V" stringByAppendingString:DD_APP_VERSION];
        cell.imageView.image = DDImageName(@"main_more_clear_icon");
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= _moreLocalList.count) {
        return;
    }
    NSDictionary *data = _moreLocalList[indexPath.row];
    _selected(indexPath.row,data[@"linkUrl"]);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
