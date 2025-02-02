//
//  ReflectViewController.m
//  StudyiOS
//
//  Created by  on 11-10-6.
//  Copyright (c) 2011年 ZhangYiCheng. All rights reserved.
//

#import "ReflectViewController.h"
#import "IIReflectionImage.h"

#define kReflectAlpha   0.8 // 映射图片透明度
#define kReflectHeight  1.0 // 映射图片高度

@implementation ReflectViewController

@synthesize imageView;
@synthesize reflectView;
@synthesize alphaSlider;
@synthesize heightSlider;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    // 增加Code按钮，可跳转至教学页面
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Code" style:UIBarButtonItemStyleBordered target:self action:@selector(code)];
    self.navigationItem.rightBarButtonItem = item;
    
    self.alphaSlider.value = kReflectAlpha;
    self.heightSlider.value = kReflectHeight;
    
    self.reflectView.alpha = kReflectAlpha;
    // 设置映射比例
    NSUInteger height = self.imageView.bounds.size.height * kReflectHeight;
    // 得到映射图片
    self.reflectView.image = [IIReflectionImage reflectedImage:self.imageView withHeight:height];
    
    [super viewDidLoad];

}


- (void)viewDidUnload
{
    self.imageView = nil;
    self.reflectView = nil;
    self.alphaSlider = nil;
    self.heightSlider = nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (IBAction)alphaSliderChanged {
    self.reflectView.alpha = self.alphaSlider.value;
}

- (IBAction)heightSliderChanged {
    NSUInteger height = self.imageView.bounds.size.height*self.heightSlider.value;
    self.reflectView.image = [IIReflectionImage reflectedImage:self.imageView withHeight:height];
    
}

// 跳转至教学页面
- (void)code
{
    CodeViewController *controller = [[CodeViewController alloc] init];
    NSString *name = [NSString stringWithUTF8String:object_getClassName(self)];
    controller.className = name;
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
