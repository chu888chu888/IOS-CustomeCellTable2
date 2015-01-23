//
//  MSMenuTableViewController.m
//  CustomeCellTable
//
//  Created by chuguangming on 15/1/23.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import "MSMenuTableViewController.h"
#import "MSMenuCell.h"
#import "MSMenuTableViewHeader.h"
NSString * const MSMenuCellReuseIdentifier = @"Drawer Cell";
NSString * const MSDrawerHeaderReuseIdentifier = @"Drawer Header";

typedef NS_ENUM(NSUInteger, MSMenuViewControllerTableViewSectionType) {
    MSMenuViewControllerTableViewSectionTypeOptions,
    MSMenuViewControllerTableViewSectionTypeExamples,
    MSMenuViewControllerTableViewSectionTypeAbout,
    MSMenuViewControllerTableViewSectionTypeCount
};
@interface MSMenuTableViewController ()
@property (nonatomic, strong) NSDictionary *paneViewControllerTitles;
@property (nonatomic, strong) NSDictionary *paneViewControllerClasses;
@property (nonatomic, strong) NSDictionary *sectionTitles;
@property (nonatomic, strong) NSArray *tableViewSectionBreaks;

@property (nonatomic, strong) UIBarButtonItem *paneStateBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *paneRevealLeftBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *paneRevealRightBarButtonItem;
@end

@implementation MSMenuTableViewController
#pragma mark - NSObject

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
        NSLog(@"initWithCoder");
    }
    return self;
}

#pragma mark - UIViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initialize];
        NSLog(@"initWithNibName");
    }
    return self;
}

- (void)loadView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[MSMenuCell class] forCellReuseIdentifier:MSMenuCellReuseIdentifier];
    [self.tableView registerClass:[MSMenuTableViewHeader class] forHeaderFooterViewReuseIdentifier:MSDrawerHeaderReuseIdentifier];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorColor = [UIColor colorWithWhite:1.0 alpha:0.25];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - MSMenuViewController

- (void)initialize
{
    self.paneViewControllerType = NSUIntegerMax;
    self.paneViewControllerTitles = @{
                                      @(MSPaneViewControllerTypeStylers) : @"Stylers",
                                      @(MSPaneViewControllerTypeDynamics) : @"Dynamics",
                                      @(MSPaneViewControllerTypeBounce) : @"Bounce",
                                      @(MSPaneViewControllerTypeGestures) : @"Gestures",
                                      @(MSPaneViewControllerTypeControls) : @"Controls",
                                      @(MSPaneViewControllerTypeMap) : @"Map",
                                      @(MSPaneViewControllerTypeEditableTable) : @"Editable Table",
                                      @(MSPaneViewControllerTypeLongTable) : @"Long Table",
                                      @(MSPaneViewControllerTypeMonospace) : @"Monospace Ltd."
                                      };
    self.paneViewControllerClasses = @{
                                       @(MSPaneViewControllerTypeStylers) : @"Stylers",
                                       @(MSPaneViewControllerTypeDynamics) : @"Dynamics",
                                       @(MSPaneViewControllerTypeBounce) : @"Bounce",
                                       @(MSPaneViewControllerTypeGestures) : @"Gestures",
                                       @(MSPaneViewControllerTypeControls) : @"Controls",
                                       @(MSPaneViewControllerTypeMap) : @"Map",
                                       @(MSPaneViewControllerTypeEditableTable) : @"Editable Table",
                                       @(MSPaneViewControllerTypeLongTable) : @"Long Table",
                                       @(MSPaneViewControllerTypeMonospace) : @"Monospace Ltd."
                                       };
    
    self.sectionTitles = @{
                           @(MSMenuViewControllerTableViewSectionTypeOptions) : @"Options",
                           @(MSMenuViewControllerTableViewSectionTypeExamples) : @"Examples",
                           @(MSMenuViewControllerTableViewSectionTypeAbout) : @"About",
                           };
    
    self.tableViewSectionBreaks = @[
                                    @(MSPaneViewControllerTypeControls),
                                    @(MSPaneViewControllerTypeMonospace),
                                    @(MSPaneViewControllerTypeCount)
                                    ];
}
- (MSPaneViewControllerType)paneViewControllerTypeForIndexPath:(NSIndexPath *)indexPath
{
    MSPaneViewControllerType paneViewControllerType;
    if (indexPath.section == 0) {
        paneViewControllerType = indexPath.row;
    } else {
        paneViewControllerType = ([self.tableViewSectionBreaks[(indexPath.section - 1)] integerValue] + indexPath.row);
    }
    NSAssert(paneViewControllerType < MSPaneViewControllerTypeCount, @"Invalid Index Path");
    return paneViewControllerType;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return MSMenuViewControllerTableViewSectionTypeCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (section == 0) {
        return [self.tableViewSectionBreaks[section] integerValue];
    } else {
        return ([self.tableViewSectionBreaks[section] integerValue] - [self.tableViewSectionBreaks[(section - 1)] integerValue]);
    }
}
/*返回每一个Section的自定义头*/
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:MSDrawerHeaderReuseIdentifier];
    headerView.textLabel.text = [self.sectionTitles[@(section)] uppercaseString];
    return headerView;
}
/*返回每一个Section的自定义头的高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}
/*返回每一个Section的自定义尾的高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return FLT_EPSILON;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MSMenuCellReuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.paneViewControllerTitles[@([self paneViewControllerTypeForIndexPath:indexPath])];
    return cell;
}
/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
