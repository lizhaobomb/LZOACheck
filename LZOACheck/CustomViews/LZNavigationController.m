//
//  LZNavigationController.m
//  
//
//  Created by lizhao on 15/6/27.
//
//

#import "LZNavigationController.h"
#import "LZCoreMacros.h"
@interface LZNavigationController ()

@end

@implementation LZNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = UIColorFromRGB(0xcc3230);
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self rightBarButton]];
}

- (UIButton *) rightBarButton {
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 30, 30);
    [rightBtn setTitle:@"设置" forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"address"] forState:UIControlStateNormal];
    return rightBtn ;
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
