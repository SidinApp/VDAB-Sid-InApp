//
//  SchoolTableViewController.m
//  Sid-InApp
//
//  Created by  on 10/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import "SchoolTableViewController.h"
#import "StudentFormViewController.h"

#import <RestKit/CoreData.h>
#import <RestKit/RestKit.h>

#import "School.h"
#import "SchoolList.h"

#import "AppDelegate.h"

@interface SchoolTableViewController ()
{
    NSArray *schools;
}

@end

@implementation SchoolTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchSchoolsFromContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return schools.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    School *tempSchool = [schools objectAtIndex:indexPath.row];
    
    cell.textLabel.text = tempSchool.name;
    
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    SchoolEntity *school = [schools objectAtIndex:indexPath.row];
    
    NSString *schoolName = cell.textLabel.text;
    
    StudentFormViewController *studentFormController = (StudentFormViewController *)self.presentingViewController;
    studentFormController.school = school;
    studentFormController.tfSchool.text = schoolName;    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)fetchSchoolsFromContext{
    
    schools = [self.synchronizationService.persistentStoreManager fetchAll:[School entityName] sort:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
}

@end
