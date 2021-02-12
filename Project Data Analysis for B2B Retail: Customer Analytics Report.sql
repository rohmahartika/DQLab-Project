-- Melihat isi table
SELECT * FROM orders_1 limit 5;
SELECT * FROM orders_2 limit 5;
SELECT * FROM customer limit 5;
 
-- Total Penjualan dan Revenue pada Quarter-1 (Jan, Feb, Mar) dan Quarter-2 (Apr,Mei,Jun)
SELECT
	sum(quantity) AS total_penjualan,
	sum(quantity*priceeach) AS revenue
FROM
	orders_1
WHERE
	status = 'Shipped';

SELECT
	sum(quantity) AS total_penjualan,
	sum(quantity*priceeach) AS revenue
FROM
	orders_2
WHERE
	status = 'Shipped';
 
-- Menghitung persentasi keseluruhan penjualan
SELECT quarter, SUM(quantity) as total_penjualan, SUM(quantity*priceEach) as revenue
FROM(SELECT orderNumber, status, quantity, priceEach, '1' as quarter
FROM orders_1
UNION
SELECT orderNumber, status, quantity, priceEach, '2' as quarter
FROM orders_2) tabel_a
WHERE status = 'Shipped'
GROUP BY quarter;
 
-- Apakah jumlah customers xyz.com semakin bertambah?
SELECT quarter, COUNT(customerID) as total_customers
FROM (SELECT customerID, createDate, QUARTER(createDate) as quarter
      FROM customer
      WHERE createDate BETWEEN '2004-01-01' AND '2004-06-30'
      ) tabel_b
GROUP BY quarter;

-- Seberapa banyak customers tersebut yang sudah melakukan transaksi?
SELECT quarter, COUNT(customerID) as total_customers
FROM (SELECT customerID, createDate , QUARTER(createDate) as quarter
FROM customer
WHERE createDate BETWEEN '2004-01-01' AND '2004-06-30')tabel_b
WHERE customerID IN (SELECT DISTINCT(customerID)
FROM orders_1 
UNION
SELECT DISTINCT(customerID)
FROM orders_2)
GROUP BY quarter;

-- Category produk apa saja yang paling banyak di-order oleh customers di Quarter-2?
SELECT 
*
FROM (SELECT categoryID, COUNT(DISTINCT orderNumber) AS total_order, SUM(quantity) AS total_penjualan
     FROM (SELECT
          productCode,
          orderNumber,
          quantity,
          status,
          LEFT(productCode,3) AS categoryID
          FROM orders_2
          WHERE status = "Shipped") tabel_c
     GROUP BY categoryID) a
     ORDER BY total_order DESC

-- Seberapa banyak customers yang tetap aktif bertransaksi setelah transaksi pertamanya?
#Menghitung total unik customers yang transaksi di quarter_1
SELECT COUNT(DISTINCT customerID) as total_customers FROM orders_1;
#output = 25
SELECT '1' as quarter, COUNT(DISTINCT customerID)/25*100 as q2
FROM orders_1
WHERE customerID IN (SELECT DISTINCT customerID 
                     FROM orders_2);


