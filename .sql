/* Distinct list of Vendors and count of 450% POs created by 'Sys-Generated' */
SELECT 
 DISTINCT Vendor
 ,COUNT(`External Delivery ID`)
FROM Table_ComplianceAnalysis
WHERE `Created by` = 'Sys-Generated'
  AND `Ref.doc.` LIKE '450%'
--  AND Vendor NOT IN('VEN 1', 'VEN 2', 'VEN 3')
GROUP BY Vendor
ORDER BY COUNT(`External Delivery ID`) DESC;

/* Distinct list of External Delivery IDs by Vendor of 450% POs created by 'Sys-Generated' */
SELECT DISTINCT 
 `External Delivery ID` as SID
 ,`Created on`
 ,Vendor
 ,`Created by`
 ,`Ref.doc.`
FROM Table_ComplianceAnalysis
WHERE `Created by` = 'Sys-Generated'
  AND `Ref.doc.` LIKE '450%'
  AND Vendor = 'VEN 2'
GROUP BY `External Delivery ID`
ORDER BY `Created on` ASC

/* Distinct list of External Delivery IDs by Vendor of 450% POs created by 'Sys-Generated' created in current month*/
SELECT 
 DISTINCT `External Delivery ID` as SID
 ,`Created on`
 ,Vendor
 ,`Created by`
 ,`Ref.doc.`
FROM Table_ComplianceAnalysis
WHERE MONTH(`Created on`) = MONTH(CURRENT_DATE())
  AND YEAR(`Created on`) = YEAR(CURRENT_DATE())
  AND `Created by` = 'Sys-Generated'
  AND `Ref.doc.` LIKE '450%'
  AND Vendor = 'jw08'
GROUP BY `External Delivery ID`
ORDER BY `Created on` ASC;

/* Distinct list of External Delivery IDs by Vendor of 450% POs created by 'Sys-Generated' created since a specific date*/
SELECT 
 DISTINCT `External Delivery ID` as SID
 ,DATE_FORMAT(`Created on`, '%m/%d/%Y') as 'Create Date'
 ,Vendor
 ,`Created by`
 ,`Ref.doc.`
FROM Table_ComplianceAnalysis
WHERE DATE_FORMAT(`Created on`, '%m/%d/%Y') > '07/1/2021'
  AND `Created by` = 'Sys-Generated'
  AND `Ref.doc.` LIKE '450%'
  AND Vendor = 'VEN 2'
GROUP BY `External Delivery ID`
ORDER BY `Created on` ASC;

/* Distinct list of External Delivery IDs and newest date of last created by 'Sys-Generated' 450% PO */
SELECT 
 DISTINCT `External Delivery ID` as SID
 ,MAX(DATE_FORMAT(`Created on`, '%m/%d/%Y')) as 'Create Date'
 ,Vendor
 ,`Created by`
 ,`Ref.doc.`
FROM Table_ComplianceAnalysis
WHERE `Created by` = 'Sys-Generated'
GROUP BY Vendor
ORDER BY `Created on` ASC;

/* Various Filters */
SELECT 
  TRIM(LEADING '0' FROM `Shipment ID`) as SIDTrim
  , SUM(FLOOR(`Delivery quantity`)) as DlvQTY
  , `Inbound Delivery Create Date-Time`
  , TIME(`Inbound Delivery Create Date-Time`) as DlvTime
FROM Table_InTransit
WHERE `Vendor Code` in ('VEN 1', 'VEN 2', 'VEN 3')
GROUP BY 
  `Shipment ID`
  , `Inbound Delivery Create Date-Time`
  , TIME(`Inbound Delivery Create Date-Time`)
HAVING sum(`Delivery quantity`) > 30
AND DlvTime > '12:00:00';

/* Subquery */
DROP TABLE IF EXISTS Tbl.NullStuff;
CREATE temporary TABLE Tbl.NullStuff
SELECT COUNT(SID)AS NotNullCount
      ,(SELECT count(SID) 
       FROM Table_ComplianceAnalysis_2 
       WHERE `Tracking#` IS NULL) AS NullCount
FROM Table_ComplianceAnalysis_2
WHERE `Tracking#` IS NOT null

/* Mathematical Fields */
SELECT NotNullCount/(NullCount + NotNullCount) as NotNullPercent
FROM movedb.NullStuff;
