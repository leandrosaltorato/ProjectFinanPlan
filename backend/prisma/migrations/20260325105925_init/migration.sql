-- CreateTable
CREATE TABLE `Usuarios` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(191) NOT NULL,
    `senha` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `Telefone` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Administradores` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(191) NOT NULL,
    `senha` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `cargo` ENUM('ADMIN') NOT NULL,
    `telefone` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Controle` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `saldo` DOUBLE NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `UsuariosControles` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `usuariosId` INTEGER NOT NULL,
    `controleId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Transacoes` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `data` DATETIME(3) NOT NULL,
    `valor` DOUBLE NOT NULL,
    `tipo` ENUM('ENTRADA', 'SAIDA') NOT NULL,
    `descricao` VARCHAR(191) NOT NULL,
    `controleId` INTEGER NOT NULL,
    `categoriaId` INTEGER NOT NULL,
    `autoCategoria` BOOLEAN NOT NULL DEFAULT true,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Categoria` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(191) NOT NULL,
    `tipo` ENUM('ALIMENTACAO', 'LAZER', 'EDUCACAO', 'TRANSPORTE', 'SAUDE', 'OUTROS') NOT NULL,
    `cor` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PrevisaoSaldo` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `dataCalculo` DATETIME(3) NOT NULL,
    `saldo` DOUBLE NOT NULL,
    `status` ENUM('POSITIVO', 'NEGATIVO') NOT NULL,
    `controleId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Lembretes` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `titulo` VARCHAR(191) NOT NULL,
    `mensagem` VARCHAR(191) NOT NULL,
    `dataEnvio` DATETIME(3) NOT NULL,
    `visto` BOOLEAN NOT NULL DEFAULT false,
    `tipo` ENUM('CONTA', 'META', 'INTERACAO') NOT NULL,
    `status` ENUM('PENDENTE', 'ENVIADO', 'CANCELADO') NOT NULL DEFAULT 'PENDENTE',
    `usuarioId` INTEGER NOT NULL,
    `controleId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `UsuariosControles` ADD CONSTRAINT `UsuariosControles_usuariosId_fkey` FOREIGN KEY (`usuariosId`) REFERENCES `Usuarios`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `UsuariosControles` ADD CONSTRAINT `UsuariosControles_controleId_fkey` FOREIGN KEY (`controleId`) REFERENCES `Controle`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transacoes` ADD CONSTRAINT `Transacoes_controleId_fkey` FOREIGN KEY (`controleId`) REFERENCES `Controle`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transacoes` ADD CONSTRAINT `Transacoes_categoriaId_fkey` FOREIGN KEY (`categoriaId`) REFERENCES `Categoria`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PrevisaoSaldo` ADD CONSTRAINT `PrevisaoSaldo_controleId_fkey` FOREIGN KEY (`controleId`) REFERENCES `Controle`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Lembretes` ADD CONSTRAINT `Lembretes_usuarioId_fkey` FOREIGN KEY (`usuarioId`) REFERENCES `Usuarios`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Lembretes` ADD CONSTRAINT `Lembretes_controleId_fkey` FOREIGN KEY (`controleId`) REFERENCES `Controle`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
