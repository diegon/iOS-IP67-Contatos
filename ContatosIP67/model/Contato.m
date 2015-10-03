//
//  Contato.m
//  ContatosIP67
//
//  Created by ios5380 on 05/09/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "Contato.h"

@implementation Contato

// Analogo ao toString
- (NSString *)description {
    return [NSString stringWithFormat:@"Nome: %@, Telefone: %@, Email: %@, Endereco: %@, Latitude: %@, Longitude: %@, Site: %@", self.nome, self.telefone, self.email, self.endereco, self.latitude, self.longitude, self.site];
}

- (CLLocationCoordinate2D) coordinate {
    return CLLocationCoordinate2DMake([self.latitude floatValue], [self.longitude floatValue]);
}

- (NSString *) title {
    return self.nome;
}

@end
