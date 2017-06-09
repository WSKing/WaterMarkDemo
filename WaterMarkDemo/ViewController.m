//
//  ViewController.m
//  WaterMarkDemo
//
//  Created by wsk on 17/6/8.
//  Copyright © 2017年 wsk. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Util.h"
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImage *markImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *bgImg = [[UIImage imageWithColor:[UIColor whiteColor]] scaledToSize:CGSizeMake(SCREEN_WIDTH * 3, SCREEN_HEIGHT *2)];
    UIImage *drawImg = [self addWatemarkTextAfteriOS7_WithLogoImage:bgImg watemarkText:@"我是水印"];
    self.markImage = [self rotationImage:drawImg];
    [self.tableView setContentMode:UIViewContentModeBottomRight];
    [self.view addSubview:self.tableView];
    self.tableView.layer.contents = (__bridge id _Nullable)(self.markImage.CGImage);

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    }
    cell.textLabel.text = @"水印测试";
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 60;
        UIView *headView = [UIView new];
        headView.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = headView;
        UIView *footerView = [UIView new];
        footerView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = footerView;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

//文字水印
- (UIImage *)addWatemarkTextAfteriOS7_WithLogoImage:(UIImage *)logoImage watemarkText:(NSString *)watemarkText {
    int w = SCREEN_WIDTH*3;
    int h = SCREEN_HEIGHT;
    UIGraphicsBeginImageContext(CGSizeMake(w, h));
    [[UIColor whiteColor] set];
    [logoImage drawInRect:CGRectMake(-SCREEN_WIDTH, -SCREEN_HEIGHT, w, h)];
    UIFont * font = [UIFont systemFontOfSize:10.0];
   
    NSInteger line = SCREEN_HEIGHT*3/ 100; //多少行
    NSInteger row = 20;
    for (int i = 0; i < line; i ++) {
        for (int j = 0; j < row; j ++) {
             [watemarkText drawInRect:CGRectMake(j * (SCREEN_WIDTH/3.5), (i-3)*100, 90, 25) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor redColor]}];
        }
    }
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//image旋转
- (UIImage *)rotationImage:(UIImage *)image {
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    rotate = M_PI_4;
    rect = CGRectMake(0, 0, image.size.height, image.size.width);
    translateX = 0;
    translateY = -rect.size.width;
    scaleY = rect.size.width/rect.size.height *1.5;
    scaleX = rect.size.height/rect.size.width *1.5;
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

@end
