# Modelo Lógico para E-commerce
Este projeto foi desenvolvido e  aprimorado como parte do curso SQL Specialist da DIO, e foi feito no MySQL Workbench. O modelo conceitual foi desenvolvido usando o modelo entidade-relacionamento (ER), que é um modelo gráfico para representar a estrutura de dados de um sistema de informação.

# Narrativa

 - Produto:
    - Os produtos são vendidos por uma única plataforma online. Contudo, estes podem ter vendedores distintos (terceiros).
    - Cada produto possuí um fornecedor.
    - Um ou mais produtos podem compor um pedido.

 - Cliente:
    - O cliente pode se cadastrar no site com seu CPF ou CNPJ.
    - O endereço do cliente irá determinar o valor do frete.
    - Um cliente pode comprar mais de um pedido. Este tem um período de carência para devolução do produto.

 - Pedido:
    - Os pedidos são criados por clientes e possuem informações de compra, endereço e status de entrega.
    - Um produto ou mais compõem o pedido.
    - O pedido pode ser cancelado.

 - Fornecedor:
    - Pensando junto com a professora.
    - Possuíra CPF ou CNPJ.
    - Razão Social

 - Estoque:
    - Necessário informar a quantidade dos produtos em estoque.
    - Informar local. (?)
