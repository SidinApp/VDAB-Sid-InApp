//
//  StudentFormViewController.m
//  Sid-InApp
//
//  Created by  on 04/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import "StudentFormViewController.h"

@interface StudentFormViewController ()

// verplicht
@property (weak, nonatomic) IBOutlet UITextField *firstNameInput;
@property (weak, nonatomic) IBOutlet UITextField *lastNameInput;
@property (weak, nonatomic) IBOutlet UITextField *mailInput;

@property (weak, nonatomic) IBOutlet UISwitch *digxInterestSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *multecInterestSwitch;

// optioneel
@property (weak, nonatomic) IBOutlet UISwitch *werkstudentInterestSwitch;

@property (weak, nonatomic) IBOutlet UITextField *streetInput;
@property (weak, nonatomic) IBOutlet UITextField *streetNumberInput;
@property (weak, nonatomic) IBOutlet UITextField *cityInput;
@property (weak, nonatomic) IBOutlet UITextField *zipInput;

@property (weak, nonatomic) IBOutlet UITextField *schoolInput;

@end

@implementation StudentFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
