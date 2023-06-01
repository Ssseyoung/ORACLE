

SELECT SALES_DATE, product_id, user_id, sales_amount
FROM (
    SELECT TO_CHAR(SALES_DATE, 'YYYY-MM-DD') SALES_DATE
      ,product_id
      ,user_id
      ,sales_amount
    FROM ONLINE_SALE
    WHERE TO_CHAR(SALES_DATE, 'YYYY-MM') = '2022-03'
    UNION
    SELECT TO_CHAR(SALES_DATE, 'YYYY-MM-DD') SALES_DATE
          ,product_id
          ,NULL
          ,sales_amount
    FROM OFFLINE_SALE
    WHERE TO_CHAR(SALES_DATE, 'YYYY-MM') = '2022-03'
    )
ORDER BY SALES_DATE, product_id, user_id