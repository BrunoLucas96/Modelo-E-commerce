-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema E-commcerce DB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema E-commcerce DB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `E-commcerce DB` DEFAULT CHARACTER SET utf8 ;
USE `E-commcerce DB` ;

-- -----------------------------------------------------
-- Table `E-commcerce DB`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commcerce DB`.`Cliente` (
  `idCliente` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Endereço` VARCHAR(45) NOT NULL,
  `Telefone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `E-commcerce DB`.`Entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commcerce DB`.`Entrega` (
  `idEntrega` INT NOT NULL,
  `Status` VARCHAR(45) NOT NULL,
  `Código Rastreio` VARCHAR(45) NOT NULL,
  `Data` DATE NOT NULL,
  PRIMARY KEY (`idEntrega`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `E-commcerce DB`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commcerce DB`.`Pedido` (
  `idPedido` INT NOT NULL,
  `Status do Pedido` VARCHAR(45) NOT NULL,
  `Descrição` VARCHAR(45) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Frete` FLOAT NOT NULL,
  `Entrega_idEntrega` INT NOT NULL,
  PRIMARY KEY (`idPedido`, `Cliente_idCliente`, `Entrega_idEntrega`),
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Pedido_Entrega1_idx` (`Entrega_idEntrega` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `E-commcerce DB`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Entrega1`
    FOREIGN KEY (`Entrega_idEntrega`)
    REFERENCES `E-commcerce DB`.`Entrega` (`idEntrega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `E-commcerce DB`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commcerce DB`.`Produto` (
  `idProduto` INT NOT NULL,
  `Categoria` VARCHAR(45) NOT NULL,
  `Descrição` VARCHAR(45) NULL,
  `Valor` FLOAT NOT NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `E-commcerce DB`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commcerce DB`.`Fornecedor` (
  `idFornecedor` INT NOT NULL,
  `Razão Social` VARCHAR(45) NOT NULL,
  `CNPJ` VARCHAR(45) NOT NULL,
  `Contato` VARCHAR(45) NOT NULL,
  `Fornecedorcol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idFornecedor`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE,
  UNIQUE INDEX `Contato_UNIQUE` (`Contato` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `E-commcerce DB`.`Fornece`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commcerce DB`.`Fornece` (
  `Fornecedor_idFornecedor` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  PRIMARY KEY (`Fornecedor_idFornecedor`, `Produto_idProduto`),
  INDEX `fk_Fornecedor_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Fornecedor_has_Produto_Fornecedor_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_Fornecedor_has_Produto_Fornecedor`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `E-commcerce DB`.`Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fornecedor_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `E-commcerce DB`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `E-commcerce DB`.`Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commcerce DB`.`Estoque` (
  `idEstoque` INT NOT NULL,
  `Local` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEstoque`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `E-commcerce DB`.`Produto_has_Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commcerce DB`.`Produto_has_Estoque` (
  `Produto_idProduto` INT NOT NULL,
  `Estoque_idEstoque` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Estoque_idEstoque`),
  INDEX `fk_Produto_has_Estoque_Estoque1_idx` (`Estoque_idEstoque` ASC) VISIBLE,
  INDEX `fk_Produto_has_Estoque_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Estoque_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `E-commcerce DB`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Estoque_Estoque1`
    FOREIGN KEY (`Estoque_idEstoque`)
    REFERENCES `E-commcerce DB`.`Estoque` (`idEstoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `E-commcerce DB`.`Relação de Produto/Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commcerce DB`.`Relação de Produto/Pedido` (
  `Produto_idProduto` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Pedido_idPedido`),
  INDEX `fk_Produto_has_Pedido_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  INDEX `fk_Produto_has_Pedido_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Pedido_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `E-commcerce DB`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Pedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `E-commcerce DB`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `E-commcerce DB`.`Terceiro - Vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commcerce DB`.`Terceiro - Vendedor` (
  `idTerceiro` INT NOT NULL,
  `Razão Social` VARCHAR(45) NOT NULL,
  `Local` VARCHAR(45) NOT NULL,
  `Contato` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTerceiro`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `E-commcerce DB`.`Produtos por Vendedor (terceiros)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commcerce DB`.`Produtos por Vendedor (terceiros)` (
  `Terceiro - Vendedor_idTerceiro` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  PRIMARY KEY (`Terceiro - Vendedor_idTerceiro`, `Produto_idProduto`),
  INDEX `fk_Terceiro - Vendedor_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Terceiro - Vendedor_has_Produto_Terceiro - Vendedor1_idx` (`Terceiro - Vendedor_idTerceiro` ASC) VISIBLE,
  CONSTRAINT `fk_Terceiro - Vendedor_has_Produto_Terceiro - Vendedor1`
    FOREIGN KEY (`Terceiro - Vendedor_idTerceiro`)
    REFERENCES `E-commcerce DB`.`Terceiro - Vendedor` (`idTerceiro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Terceiro - Vendedor_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `E-commcerce DB`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `E-commcerce DB`.`P. Jurídica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commcerce DB`.`P. Jurídica` (
  `idPJ` INT NOT NULL,
  `CNP` VARCHAR(45) NOT NULL,
  `Razão Social` VARCHAR(45) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`Cliente_idCliente`),
  CONSTRAINT `fk_P. Jurídica_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `E-commcerce DB`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `E-commcerce DB`.`P. Física`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commcerce DB`.`P. Física` (
  `idFísica` INT NOT NULL,
  `CPF` VARCHAR(45) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `RG` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idFísica`, `Cliente_idCliente`),
  INDEX `fk_P. Física_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_P. Física_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `E-commcerce DB`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `E-commcerce DB`.`Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `E-commcerce DB`.`Pagamento` (
  `idPagamento` INT NOT NULL,
  `Cartão` VARCHAR(45) NOT NULL,
  `Bandeira` VARCHAR(45) NOT NULL,
  `Numero Cartão` VARCHAR(45) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idPagamento`, `Cliente_idCliente`),
  INDEX `fk_Pagamento_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamento_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `E-commcerce DB`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
