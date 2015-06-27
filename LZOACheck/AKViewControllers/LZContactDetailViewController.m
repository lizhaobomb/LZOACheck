//
//  LZContactDetailViewController.m
//  
//
//  Created by lizhao on 15/6/26.
//
//

#import "LZContactDetailViewController.h"
#import "Contact.h"
#import <MessageUI/MessageUI.h>
@interface LZContactDetailViewController () <UITableViewDataSource, UITableViewDelegate,MFMessageComposeViewControllerDelegate> {
    UITableView *_contactDetailList;
}

@end

@implementation LZContactDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)initContentView {
    _contactDetailList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    _contactDetailList.delegate = self;
    _contactDetailList.dataSource = self;
    _contactDetailList.tableFooterView = [[UIView alloc] init];
    _contactDetailList.tableHeaderView = [self tableHeaderView];
    [self.view addSubview:_contactDetailList];
}

- (UIView *)tableHeaderView {
    UIView *tableHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 325/3)];
    tableHeader.backgroundColor = [UIColor darkGrayColor];
    
    UIImageView *avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar"]];
    avatar.frame = CGRectMake(47/3, 47/3, avatar.width, avatar.height);
    [tableHeader addSubview:avatar];
    
    UILabel *nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(avatar.right + 12, avatar.top + 12, 100, 20)];
    nameLbl.font = [UIFont systemFontOfSize:20];
    nameLbl.textColor = [UIColor whiteColor];
    nameLbl.text = _contact.loginName;
    [tableHeader addSubview:nameLbl];
    
    UILabel *genderLbl = [[UILabel alloc] initWithFrame:CGRectMake(nameLbl.left, nameLbl.bottom + 12, 100, 15)];
    genderLbl.font = [UIFont systemFontOfSize:15];
    genderLbl.textColor = [UIColor whiteColor];
    genderLbl.text = [_contact.sex intValue] == 0 ? @"男" : @"女";
    [tableHeader addSubview:genderLbl];
    
    return tableHeader;
}


#pragma mark - MFMessageComposeDelegate
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [self configCell:cell indexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)dialNum {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_contact.mobile1]]];
}

- (void)sendSms {
    MFMessageComposeViewController *message = [[MFMessageComposeViewController alloc] init];
    message.messageComposeDelegate = self;
    message.recipients = @[_contact.mobile1];
    [self presentViewController:message animated:YES completion:nil];
}

- (UIView *)phoneAndSmsView {
    UIView *phoneAndSmsView = [[UIView alloc] init];
    
    UIButton *mobileBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mobileBtn.frame = CGRectMake(0, 0, 100/3, 100/3);
    [mobileBtn setBackgroundImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    mobileBtn.center = CGPointMake(mobileBtn.center.x, 50/2);
    [mobileBtn addTarget:self action:@selector(dialNum) forControlEvents:UIControlEventTouchUpInside];
    [phoneAndSmsView addSubview:mobileBtn];

    UIButton *smsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    smsBtn.frame = CGRectMake(mobileBtn.right+47/3, mobileBtn.top, 100/3, 100/3);
    [smsBtn setBackgroundImage:[UIImage imageNamed:@"sms"] forState:UIControlStateNormal];
    [smsBtn addTarget:self action:@selector(sendSms) forControlEvents:UIControlEventTouchUpInside];
    [phoneAndSmsView addSubview:smsBtn];

    CGFloat viewWidth = mobileBtn.width+smsBtn.width+47/3;
    phoneAndSmsView.frame = CGRectMake(self.view.width - viewWidth - 47/3, 0, viewWidth, 50);
    return phoneAndSmsView;
}


- (void)configCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text = _contact.mobile1;
            cell.imageView.image = [UIImage imageNamed:@"mobile"];
            [cell.contentView addSubview:[self phoneAndSmsView]];
        }
            break;
        case 1:{
            cell.textLabel.text = _contact.telephone1;
            cell.imageView.image = [UIImage imageNamed:@"telephone"];
        }
            break;
        case 2:{
            cell.textLabel.text = _contact.address;
            cell.imageView.image = [UIImage imageNamed:@"address"];
        }
            break;
        case 3:{
            cell.textLabel.text = _contact.email;
            cell.imageView.image = [UIImage imageNamed:@"email"];
        }

            
        default:
            break;
    }
}

@end
