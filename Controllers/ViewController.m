//
//  ViewController.m
//  PersistenceDemo
//
//  Created by Phoenix on 5/27/14.
//  Copyright (c) 2014 intel. All rights reserved.
//

#import "ViewController.h"
#import "CodeMonkey.h"
#import "PropertyListStore.h"
#import "JSONStore.h"

#define kArchiveFileName    @"archive_data.archive"
#define kDatabaseFileName   @"sqlite_data.db"
#define kCoreDataFileName   @"coredata_data.db"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *manifestTextField;
@property (weak, nonatomic) IBOutlet UITextField *locTextField;

- (IBAction)usePropertyList:(id)sender;
- (IBAction)useJSON:(id)sender;
- (IBAction)UseObjectArchive:(id)sender;
- (IBAction)useSQLite:(id)sender;
- (IBAction)useCoreData:(id)sender;

- (CodeMonkey *)WelcomeCodeMonkey;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
  [self.view addGestureRecognizer:tap];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private
- (IBAction)usePropertyList:(id)sender {
  CodeMonkey *cm = [self WelcomeCodeMonkey];
  [[PropertyListStore sharedStore] save:cm];
  CodeMonkey *jack = [[PropertyListStore sharedStore] load];
  NSLog(@"Show CodeMonkey = %@", [jack toDict]);
}

- (IBAction)useJSON:(id)sender {
  CodeMonkey *cm = [self WelcomeCodeMonkey];
  [[JSONStore sharedStore] save:cm];
  CodeMonkey *jack = [[JSONStore sharedStore] load];
  NSLog(@"Show CodeMonkey = %@", [jack toDict]);
}

- (IBAction)UseObjectArchive:(id)sender {
}

- (IBAction)useSQLite:(id)sender {
}

- (IBAction)useCoreData:(id)sender {
}

- (CodeMonkey *)WelcomeCodeMonkey; {
  CodeMonkey *cm = [[CodeMonkey alloc] init];
  cm.name = self.nameTextField.text;
  cm.manifest = self.manifestTextField.text;
  cm.linesOfCode = [self.locTextField.text integerValue];

  return cm;
}

- (void)hideKeyboard:(UITapGestureRecognizer *)sender {
  [self.nameTextField resignFirstResponder];
  [self.manifestTextField resignFirstResponder];
  [self.locTextField resignFirstResponder];
}

@end
