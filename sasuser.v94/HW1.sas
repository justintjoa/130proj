libname data "/folders/myfolders/Database";
Proc contents data = data.ptf;
data work.ptf;
input age:$15. ;
run;

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

filename cars "/folders/myfolders/sasuser.v94/cars.csv";
proc import cars
data project.SAScars;
input hp:$15
 
merge project.SAScars and project

infile cars firstobs=1 obs=10;
input Brand:$15. Type:$15. Origin:$15. Cylinder:2. ;
run;

filename zipcode "/folders/myfolders/sasuser.v94/CA_ZIP_CODE.TXT";
proc import work.CA_ZIP_CODE;
input density:$15;
merge work.ptf

filename work.CA_ZIP_CODE "/folders/myfolders/sasuser.v94/CA_ZIP_CODE.TXT";
proc import work.CA_ZIP_CODE
data project.work.CA_ZIP_CODE
input density:$15.

libname HW1 "/folders/myfolders/sasuser.v94";
filename sas7bdat "/folders/myfolders/sasuser.v94/claims.sas7bdat;
data project;
infile sas7bdat firstobs=1 obs=100;
input age:$15. ;
run;