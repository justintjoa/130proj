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
length year $15.;
run; 

proc import datafile = "/folders/myfolders/Database/cars.csv"
out=work.cars;
run; 


proc sort data = work.cars;
BY cars_id;
run;

proc sort data = work.ptf;
BY cars_id;
run;
 
 
 
data work.ptf;
merge work.cars work.ptf;
BY cars_id;
run;

infile cars firstobs=1 obs=10;
input Brand:$15. Type:$15. Origin:$15. Cylinder:2. ;
run;

proc import datafile = "/folders/myfolders/Database/CA_ZIP_CODE.TXT"
out=work.CA_ZIP_CODE;
run;



/*
data work.CA_ZIP_CODE;
set data.CA_ZIP_CODE.TXT;
length density $15. default = 8;
if (Population LE 4000) then density = "low";
if (Population GT 4000) and (Population LE 30000) then density = "medium";
if (Population GT 30000) then density = "high";
run;
*/



proc sort data = work.CA_ZIP_CODE;
BY Zip_Code;
run;

proc sort data = work.ptf;
BY Zip_Code;
run;

data work.ptf;
merge work.CA_ZIP_CODE work.ptf;
BY Zip_Code;
run;



libname HW1 "/folders/myfolders/Database";
Proc contents data = data.claims;
run;

proc sort data = data.claims;
BY POLICYHOLDER_ID POLICY_STARTING_DATE;
run;

proc sort data = work.ptf;
BY POLICYHOLDER_ID POLICY_STARTING_DATE;
run;

data work.claims;
merge work.ptf data.claims;
BY POLICYHOLDER_ID POLICY_STARTING_DATE;
run;

data work.claims;
length year $15.;
run;

proc means data = work.claims_summary;
run;

data work.claims_summary;
length cost $15.;
length nb_claims $15.;
run;


proc means data = work.ptf_summary;
run;


data work.ptf_summary;
length nb $15.;
run;

data  work.summary;
merge work.claims_summary work.ptf_summary;
BY age density hp year;







