* comments
// c
// command var [varlist], [options]
tsset date, daily

gen absR = abs(avgadjclosertn)
gen sqR  = avgadjclosertn*avgadjclosertn
reg CSAD absR sqR

// Plot
line avgadjclosertn date
line csad date 
line absR date
line sqR date

// Dickey Fuller test
dfuller csad
ac csad
pac csad

// Dummy variable

gen covid = 0
replace covid = 1 if date > td(12mar2020)
reg csad absR sqR i.covid

// Outlier dummy
gen outlier = 0
replace outlier = 1 if absR > .086 // 95% percentile

// y = a +b abs(Rt) +c Rt^2


regress csad absR sqR i.covid i.outlier


