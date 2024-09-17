ALTER INDEX Idx_PedidoProduto ON PedidoProduto REORGANIZE;
ALTER INDEX Idx_PedidoProduto ON PedidoProduto REBUILD;

ALTER INDEX idx_pedProd_temp ON PedidoProduto REORGANIZE;
ALTER INDEX idx_pedProd_temp ON PedidoProduto REBUILD;

