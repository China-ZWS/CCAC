//
//  CCACLanguageVC.m
//  CCAC
//
//  Created by 周文松 on 2017/3/30.
//  Copyright © 2017年 周文松. All rights reserved.
//

#import "CCACLanguageVC.h"

#define kCellHeight   DDLayoutIphone6Pixels(50.f)
#define kCellTextSize DDLayoutIphone6Pixels(15.f)

@interface CCACLanguageCell : UITableViewCell

@end

@implementation CCACLanguageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier])) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.font = DDFont(kCellTextSize);
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.textColor = DDTextColor;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(0, 0, self.dd_width, self.dd_height);
}

- (void)dd_configWithItemModel:(id)itemModel {
    NSDictionary *data = (NSDictionary *)itemModel;
    self.textLabel.text = data[@"language"];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        self.backgroundColor = DDSelectBKColor;
    } else {
        self.backgroundColor = DDWhiteColor(1);
    }
}

@end

@interface CCACLanguageVC ()

@property (nonatomic, strong) NSArray *datas;

@end

@implementation CCACLanguageVC

- (instancetype)init
{
    if ((self = [super initWithStyle:UITableViewStyleGrouped])) {
        self.title = NSLocalizedString(@"CCACLanguageVC.title",nil);
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;               //视图控制器，四条边不指定
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _datas = @[@{@"language":NSLocalizedString(@"CCACLanguageVC.row1",nil),@"lang":@"zh-Hans"},
               @{@"language":NSLocalizedString(@"CCACLanguageVC.row2",nil),@"lang":@"en"},
               @{@"language":NSLocalizedString(@"CCACLanguageVC.row3",nil),@"lang":@"es"}];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {return 3;}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {return 1;}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {return kCellSpacing;}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {return CGFLOAT_MIN;}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {return kCellHeight;}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCACLanguageCell *cell = [tableView dequeueReusableCellWithIdentifier:[CCACLanguageCell dd_reusableIdentifier]];
    if (cell == nil) {
        [tableView registerClass:[CCACLanguageCell class] forCellReuseIdentifier:[CCACLanguageCell dd_reusableIdentifier]];
        cell = [tableView dequeueReusableCellWithIdentifier:[CCACLanguageCell dd_reusableIdentifier]];
    }
    [cell dd_configWithItemModel:_datas[indexPath.section]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = _datas[indexPath.section];
    NSString *language = data[@"lang"];
    [NSBundle setLanguage:language];
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:@"myLanguage"];
    [[NSUserDefaults standardUserDefaults] setObject:@[language] forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[AppServer server] setCookies];

    CATransition *transition = [CATransition animation];
    transition.duration =0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    [DD_ApplicationWindow.layer addAnimation:transition forKey:nil];
    DD_ApplicationWindow.rootViewController = [[UINavigationController alloc] initWithRootViewController:[NSClassFromString(@"CCACMainVC") new]];
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
