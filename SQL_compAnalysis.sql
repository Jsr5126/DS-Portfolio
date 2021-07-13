 /* Distinct list of Vendors and count of 450% POs sent via EDI */
SELECT DISTINCT Vendor, COUNT(`External Delivery ID`)
FROM tblapi_companalysis0712
WHERE `Created by` = 'WF-BATCH'
  AND `Ref.doc.` LIKE '450%'
  AND Vendor NOT IN('27A', '19A', '02A',  'WF-BATCH')
GROUP BY Vendor
ORDER BY COUNT(`External Delivery ID`) DESC

 /* Distinct list of SIDs by Vendor sent to the PDC with EDI ASNs */
SELECT DISTINCT `External Delivery ID` as SID, `Created on`, Vendor, `Created by`, `Ref.doc.`
FROM tblapi_companalysis0712
WHERE Vendor = 'S3J'
  AND `Ref.doc.` LIKE '450%'
  AND Vendor = 'S3J'
GROUP BY `External Delivery ID`
ORDER BY `Created on` ASC

 /* Distinct list of SIDs by Vendor sent to the PDC with EDI ASNs sent within current month*/
SELECT DISTINCT `External Delivery ID` as SID, `Created on`, Vendor, `Created by`, `Ref.doc.`
FROM tblapi_companalysis0712
WHERE MONTH(`Created on`) = MONTH(CURRENT_DATE())
  AND YEAR(`Created on`) = YEAR(CURRENT_DATE())
  AND `Ref.doc.` LIKE '450%'
  AND Vendor = 'jw08'
GROUP BY `External Delivery ID`
ORDER BY `Created on` ASC

 /* Distinct list of SIDs by Vendor sent to the PDC with EDI ASNs sent since a specific date*/
SELECT DISTINCT `External Delivery ID` as SID, DATE_FORMAT(`Created on`, '%m/%d/%Y') as 'Create Date', Vendor, `Created by`, `Ref.doc.`
FROM tblapi_companalysis0712
WHERE DATE_FORMAT(`Created on`, '%m/%d/%Y') > '07/1/2021'
  AND `Ref.doc.` LIKE '450%'
  AND Vendor = 'LS73'
GROUP BY `External Delivery ID`
ORDER BY `Created on` ASC

/* Distinct list of Vendors and date of last EDI ASN sent to the PDC*/
SELECT DISTINCT `External Delivery ID` as SID, MAX(DATE_FORMAT(`Created on`, '%m/%d/%Y')) as 'Create Date', Vendor, `Created by`, `Ref.doc.`
FROM tblapi_companalysis0712
GROUP BY Vendor
ORDER BY `Created on` ASC