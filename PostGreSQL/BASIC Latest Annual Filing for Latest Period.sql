/************************************************************************************************
BASIC Latest Annual Filing for Latest Period
This query uses the following packages:
- Premium Financials Core package + Premium Financials Statement package
- S&P Capital IQ Base files:
- Company
- Data Item Master
- Currency and Exchange
***********************************************************************************************/
SELECT c.companyName, c.companyId, ti.tickerSymbol,e.exchangeSymbol, fi.periodEndDate,fi.filingDate,pt.periodTypeName,fp.calendarQuarter, fp.calendarYear,fd.dataItemId,di.dataItemName,fd.dataItemValue
FROM ciqCompany c
join ciqSecurity s on c.companyId = s.companyId
join ciqTradingItem ti on ti.securityId = s.securityId
join ciqExchange e on e.exchangeId = ti.exchangeId
join ciqFinPeriod fp on fp.companyId = c.companyId
join ciqPeriodType pt on pt.periodTypeId = fp.periodTypeId
join ciqFinInstance fi on fi.financialPeriodId = fp.financialPeriodId
join ciqFinInstanceToCollection ic on ic.financialInstanceId = fi.financialInstanceId
join ciqFinCollection fc on fc.financialCollectionId = ic.financialCollectionId
join ciqFinCollectionData fd on fd.financialCollectionId = ic.financialCollectionId
join ciqDataItem di on di.dataItemId = fd.dataItemId
WHERE fd.dataItemId in (28, 29, 1, 364, 2, 376, 10, 367, 19, 20, 15)
AND fp.periodTypeId = 1 --Annual
AND e.exchangeSymbol = 'SWX'
AND ti.tickerSymbol = 'NESN' --Nestl� S.A.
AND fi.latestForFinancialPeriodFlag = 1 --Latest Instance For Financial Period
AND fp.latestPeriodFlag = 1 --Current Period
ORDER BY di.dataItemName