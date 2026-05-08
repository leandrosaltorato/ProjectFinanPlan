async function gerarPlanoFinanceiro(controleId) {
  const controle = await prisma.controle.findUnique({ where: { id: controleId } });

  const gastos = await prisma.transacoes.findMany({
    where: {
      controleId,
      tipo: 'SAIDA',
      data: { gte: subDays(new Date(), 30) }
    },
    include: { categoria: true }
  });

  const metas = await prisma.lembretes.findMany({
    where: { controleId, tipo: 'META' }
  });

  const plano = await chamarClaude({ controle, gastos, metas });

  await prisma.previsaoSaldo.create({
    data: {
      controleId,
      dataCalculo: new Date(),
      saldo: controle.saldo,
      status: plano.scoreSaude > 50 ? 'POSITIVO' : 'NEGATIVO',
      planoIA: plano  
    }
  });

  return plano;
}