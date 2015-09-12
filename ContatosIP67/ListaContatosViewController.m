//
//  ListaContatosViewController.m
//  ContatosIP67
//
//  Created by ios5380 on 12/09/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "ListaContatosViewController.h"
#import "FormularioContatoViewController.h"

@interface ListaContatosViewController ()

@end

@implementation ListaContatosViewController

- (id)init {
    self = [super init];
    if(self) {
        _dao = [ContatoDao contatoDaoInstance];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // criando botao para colocar no navigation bar, filho de UIButton
    UIBarButtonItem *form = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(exibeFormulario)];
    
    // @[] é um atalho para criar um array imutavel
    // @"" é um atalho para criar uma string
    // obtendo o navigation bar e adicionando botao na direita
    self.navigationItem.rightBarButtonItems = @[form];
    
    self.navigationItem.title = @"Contatos";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// CUSTOMIZACAO
// customiza quantidade de secoes (implementacao padrao ja retorna 1)
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dao total];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // cria o identificador uma vez só, nao recria em chamadas subsequentes
    static NSString *identificador = @"cell";
    
    // recupera a celula com o identificador para reuso
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identificador];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identificador];
    }

    Contato *contato = [_dao contatoDaPosicao:indexPath.row];
    cell.textLabel.text = contato.nome;
    
    return cell;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
                             
- (void)exibeFormulario {
    NSLog(@"Exibindo formulario para criacao de um novo contato");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FormularioContatoViewController *formularioContatoViewController = [storyboard instantiateViewControllerWithIdentifier:@"Form_Contato"];
    [self.navigationController pushViewController:formularioContatoViewController animated:YES];
}

@end
