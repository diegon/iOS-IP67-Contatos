//
//  ListaContatosViewController.h
//  ContatosIP67
//
//  Created by ios5380 on 12/09/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContatoDao.h"

@interface ListaContatosViewController : UITableViewController

@property (readonly) ContatoDao *dao;
@property (readonly) Contato *contatoSelecionado;

@end
