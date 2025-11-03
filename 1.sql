SELECT *
FROM token
WHERE MOD(ROUND(kurs), 2) = 1;
