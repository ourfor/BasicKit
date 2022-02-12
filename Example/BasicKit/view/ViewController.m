//
//  OHViewController.m
//  BasicKit
//
//  Created by 曾谞旺 on 09/03/2021.
//  Copyright (c) 2021 曾谞旺. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <AvailabilityInternal.h>
#import <objc/runtime.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "OHTextStickerView.h"
#import <BasicKit/BasicKit.h>
#import <AVFoundation/AVFoundation.h>
#import "OHPlayerView.h"
#import "OHDetailViewController.h"
#import "OHNetworkProxy.h"
#import <CoreMotion/CoreMotion.h>
#import "OHWatchView.h"

#define BUTTON_CORNER_RADIUS 10
#define BUTTON_FONT [UIFont fontWithName:ASSET_FONT_ARITAHEITI_MEDIUM size:15]
#define BUTTON_PADDING UIEdgeInsetsMake(8, 13, 8, 13)

@interface ViewController () <UICollisionBehaviorDelegate>
@property (nonatomic, weak) Timer timer;
@property (nonatomic, strong) UITextField *textInputView;
@property (nonatomic, strong) UIView *redCircleView;
@property (nonatomic, strong) UIView *greenCircleView;
@property (nonatomic, strong) UIButton *popPanelButton;
@property (nonatomic, strong) UIButton *faceIdButton;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UIButton *openDetailButton;
@property (nonatomic, strong) UISwitch *proxySwitch;
@property (nonatomic, strong) UIView *stickerView;
@property (nonatomic, strong) OHTextStickerModel *model;
@property (nonatomic, strong) OHWatchView *watchView;
@property (nonatomic, strong) UIView<PlayerAction> *playerView;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) UIGravityBehavior *gravityBehavior;
@property (nonatomic, strong) UICollisionBehavior *collisionBehavior;
@property (nonatomic, strong) UIPushBehavior *pushBehavior;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _setupUI];
    [self _layout];
    [self _bind];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    Logger *log = [Logger sharedInstance];
    log.info(@"Good %@", @"BB");
    log.warn(@"%@ 你好👋", @"AA");
    Toast.success(@"%@ 你好👋, 分手多日，近况如何？ 奉读大示，心折殊深。 惠书敬悉，迟复为歉。 近来寒暑不常，希自珍慰。 久不通函，至以为念。 前上一函，谅达雅鉴，迄今未闻复音。", @"AA");
    setTimeout(^{
        log.info(@"Hello World");
    }, 5 * TIME_UNIT_SEC);
    setInterval(^{
//        log.warn(@"%@ 你好👋", @"BB");
//        Toast.success(@"%@ 你好👋", @"AA");
    }, 2 * TIME_UNIT_SEC);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    if ([self.motionManager isAccelerometerActive]) {
        [self.motionManager stopAccelerometerUpdates];
    }
}

- (void)_setupUI {
    UIView *superview = self.view;
    [superview addSubview:self.stickerView];
    [superview addSubview:self.textInputView];
    [superview addSubview:self.faceIdButton];
    [superview addSubview:self.popPanelButton];
    [superview addSubview:self.redCircleView];
    [superview addSubview:self.greenCircleView];
    [superview addSubview:self.playButton];
    [superview addSubview:self.openDetailButton];
    [superview addSubview:self.proxySwitch];
    [superview addSubview:self.watchView];

    RACChannelTo(self.model, text) = self.textInputView.rac_newTextChannel;
    UIGestureRecognizer *clickRecognizer = [[UITapGestureRecognizer alloc] init];
    [clickRecognizer addTarget:self action:@selector(hideKeyboard)];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:clickRecognizer];
}

- (void)_layout {
    UIView *superview = self.view;
    @weakify(self);
    @weakify(superview);
    [self.redCircleView remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(superview);
        make.width.equalTo(@100);
        make.height.equalTo(@100);
        make.centerY.equalTo(superview).offset(-60);
        make.centerX.equalTo(superview).offset(20);
    }];
    
    [self.greenCircleView remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(superview);
        make.width.equalTo(@100);
        make.height.equalTo(@100);
        make.centerY.equalTo(superview).offset(-60);
        make.centerX.equalTo(superview).offset(-20);
    }];
    
    [self.watchView remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(superview);
        make.width.equalTo(@200);
        make.height.equalTo(@200);
        make.centerY.equalTo(superview).offset(-90);
        make.centerX.equalTo(superview);
    }];
    
    [self.stickerView makeConstraints:^(MASConstraintMaker *make) {
        @strongify(superview);
        make.centerX.equalTo(superview);
        make.top.equalTo(superview).with.offset(40);
    }];
    
    [self.popPanelButton remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        @strongify(superview);
        make.top.equalTo(self.faceIdButton).offset(60);
        make.centerX.equalTo(superview);
    }];
    
    [self.playButton remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        @strongify(superview);
        make.top.equalTo(self.popPanelButton.bottom).offset(20);
        make.centerX.equalTo(superview);
    }];
    
    [self.faceIdButton remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(superview);
        make.centerY.equalTo(superview).offset(60);
        make.centerX.equalTo(superview);
    }];
    
    [self.textInputView remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.stickerView);
        make.top.equalTo(self.stickerView.bottom).with.offset(50);
        make.height.equalTo(@50);
        make.width.equalTo(@240);
    }];
    
    [self.openDetailButton remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(superview);
        make.centerX.equalTo(superview);
        make.top.equalTo(self.playButton.bottom).offset(20);
    }];
    
    [self.proxySwitch remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(superview);
        make.centerX.equalTo(superview);
        make.top.equalTo(self.openDetailButton.bottom).offset(20);
    }];
}

- (void)_bind {
    [self.playButton addTarget:self action:@selector(_playVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.faceIdButton addTarget:self action:@selector(touchUsingFaceIDButton) forControlEvents:UIControlEventTouchUpInside];
    [self.popPanelButton addTarget:self action:@selector(showPopPanel) forControlEvents:UIControlEventTouchUpInside];
    [self.openDetailButton addTarget:self action:@selector(_openDetail) forControlEvents:UIControlEventTouchUpInside];
    [self.proxySwitch addTarget:self action:@selector(_switchProxy:) forControlEvents:UIControlEventValueChanged];
    
    self.animator = [self.animator initWithReferenceView:self.view];
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] init];
    [collisionBehavior addItem:self.redCircleView];
    [collisionBehavior addItem:self.greenCircleView];
//    [collisionBehavior addBoundaryWithIdentifier:@"barrier" forPath:[UIBezierPath bezierPathWithRect:self.view.bounds]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    collisionBehavior.collisionDelegate = self;
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] init];
    gravityBehavior.magnitude *= 2;
    [gravityBehavior addItem:self.redCircleView];
    [gravityBehavior addItem:self.greenCircleView];
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] init];
    pushBehavior.angle = 2 * M_PI - gravityBehavior.angle;
    pushBehavior.magnitude = gravityBehavior.magnitude;
    self.gravityBehavior = gravityBehavior;
    self.collisionBehavior = collisionBehavior;
    self.pushBehavior = pushBehavior;
    UIDynamicItemBehavior *positiveChargeBehavior = [[UIDynamicItemBehavior alloc] init];
    positiveChargeBehavior.charge = 20;
    positiveChargeBehavior.elasticity = 1.0f;
    [positiveChargeBehavior addItem:self.redCircleView];
    UIDynamicItemBehavior *negativeChargeBehavior = [[UIDynamicItemBehavior alloc] init];
    negativeChargeBehavior.charge = -20;
    negativeChargeBehavior.elasticity = 2.0f;
    [negativeChargeBehavior addItem:self.greenCircleView];
    [self.animator addBehavior:positiveChargeBehavior];
    [self.animator addBehavior:negativeChargeBehavior];
    [self.animator addBehavior:gravityBehavior];
    [self.animator addBehavior:collisionBehavior];
    [self.animator addBehavior:pushBehavior];
    [self _useAccelerometer];
    
}

#pragma mark Motion Detector
- (void)_useAccelerometer {
    CMMotionManager *manager = self.motionManager;
    if (manager.isAccelerometerAvailable) {
        manager.accelerometerUpdateInterval = 0.1f;
        @weakify(self);
        [manager startAccelerometerUpdatesToQueue:NSOperationQueue.mainQueue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            @strongify(self);
            CMAcceleration acceleration = accelerometerData.acceleration;
            const double x = acceleration.x;
            const double y = acceleration.y;
            const double z = acceleration.z;
            self.gravityBehavior.gravityDirection = CGVectorMake(x, -y);
            self.pushBehavior.angle = 2 * M_PI - self.gravityBehavior.angle;
            self.pushBehavior.magnitude = self.gravityBehavior.magnitude;
        }];
    }
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)hideKeyboard {
    if ([self.textInputView canResignFirstResponder]) {
        [self.textInputView resignFirstResponder];
    }
}

- (void)touchUsingFaceIDButton {
    [AuthUtil usingFaceID:^(LAContext * _Nonnull context) {
        [self writeDataToKeychainWithContext:context data:nil];
    }];
}

- (void)_switchProxy:(UISwitch *)sender {
    BOOL enable = sender.isOn;
    static OHNetworkProxy *proxy = nil;
    if (!proxy) {
        proxy = [[OHNetworkProxy alloc] init];
    }
    if (enable) {
        [proxy start:nil];
    } else {
        [proxy stop];
    }
}

- (void)showPopPanel {
    UIView *panel = [[PopPanelContentView alloc] initWithCorner:UIRectCornerTopLeft|UIRectCornerTopRight ofSize:CGSizeMake(9, 9)];
    panel.backgroundColor = UIColor.grayColor;
    [panel addConstraint:[NSLayoutConstraint constraintWithItem:panel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:panel attribute:NSLayoutAttributeHeight multiplier:0 constant:400]];
    PopPanelView *panelView = [[PopPanelView alloc] initWithContentView:panel];
    [panelView showInView:self.view];
}

- (void)writeDataToKeychainWithContext:(LAContext *)context data:(NSDictionary<NSString *, id> *)data {
    NSDictionary<NSString *, id> *query = @{
        @"server": @"passport.apple.com",
        @"account": @"hi@ourfor.top",
        @"value": [@"abc123MM" dataUsingEncoding:NSUTF8StringEncoding]
    };
    BOOL isSaved = [AuthUtil writeDataToKeychainWithContext:context data:query];
    if (isSaved) {
        Toast.success(@"保存成功");
    }
}

- (NSDictionary<NSString *, id> *)readDataFromKeychainWithContext:(LAContext *)context {
    NSDictionary *query = @{
        @"server": @"passport.ourfor.top",
        @"match_limit": (__bridge id)kSecMatchLimitOne
    };
    NSDictionary<NSString *, id> *data = [AuthUtil readDataFromKeychainWithContext:context query:query];
    NSString *account = data[(__bridge NSString *)kSecAttrAccount];
    NSData *passwordData = data[(__bridge NSString *)kSecValueData];
    NSString *password = [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding];
    Toast.success(@"account: %@, password: %@", account, password);
    return data;
}

- (void)_playVideo {
    UIView *superview = self.view;
    [self.playerView showInView:superview];
}

- (void)_openDetail {
    UIViewController<UIViewControllerTransitioningDelegate> *detailViewController = [[OHDetailViewController alloc] init];
    detailViewController.transitioningDelegate = detailViewController;
    detailViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.navigationController presentViewController:detailViewController animated:YES completion:nil];
}

#pragma mark Dynamic Behavior Delegate
- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {
//    [self.gravityBehavior removeItem:item];
}

#pragma mark Getter

- (UIView *)stickerView {
    if (!_stickerView) {
        OHTextStickerView *stickerView = [[OHTextStickerView alloc] initWithModel:self.model];
        _stickerView = stickerView;
    }
    return _stickerView;
}

- (UITextField *)textInputView {
    if (!_textInputView) {
        UITextField *textInputView = [[UITextField alloc] init];
        textInputView.font = [UIFont systemFontOfSize:20];
        textInputView.borderStyle = UITextBorderStyleRoundedRect;
        textInputView.enabled = YES;
        textInputView.text = self.model.text;
        _textInputView = textInputView;
    }
    return _textInputView;
}

- (OHTextStickerModel *)model {
    if (!_model) {
        OHTextStickerModel *model = [[OHTextStickerModel alloc] init];
        model.image = @"gift";
        model.text = @"This is your gift! Have a good time.";
        model.padding = UIEdgeInsetsMake(60, 110, 6, 40);
        _model = model;
    }
    return _model;
}

- (UIButton *)popPanelButton {
    if (!_popPanelButton) {
        UIButton *popButton = [UIButton buttonWithType:UIButtonTypeCustom];
        popButton.translatesAutoresizingMaskIntoConstraints = NO;
        [popButton setTitle:@"打开弹窗" forState:UIControlStateNormal];
        popButton.backgroundColor = UIColor.blueColor;
        popButton.showsTouchWhenHighlighted = YES;
        popButton.adjustsImageWhenHighlighted = YES;
        popButton.layer.cornerRadius = BUTTON_CORNER_RADIUS;
        popButton.titleLabel.font = BUTTON_FONT;
        popButton.contentEdgeInsets = BUTTON_PADDING;
        _popPanelButton = popButton;
    }
    return _popPanelButton;
}

- (UIButton *)faceIdButton {
    if (!_faceIdButton) {
        UIButton *faceIdButton = [UIButton buttonWithType:UIButtonTypeCustom];
        faceIdButton.translatesAutoresizingMaskIntoConstraints = NO;
        [faceIdButton setTitle:@"使用FaceID" forState:UIControlStateNormal];
        [faceIdButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        faceIdButton.backgroundColor = UIColor.blackColor;
        faceIdButton.showsTouchWhenHighlighted = YES;
        faceIdButton.adjustsImageWhenHighlighted = YES;
        faceIdButton.titleLabel.font = BUTTON_FONT;
        faceIdButton.layer.cornerRadius = BUTTON_CORNER_RADIUS;
        faceIdButton.contentEdgeInsets = BUTTON_PADDING;
        [faceIdButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _faceIdButton = faceIdButton;
    }
    return _faceIdButton;
}

- (UIView *)redCircleView {
    if (!_redCircleView) {
        UIImageView *rectView = [[UIImageView alloc] init];
        rectView.backgroundColor = UIColor.redColor;
        rectView.frame = CGRectMake(0, 0, 100, 100);
        CGSize size = UIScreen.mainScreen.bounds.size;
        rectView.center = CGPointMake(size.width / 2, size.height / 2);
        rectView.layer.cornerRadius = 50;
        UIImage *image = [UIImage imageNamed:@"fruit_2"];
        rectView.image = image;
        _redCircleView = rectView;
    }
    return _redCircleView;
}

- (UIView *)greenCircleView {
    if (!_greenCircleView) {
        UIImageView *rectView = [[UIImageView alloc] init];
        rectView.backgroundColor = UIColor.greenColor;
        rectView.frame = CGRectMake(0, 0, 100, 100);
        CGSize size = UIScreen.mainScreen.bounds.size;
        rectView.center = CGPointMake(size.width / 2, size.height / 2);
        rectView.layer.cornerRadius = 50;
        UIImage *image = [UIImage imageNamed:@"fruit_3"];
        rectView.image = image;
        _greenCircleView = rectView;
    }
    return _greenCircleView;
}

- (UIView<PlayerAction> *)playerView {
    BeginLazyPropInit(playerView)
    playerView = [[OHPlayerView alloc] initWithPlayer:self.player];
    EndLazyPropInit(playerView)
}

- (AVPlayer *)player {
    BeginLazyPropInit(player)
    NSURL *url = [NSURL URLWithString:@"https://test.ourfor.top/mock/api/subscription.mp4"];
    player = [[AVPlayer alloc] initWithURL:url];
    EndLazyPropInit(player)
}

- (UIButton *)playButton {
    BeginLazyPropInit(playButton)
    playButton = [[UIButton alloc] init];
    [playButton setTitle:@"播放" forState:UIControlStateNormal];
    playButton.layer.cornerRadius = BUTTON_CORNER_RADIUS;
    playButton.titleLabel.font = BUTTON_FONT;
    playButton.contentEdgeInsets = BUTTON_PADDING;
    [playButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    playButton.backgroundColor = UIColor.blackColor;
    EndLazyPropInit(playButton)
}

- (UIButton *)openDetailButton {
    BeginLazyPropInit(openDetailButton)
    openDetailButton = [[UIButton alloc] init];
    [openDetailButton setTitle:@"转场" forState:UIControlStateNormal];
    openDetailButton.layer.cornerRadius = BUTTON_CORNER_RADIUS;
    openDetailButton.titleLabel.font = BUTTON_FONT;
    openDetailButton.contentEdgeInsets = BUTTON_PADDING;
    openDetailButton.backgroundColor = UIColor.grayColor;
    EndLazyPropInit(openDetailButton)
}

- (UISwitch *)proxySwitch {
    BeginLazyPropInit(proxySwitch)
    proxySwitch = [[UISwitch alloc] init];
    EndLazyPropInit(proxySwitch)
}

- (UIDynamicAnimator *)animator {
    BeginLazyPropInit(animator)
    animator = [UIDynamicAnimator alloc];
    EndLazyPropInit(animator)
}

- (OHWatchView *)watchView {
    BeginLazyPropInit(watchView)
    watchView = [[OHWatchView alloc] init];
    EndLazyPropInit(watchView)
}

- (CMMotionManager *)motionManager {
    BeginLazyPropInit(motionManager)
    motionManager = [[CMMotionManager alloc] init];
    EndLazyPropInit(motionManager)
}
@end
