
 /*
    상반기 아이스크림 총주문량이 3,000보다 높으면서 
    아이스크림의 주 성분이 과일인 아이스크림의 맛을 총주문량이 
    큰 순서대로 조회하는 SQL 문을 작성해주세요.
 */

/*
    문제 조건 : 1) 주문량이 3,000 초과
                  TOTAL_ORDER > 3000
               2) 주 성분 = '과일'
                  INGREDIENT_TYPE = 'fruit_based'
    정렬 조건 : 총주문량 (내림)
    조회 컬럼 : 아이스크림의 맛

*/

SELECT a.flavor
FROM FIRST_HALF a
    ,ICECREAM_INFO b
WHERE a.flavor = b.flavor
  AND a.total_order > 3000
  AND b.ingredient_type = 'fruit_based'
ORDER BY a.total_order DESC
;