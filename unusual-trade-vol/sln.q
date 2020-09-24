// *** This script generates alerts based on unusual volume compared to historical trading activity by trader and sym ***
\l scenario_logic.q

0N!`$"*** Commencing Unit Tests ***";
\l test_scenario_logic.q
0N!`$"*** Tests Completed ***";

\l prof.q

// Configurable inputs
data: ("DSISS";enlist ",")0:`$"data//eq_vol.csv"; / x
daysToLookBack:3; / y
threshold:0.05; / a
alertDt:2020.01.15; / b

// Main[]
// .prof.prof` / For Profiling
generateAlert[data;daysToLookBack;threshold;alertDt]
// .prof.data` / Read in Profiling Details
// .prof.unprof` / Clear Profiling