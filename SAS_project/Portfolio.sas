data projec;
set portfoli.mileage_004;
keep date year month monyr price gal mi mpg co2_ton co2_diff_ton_tot;
run;
proc means;

/* Fuel efficiency*/
proc means data=projec nonobs;
  var mpg;
  class year;
  output out=mpg_summary mean=avg_mpg;
run;

proc print data=mpg_summary noobs;
  title 'Fuel Efficiency Analysis';
  var year avg_mpg;
  where year in (2015, 2016, 2017, 2018, 2019, 2020);
run;


/*CO2 emission trend over years*/
proc means data=projec nonobs;
  var co2_ton;
  class year;
  output out=co2_summary sum=total_co2;
run;

proc print data=co2_summary noobs;
  title 'CO2 Emissions Over Time';
  var year total_co2;
    where year in (2015, 2016, 2017, 2018, 2019, 2020);
run;


/* Format for Year Variable */
proc format;
  value year_fmt 2018='2018' 2019='2019' 2020='Year of Covid';
run;

/* Transposing the Dataset */
proc transpose data=projec out=transposed_dataset;
  by date;
  var year month monyr price gal mi mpg co2_ton co2_diff_ton_tot;
run;
proc print;


/* PROC REPORT */
proc report data=projec nowd;
  title 'Fuel Efficiency Analysis';
  column year month monyr price gal mi mpg co2_ton co2_diff_ton_tot;

  define year / across 'Year' format=year_fmt.;
  define month / display 'Month';
  define monyr / display 'MonthYear';
  define price / display 'Price';
  define gal / display 'Gallons';
  define mi / display 'Miles';
  define mpg / display 'Miles per Gallon';
  define co2_ton / display 'CO2 Emission (tons)';
  define co2_diff_ton_tot / display 'Total CO2 Emission (tons)';
run;

/* PROC FREQ */
proc freq data=projec;
  tables year;
  title 'Frequency Distribution of Years';
run;

/* PROC FORMAT for CO2 Tons */
proc format;
  value co2_fmt low-0.07='Low' 0.075-0.08='Medium' 0.085-high='High';
run;

/* PROC REPORT with PROC FORMAT */
proc report data=projec ;
  title 'Fuel Efficiency Analysis with CO2 Levels';
  column year gal mi mpg co2_ton;

  define year / display 'Year' format=year_fmt.;
  define gal / display 'Gallons';
  define mi / display 'Miles';
  define mpg / display 'Miles per Gallon';
  define co2_ton / display 'CO2 Emission (tons)' format=co2_fmt.;
run;


/*Bubble graph for CO2 emission comparision*/

ods graphics / reset width=6.4in height=4.8in imagemap;

proc sgplot data=PORTFOLI.MILEAGE_004;
	bubble x=date_label y=price size=co2_ton/ colorresponse=co2_diff_ton_tot 
		colormodel=(CX24e037 CXFAFBFE CXD05B5B) bradiusmin=7 bradiusmax=14;
	xaxis grid;
	yaxis grid;
run;

ods graphics / reset;
