use [Lab6];

--1. Добавить внешние ключи
ALTER TABLE dealer
ADD FOREIGN KEY (id_company)
REFERENCES company(id_company);

ALTER TABLE [order]
ADD FOREIGN KEY (id_production)
REFERENCES production(id_production);

ALTER TABLE [order]
ADD FOREIGN KEY (id_dealer)
REFERENCES dealer(id_dealer);

ALTER TABLE [order]
ADD FOREIGN KEY (id_pharmacy)
REFERENCES pharmacy(id_pharmacy);

ALTER TABLE production
ADD FOREIGN KEY (id_company)
REFERENCES company(id_company);

ALTER TABLE production
ADD FOREIGN KEY (id_medicine)
REFERENCES medicine(id_medicine);

--2. Выдать информацию по всем заказам лекарства "Кордерон" компании "Аргус" с указанием названий аптек, дат, объема заказов
SELECT medicine.name AS medicine_name, pharmacy.name AS pharmacy_name, [order].date, [order].quantity FROM [order]
JOIN pharmacy ON [order].id_pharmacy = pharmacy.id_pharmacy
JOIN production ON [order].id_production = production.id_production
JOIN medicine ON production.id_medicine = medicine.id_medicine
JOIN company ON production.id_company = company.id_company
WHERE medicine.name = 'Кордерон' AND company.name = 'Аргус';

--3. Дать список лекарств компании "Фарма", на которые не были сделаны заказы до 25 января
-- НЕ БЫЛИ ДО 25

SELECT production.id_medicine, medicine.name AS medicine_name FROM production
JOIN company ON production.id_company = company.id_company
JOIN [order] ON [order].id_production = production.id_production
JOIN medicine ON production.id_medicine = medicine.id_medicine
WHERE company.name ='Фарма' AND [order].date > '2019-01-25'
GROUP BY medicine.name, production.id_medicine;

--4. Дать минимальный и максимальный баллы лекарств каждой фирмы, которая оформила не менее 120 заказов
SELECT company.name, MIN(production.rating) AS min_rating, MAX(production.rating) AS max_rating FROM [order]
JOIN production ON production.id_production = [order].id_production
JOIN company ON production.id_company = company.id_company
JOIN medicine ON production.id_medicine = medicine.id_medicine
WHERE [order].quantity >= 120
GROUP BY company.name;

--5. Дать списки сделавших заказы аптек по всем дилерам компании "AstraZeneca". Если у дилера нет заказов, в названии аптеки поставить NULL.

SELECT DISTINCT(pharmacy.name) AS pharmacy_name, dealer.name AS dealer_name, company.name AS company_name FROM dealer
LEFT JOIN [order] ON [order].id_dealer = dealer.id_dealer
LEFT JOIN company ON company.id_company = dealer.id_company
LEFT JOIN pharmacy ON pharmacy.id_pharmacy = [order].id_pharmacy
WHERE company.name = 'AstraZeneca';


--6. Уменьшить на 20% стоимость всех лекарств, если она превышает 3000, а длительность лечения не более 7 дней
UPDATE production
SET production.price = production.price * 0.8
WHERE production.price > 3000 AND id_medicine IN (SELECT id_medicine FROM medicine WHERE cure_duration <= 7);

--7. Добавить необходимые индексы
CREATE INDEX IX_mName ON medicine(name);
CREATE INDEX IX_cName ON company(name);
CREATE INDEX IX_oDate ON [order](date);
CREATE INDEX IX_oQuantity ON [order](quantity);