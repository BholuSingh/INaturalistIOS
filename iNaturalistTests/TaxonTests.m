//
//  TaxonTests.m
//  iNaturalist
//
//  Created by Alex Shepard on 1/2/17.
//  Copyright © 2017 iNaturalist. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <RestKit/Testing.h>

#import "Taxon.h"

@interface TaxonTests : XCTestCase
@property RKManagedObjectStore *objectStore;
@end

@implementation TaxonTests

- (void)setUp {
    [super setUp];

    NSBundle *testTargetBundle = [NSBundle bundleForClass:self.class];
    [RKTestFixture setFixtureBundle:testTargetBundle];
    [RKTestFactory setUp];
    
    [RKTestFactory defineFactory:RKTestFactoryDefaultNamesManagedObjectStore withBlock:^id{
        NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:@[[NSBundle mainBundle]]];
        RKManagedObjectStore *managedObjectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"inaturalistTests.sqlite"
                                                                                usingSeedDatabaseName:nil
                                                                                   managedObjectModel:managedObjectModel
                                                                                             delegate:nil];
        return managedObjectStore;
    }];
    self.objectStore = [RKTestFactory managedObjectStore];

}

- (void)tearDown {
    [super tearDown];
    [RKTestFactory tearDown];
}

- (void)testWikipediaUrlNullTitle {
    Taxon *taxon = [self taxonForFixture:@"Octopus_rubescens.json"];
    XCTAssertTrue([[taxon wikipediaUrl] isEqual:[NSURL URLWithString:@"https://en.wikipedia.org/wiki/Octopus%20rubescens"]],
                  @"Constructured URL for Octopus rubescens with null wikipedia title is incorrect.");
}

- (void)testWikipediaUrlEmptyTitle {
    Taxon *taxon = [self taxonForFixture:@"Diptera.json"];
    XCTAssertTrue([[taxon wikipediaUrl] isEqual:[NSURL URLWithString:@"https://en.wikipedia.org/wiki/Diptera"]],
                  @"Constructured URL for Diptera with empty wikipedia title is incorrect.");
}


- (void)testWikipediaUrlValidTitle {
    Taxon *taxon = [self taxonForFixture:@"Gollum.json"];
    XCTAssertTrue([[taxon wikipediaUrl] isEqual:[NSURL URLWithString:@"https://en.wikipedia.org/wiki/Gollum_(genus)"]],
                  @"Constructured URL for Diptera with empty wikipedia title is incorrect.");
}


- (Taxon *)taxonForFixture:(NSString *)fixtureFileName {
    id parsedJSON = [RKTestFixture parsedObjectWithContentsOfFixture:fixtureFileName];
    
    Taxon *taxon = [Taxon createEntity];
    
    RKMappingTest *test = [RKMappingTest testForMapping:[Taxon mapping]
                                           sourceObject:parsedJSON
                                      destinationObject:taxon];
    @try {
        [test performMapping];
    } @catch (NSException *exception) {
        // restkit can throw spurious exceptions during taxon mappings
        // maybe isn't correctly mapping relationships?
        // do nothing
    }
    
    return taxon;
}

@end
