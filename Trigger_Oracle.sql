SELECT * FROM TAB_FATURAMENTO;
SELECT * FROM NOTAS;
SELECT * FROM ITEMS_NOTAS;

CREATE OR REPLACE TRIGGER TB_CALCULO_FATURAMENTO
AFTER INSERT OR UPDATE OR DELETE ON ITEMS_NOTAS
BEGIN
    DELETE FROM TAB_FATURAMENTO;
    INSERT INTO TAB_FATURAMENTO
    SELECT NOTAS.DATA_VENDA, SUM(ITEMS_NOTAS.QUANTIDADE * ITEMS_NOTAS.PRECO) AS TOTAL_VENDA
    FROM NOTAS INNER JOIN ITEMS_NOTAS
    ON NOTAS.NUMERO = ITEMS_NOTAS.NUMERO
    GROUP BY NOTAS.DATA_VENDA;
END;