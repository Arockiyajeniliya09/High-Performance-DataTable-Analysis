
R version 4.6.1 (2026-06-24 ucrt) -- "Happy Hop"
Copyright (C) 2026 The R Foundation for Statistical Computing
Platform: x86_64-w64-mingw32/x64

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

[Previously saved workspace restored]

> install.packages("data.table")
Installing package into ‘C:/Users/jenil/AppData/Local/R/win-library/4.6’
(as ‘lib’ is unspecified)
--- Please select a CRAN mirror for use in this session ---
trying URL 'https://cran.isid.ac.in/bin/windows/contrib/4.6/data.table_1.18.4.zip'
Content type 'application/zip' length 3203062 bytes (3.1 MB)
downloaded 3.1 MB

package ‘data.table’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
        C:\Users\jenil\AppData\Local\Temp\RtmpakiUWZ\downloaded_packages
> library(data.table)
data.table 1.18.4 using 2 threads (see ?getDTthreads).  Latest news: r-datatable.com

Attaching package: ‘data.table’

The following object is masked _by_ ‘.GlobalEnv’:

    .N

The following object is masked from ‘package:base’:

    %notin%

> library(data.table)
> 
> set.seed(100)
> 
> n <- 10000
> 
> dt <- data.table(
+   CustomerID = sample(1001:1500, n, replace = TRUE),
+   Product = sample(c("Laptop","Mobile","TV","Shoes"), n, replace = TRUE),
+   Quantity = sample(1:10, n, replace = TRUE),
+   Price = sample(500:5000, n, replace = TRUE)
+ )
> 
> head(dt)
   CustomerID Product Quantity Price
        <int>  <char>    <int> <int>
1:       1202  Laptop        3  3593
2:       1358  Mobile        3  2302
3:       1112   Shoes        9  2917
4:       1499      TV        9  2887
5:       1473  Mobile       10  3776
6:       1206      TV        7  2449
> dt[, TotalAmount := Quantity * Price]
> head(dt)
   CustomerID Product Quantity Price TotalAmount
        <int>  <char>    <int> <int>       <int>
1:       1202  Laptop        3  3593       10779
2:       1358  Mobile        3  2302        6906
3:       1112   Shoes        9  2917       26253
4:       1499      TV        9  2887       25983
5:       1473  Mobile       10  3776       37760
6:       1206      TV        7  2449       17143
> fwrite(dt, "transactions.csv")
> sales <- fread("transactions.csv")
> 
> head(sales)
   CustomerID Product Quantity Price TotalAmount
        <int>  <char>    <int> <int>       <int>
1:       1202  Laptop        3  3593       10779
2:       1358  Mobile        3  2302        6906
3:       1112   Shoes        9  2917       26253
4:       1499      TV        9  2887       25983
5:       1473  Mobile       10  3776       37760
6:       1206      TV        7  2449       17143
> setkey(sales, CustomerID)
> sales[J(1010)]
Key: <CustomerID>
    CustomerID Product Quantity Price TotalAmount
         <int>  <char>    <int> <int>       <int>
 1:       1010   Shoes        5  1248        6240
 2:       1010   Shoes        4  3471       13884
 3:       1010   Shoes        4   634        2536
 4:       1010      TV        6  2590       15540
 5:       1010  Mobile        2  2840        5680
 6:       1010  Mobile        8  2071       16568
 7:       1010      TV        5  4443       22215
 8:       1010   Shoes       10   679        6790
 9:       1010   Shoes        7  3721       26047
10:       1010      TV        4  2142        8568
11:       1010  Laptop        6  1431        8586
12:       1010   Shoes        8  3767       30136
13:       1010      TV        6  2006       12036
14:       1010      TV        1  4564        4564
15:       1010   Shoes        7  4907       34349
16:       1010  Mobile        3   965        2895
17:       1010  Laptop        5  1341        6705
18:       1010      TV        3  4185       12555
19:       1010  Mobile        1  3295        3295
> sales[, Discount := TotalAmount * 0.10]
> sales[, FinalAmount := TotalAmount - Discount]
> fwrite(sales, "processed_transactions.csv")
> sales[, .(
+ Revenue = sum(FinalAmount)
+ ), by = CustomerID][order(-Revenue)][1:10]
    CustomerID  Revenue
         <int>    <num>
 1:       1277 469785.6
 2:       1274 467326.8
 3:       1407 452873.7
 4:       1144 447999.3
 5:       1309 447325.2
 6:       1476 442197.9
 7:       1434 429737.4
 8:       1355 429112.8
 9:       1481 427720.5
10:       1482 423041.4
> str(sales)
Classes ‘data.table’ and 'data.frame':  10000 obs. of  7 variables:
 $ CustomerID : int  1001 1001 1001 1001 1001 1001 1001 1001 1001 1001 ...
 $ Product    : chr  "Mobile" "Mobile" "TV" "Laptop" ...
 $ Quantity   : int  3 2 2 2 6 5 5 10 5 5 ...
 $ Price      : int  1745 3733 1906 3208 3869 4623 1248 3324 1853 4438 ...
 $ TotalAmount: int  5235 7466 3812 6416 23214 23115 6240 33240 9265 22190 ...
 $ Discount   : num  524 747 381 642 2321 ...
 $ FinalAmount: num  4712 6719 3431 5774 20893 ...
 - attr(*, ".internal.selfref")=<pointer: 0x0000017bdd19e130> 
 - attr(*, "sorted")= chr "CustomerID"
> 
