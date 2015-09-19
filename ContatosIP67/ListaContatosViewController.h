//
//  ListaContatosViewController.h
//  ContatosIP67
//
//  Created by ios5380 on 12/09/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContatoDao.h"
#import "FormularioContatoViewController.h"

@interface ListaContatosViewController : UITableViewController <FormularioContatoViewControllerDelegate>

@property (readonly) ContatoDao *dao;
@property (readonly) Contato *contatoSelecionado;
@property (readonly) NSInteger linhaDestaque;

@end
