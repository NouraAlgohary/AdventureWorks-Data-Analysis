# AdventureWorks-Data-Analysis

## Project Overview:
Welcome to the AdventureWorks Data Analysis documentation! This comprehensive guide will walk you through the process of importing and analyzing data from the AdventureWorks sample database. We will cover everything from creating views for importing data to constructing a star schema, creating measures, and charts, and delivering a compelling sales story.

![Capture](https://github.com/NouraAlgohary/AdventureWorks-Data-Analysis/assets/103903785/14f320aa-1b88-407f-8b3e-cf06adce2bfe)
![Q A](https://github.com/NouraAlgohary/AdventureWorks-Data-Analysis/assets/103903785/76d44f77-8cb0-4658-9b16-156629d7b469)

## 1. Data Source:
AdventureWorks Sample Database: Install and Configure</br>
Conductivity Mode: Import</br>
### 2. Creating Views for Importing:
vw_DimProducts</br>
vw_DimSalesPersons</br>
vw_DimShipMethods</br>
vw_DimStatuses</br>
vw_DimTerritories</br>
vw_FactOrderDetails</br>

This [file](https://github.com/NouraAlgohary/AdventureWorks-Data-Analysis/tree/main/Queries) contains SQL code snippets for creating views to import data. </br>
</br>
DimDate (Created using Power Query)
```
Number.ToText(Date.Year([Date])) & 
(
    if Date.Month([Date]) < 10 then
        "0" & Number.ToText(Date.Month([Date]))
    else 
        Number.ToText(Date.Month([Date]))
) & 
(
    if Date.Day([Date]) < 10 then
        "0" & Number.ToText(Date.Day([Date]))
    else 
        Number.ToText(Date.Day([Date]))
)
```
## 2. Data Profiling
### vw_FactOrderDetails:
- General Information:</br>
Number of Rows: 121317</br>
Number of Columns: 18</br>

- Column Details:</br>
    - SalesOrderID:</br>
Data Type: Integer</br>
Null Values: 0</br>
Unique Values: 31465</br>
Min Value: 43659</br>
Max Value: 75123</br>

    - SalesOrderDetailsID:</br>
Data Type: Integer</br>
Null Values: 0</br>
Unique Values: 121317</br>
Min Value: 1</br>
Max Value: 121317</br>

    - ProductID:</br>
Data Type: Integer</br>
Null Values: 0</br>
Unique Values: 266</br>
Min Value: 707</br>
Max Value: 999</br>

    - SalesPersonID:</br>
Data Type: Integer</br>
Null Values: 60398</br>
Unique Values: 18</br>
Min Value: 274</br>
Max Value: 290</br>

    - ShipMethodID:</br>
Data Type: Integer</br>
Null Values: 0</br>
Unique Values: 2</br>
Min Value: 1</br>
Max Value: 5</br>

    - StatusID:</br>
Data Type: Integer</br>
Null Values: 0</br>
Unique Values: 1</br>
Min Value: 5</br>
Max Value: 5</br>

    - TerritoryID:</br>
Data Type:Integer</br>
Null Values: 0</br>
Unique Values: 10</br>
Min Value: 1</br>
Max Value: 10</br>

    - OrderDateKey:</br>
Data Type: Integer</br>
Null Values: 0</br>
Unique Values: 1124</br>
Min Value: 20110531</br>
Max Value: 20140630</br>

    - ShipDateKey:</br>
Data Type: Integer</br>
Null Values: 0</br>
Unique Values: 1124</br>
Min Value: 20110607</br>
Max Value: 20140707</br>

    - DueDateKey:</br>
Data Type: Integer</br>
Null Values: 0</br>
Unique Values: 1124</br>
Min Value: 20110612</br>
Max Value: 20140712</br>

    - OrderQty:</br>
Data Type: Integer</br>
Null Values: 0</br>
Unique Values: 41</br>
Min Value: 1</br>
Max Value: 44</br>

    - OnlineOrderFlag:</br>
Data Type: Boolean</br>
Null Values: 0</br>
Unique Values: 2</br>

    - UnitPrice:</br>
Data Type: Integer</br>
Null Values: 0</br>
Unique Values: 287</br>
Min Value: 1.3282</br>
Max Value: 3578.27</br>

    - LineTotal:</br>
Data Type: Integer</br>
Null Values: 0</br>
Unique Values: 1488</br>
Min Value: 1.37</br>
Max Value: 27893.62</br>

    -Taxamt:</br>
Data Type: Integer</br>
Null Values: 0</br>
Unique Values: 52513</br>
Min Value: 0.11</br>
Max Value: 2867.61</br>

    - Fright:</br>
Data Type: Integer</br>
Null Values: 0</br>
Unique Values: 51944</br>
Min Value: 0.03</br>
Max Value: 896.13</br>

    - TotalDue:</br>
Data Type: Integer</br>
Null Values: 0</br>
Unique Values: 55012</br>
Min Value: 1.45</br>
Max Value: 31657.23</br>

    - SalesAmount:</br>
Data Type: Integer</br>
Null Values: 0</br>
Unique Values: 1468</br>
Min Value: 1.374</br>
Max Value: 30992.91</br>
```
SalesAmount = 'vw_Fact|OrderDetails'[UnitPrice] * 'vw_Fact|OrderDetails'[OrderQty]
```


## 4. Measures (DAX Table):
```
MeasuresTable = 
SUMMARIZECOLUMNS (
    'vw_Fact|OrderDetails'[OrderDateKey],
    'vw_Fact|OrderDetails'[DueDateKey],
    'vw_Fact|OrderDetails'[ShipDateKey],
    "Orders by Order Date", 'vw_Fact|OrderDetails'[OrdersByOrderDate],
    "Orders by Ship Date", 'vw_Fact|OrderDetails'[OrdersByDueDate],
    "Orders by Due Date", 'vw_Fact|OrderDetails'[OrdersByShipDate],
    "Total SubTotal", [SubTotal],
    "Total Tax", [TaxAmount],
    "Total Freight", [Total Freight],
    "Total Due", [Total Due]
)
```
- No. of Orders by Order Date Measure
  ```
  OrdersByOrderDate = CALCULATE(
    COUNTROWS(
        VALUES('vw_Fact|OrderDetails'[SalesOrderID])
    ),
    USERELATIONSHIP(
       'vw_Fact|OrderDetails'[OrderDateKey],
        DimDate[DateKey]
    ))
  ```
- No. of Orders by Ship Date Measure
```
OrdersByShipDate = 
CALCULATE(
    COUNTROWS(
        VALUES('vw_Fact|OrderDetails'[SalesOrderID])
    ),
    USERELATIONSHIP(
       'vw_Fact|OrderDetails'[ShipDateKey],
        DimDate[DateKey]
    )
)
```
- No. of Orders by Due Date Measure
```
OrdersByDueDate = 
CALCULATE(
    COUNTROWS(
        VALUES('vw_Fact|OrderDetails'[SalesOrderID])
    ),
    USERELATIONSHIP(
        'vw_Fact|OrderDetails'[DueDateKey],
        DimDate[DateKey]
    )
)
```
- Total SubTotal Measure
```
SubTotal = SUM('vw_Fact|OrderDetails'[LineTotal])
```
- Total Tax Measure
```
TaxAmount = SUM('vw_Fact|OrderDetails'[Taxamt])
```
- Total Freight Measure
```
Total Freight = SUM('vw_Fact|OrderDetails'[Freight])
```
- Total Due Measure
```
Total Due = SUM('vw_Fact|OrderDetails'[TotalDue])
```

4. Charts:
Card for Each Chart (Order Date): Display data by Order Date using cards.
Max Qty per Product Chart: Visualize the maximum quantity per product.
Matrix Chart (Territories, Years, Values: Total Sales, Total Canada Sales): Row-wise breakdown of territories, column-wise breakdown of years, and values represented by total sales and total Canada sales.
QA Chart: Quality Assurance chart for data validation.
Drilldown and Drill Through: Implement drilldown and drill through functionality for enhanced exploration.
Product Hierarchy Chart: Create a hierarchy for products.
Tooltip for Sales: Utilize tooltips to show sales associated with order quantity for each graph.
Color Theme (Exported as JSON): Create and export a custom color theme for visual consistency.
Additional Charts: Create extra charts as needed to convey the sales story effectively.
GitHub Documentation Structure:
Introduction:

Overview of the AdventureWorks data analysis project.
Getting Started:

Instructions on how to install and configure the AdventureWorks sample database.
Conductivity Mode:

Explanation of the import mode used for data extraction.
Imported Tables:

List and brief description of the tables imported for analysis.
Measures (DAX Table):

Details on the measures created using DAX and organized in a table.
Charts:

Instructions and code snippets for creating various charts and visualizations.
Usage of Drilldown and Drill Through:

Explanation of how to use drilldown and drill through features.
Creating Product Hierarchy:

Step-by-step guide on creating a hierarchy for product visualization.
Tooltip Implementation:

Instructions on implementing tooltips for enhanced data representation.
Color Theme Creation:

Code snippets and instructions for creating a custom color theme and exporting it as JSON.
Additional Charts:

Guidance on creating any extra charts necessary for storytelling.
Conclusion:

A summary and conclusion of the AdventureWorks data analysis project.
