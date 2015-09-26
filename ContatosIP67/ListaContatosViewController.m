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
    //self = [super initWithStyle:UITableViewStyleGrouped];
    self = [super init];
    if(self) {
        _dao = [ContatoDao contatoDaoInstance];
        _linhaDestaque = -1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // criando botao para colocar no navigation bar, filho de UIButton
    
    //SEL exibeForm = @selector(exibeFormulario);
    
    UIBarButtonItem *form = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(exibeFormulario)];
    
    // @[] é um atalho para criar um array imutavel
    // @"" é um atalho para criar uma string
    // obtendo o navigation bar e adicionando botao na direita
    self.navigationItem.rightBarButtonItems = @[form];
    self.editButtonItem.title = @"Editar";
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = @"Contatos";
    
    // CGPoint, CGRect, CGSize sao structs C que contem as informacoes
//    UIButton *botao = [[UIButton alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)]
//    [self.tableView indexPathForRowAtPoint:<#(CGPoint)#>];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(exibeMaisAcoes:)];
    [self.tableView addGestureRecognizer:longPress];

}

// para trocar o texto no evento de editar/cancelar edicao
// http://stackoverflow.com/questions/5425718/iphone-uitableview-change-default-edit-button-name
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    // Make sure you call super first
    [super setEditing:editing animated:animated];
    
    if (editing) {
        self.editButtonItem.title = NSLocalizedString(@"Cancelar", @"Cancelar");
    } else {
        self.editButtonItem.title = NSLocalizedString(@"Editar", @"Editar");
    }
    
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
    
    if(contato.foto) {
        cell.imageView.image = contato.foto;
    } else {
        cell.imageView.image = [UIImage imageNamed:@"default_user.png"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(editingStyle == UITableViewCellEditingStyleDelete ) {
        [_dao removeContatoDaPosicao:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _contatoSelecionado = [_dao contatoDaPosicao:indexPath.row];
    [self exibeFormulario];
    _contatoSelecionado = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    if(_linhaDestaque >= 0){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_linhaDestaque inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        _linhaDestaque = -1;
    }

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
    // ou poderia ser como abaixo
    //FormularioContatoViewController *formularioContatoViewController = [storyboard instantiateInitialViewController];
    
    if(_contatoSelecionado) {
        formularioContatoViewController.contato = _contatoSelecionado;
    }
    
    formularioContatoViewController.delegate = self;
    
    [self.navigationController pushViewController:formularioContatoViewController animated:YES];
}


- (void)contatoAtualizado:(Contato *)contato {
    _linhaDestaque = [_dao buscaPosicaoDoContato:contato];
    NSLog(@"contato atualizado: %@", contato.nome);
}

- (void)contatoAdicionado:(Contato *)contato {
    _linhaDestaque = [_dao buscaPosicaoDoContato:contato];
    NSLog(@"contato adicionado: %@", contato.nome);
}

- (void)exibeMaisAcoes:(UIGestureRecognizer *)gesture {
    if(gesture.state == UIGestureRecognizerStateBegan) {
        CGPoint ponto = [gesture locationInView:self.tableView];
        NSIndexPath *index = [self.tableView indexPathForRowAtPoint:ponto];
        
        if(index) {
            _contatoSelecionado = [self.dao contatoDaPosicao:index.row];
            _gerenciador = [[GerenciadorDeAcoes alloc] initWithContato:_contatoSelecionado];
            [self.gerenciador acoesDoController:self];
        }
    }
}

@end
