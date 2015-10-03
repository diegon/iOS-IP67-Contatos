//
//  Contato.h
//  ContatosIP67
//
//  Created by ios5380 on 05/09/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreData/CoreData.h>

@interface Contato : NSManagedObject<MKAnnotation>

@property (strong) NSString *nome;
@property (strong) NSString *telefone;
@property (strong) NSString *email;
@property (strong) NSString *endereco;
@property (strong) NSString *site;
//-(NSString *) description; -- nao precisa declarar, analogo ao toString
@property (strong) UIImage *foto;
@property (strong) NSNumber *latitude;
@property (strong) NSNumber *longitude;

// Contrato do MKAnnotation
- (CLLocationCoordinate2D) coordinate;
- (NSString *) title;
- (NSString *) subtitle;

@end
