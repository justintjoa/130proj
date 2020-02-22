libname data "/folders/myfolders/Database";
Proc contents data = data.ptf;
run;

data work.ptf;
set data.ptf;
length age $15. default = 8;
totalDays = DATE() - birthdate;
age = floor(totalDays/365);
if (age LE 21) then age = "-21";
if (age GT 21) and (age LE 35) then age = "21-35";
if (age GT 35) and (age LE 60) then age = "35-65";
if (age GT 60) then age = "+60";
drop totalDays;
run; 

proc import datafile = "/folders/myfolders/Database/cars.csv"
out=cars;
proc sort data = cars;
BY cars_id;
run;
 
data work.ptf;
merge cars work.ptf;
BY cars_id;
run;

infile cars firstobs=1 obs=10;
input Brand:$15. Type:$15. Origin:$15. Cylinder:2. ;
run;

proc import datafile = "/folders/myfolders/Database/CA_ZIP_CODE.TXT"
out=work.CA_ZIP_CODE;
input density:$15;
run;

data work.ptf;
merge work.CA_ZIP_CODE work.ptf;
BY Zip_Code;
run;



libname HW1 "/folders/myfolders/sasuser.v94";
filename sas7bdat "/folders/myfolders/sasuser.v94/claims.sas7bdat;
data project;
infile sas7bdat firstobs=1 obs=100;
input age:$15. ;
run;