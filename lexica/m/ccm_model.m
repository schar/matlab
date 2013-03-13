clear all;
syms a b c d e f;

anchor = c;

re_cv    = a/2;
re_ccv   = a + b/2;
re_cccv  = (3*a)/2 + b;

r1 = 3*a/2 + b;
t1 = a/2 + b;
r2 = a/2;
t2 = -a/2;
r3 = -a/2 - b;
t3 = -(3*a/2) - b;

cc_cv    = 0;
cc_ccv   = 0;
cc_cccv  = 0;

ccm_cv   = c;
ccm_ccv  = c;
ccm_cccv = c;

rem_cv   = anchor - re_cv;
rem_ccv  = anchor - re_ccv;
rem_cccv = anchor - re_cccv;

var_ccm_cv   = f;
var_ccm_ccv  = f;
var_ccm_cccv = f;

var_rem_cv   = f + d/4;
var_rem_ccv  = f + d + e/4;
var_rem_cccv = f + (9*d)/4 + e;

ccm = c;
rem = (rem_cv + rem_ccv + rem_cccv)/3; % = c - b/2 - a

var_ccm = f;

rems = [rem_cv rem_ccv rem_cccv];
rem_vars = [var_rem_cv var_rem_ccv var_rem_cccv];

one = rem_vars(1) + (rems(1) - rem)^2;
two = rem_vars(2) + (rems(2) - rem)^2;
thr = rem_vars(3) + (rems(3) - rem)^2;

var_rem = (one + two + thr)/3;

rsd_ccm = sqrt(var_ccm)/ccm;
rsd_rem = sqrt(var_rem)/rem;