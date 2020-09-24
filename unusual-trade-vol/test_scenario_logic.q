\l scenario_logic.q

mockDataIQU:flip (`date`sym`qty`status`trader)!(2020.01.09 2020.01.12 2020.01.12 2020.01.12 2020.01.15 2020.01.15 2020.01.16 2020.01.16 2020.01.16 2020.01.16 2020.01.16;`IQU`IQU`IQU`IQU`IQU`IQU`IQU`IQU`IQU`IQU`IQU;10 4 4 5 1 1 90 678 678 700 700;`rejected`filled`new`rejected`filled`new`new`filled`new`new`new;`1431699983`1431699983`1431699983`1431699983`1431699983`1431699983`24045563`38173650`38173650`1431699983`1431699983);

mockDataHyflux:flip (`date`sym`qty`status`trader)!(2020.01.12 2020.01.12 2020.01.12 2020.01.13 2020.01.13 2020.01.13 2020.01.13 2020.01.13;`HYFL_p.SI`HYFL_p.SI`HYFL_p.SI`HYFL_p.SI`HYFL_p.SI`HYFL_p.SI`HYFL_p.SI`HYFL_p.SI;50 60 60 50 50 30 40 50;`new`new`new`rejected`replaced`new`new`replaced;`1163671697`1163671697`1163671697`1163671697`1163671697`1163671697`1163671697`1163671697);

assetEquals:{ 0N!`$string[z],": ",$[x~y;"Passed";("Failed - Expected: ",.Q.s[y], "Actual: ",.Q.s[x])] };

test_benchmark_generates_correctly_for_IQU:{
    daysToLookBack:4;
    alertDt:2020.01.16;
    threshold:0.05;
    expectedBmQty:1.3125;
    assetEquals[;expectedBmQty;`test_benchmark_generates_correctly_for_IQU] {x`bm}first generateBenchmark[mockDataIQU;daysToLookBack;threshold;alertDt];
    };

test_alert_generates_correctly_for_IQU:{
    daysToLookBack:4;
    alertDt:2020.01.16;
    threshold:0.05;
    expectedAlertQty:1400;
    expectedAlertCount:1;
    res:generateAlert[mockDataIQU;daysToLookBack;threshold;alertDt];

    assetEquals[count res; expectedAlertCount; `test_alert_generates_count_correctly_for_IQU];
    assetEquals[{{x`qty}first x} res; expectedAlertQty; `test_alert_generates_qty_correctly_for_IQU];
    };

test_benchmark_generates_correctly_for_hyflux_single_day_lookback:{
    daysToLookBack:1;
    expectedAlertCount:0;
    alertDt:2020.01.13;
    threshold:0.05;
    expectedBmQty:170*1+threshold;
    actualBmQty: {x`bm}first generateBenchmark[mockDataHyflux;daysToLookBack;threshold;alertDt];
    
    assetEquals[actualBmQty; expectedBmQty; `test_benchmark_generates_correctly_for_hyflux_single_day_lookback];
    };

test_alert_does_not_generate_for_hyflux_single_day_lookback:{
    daysToLookBack:1;
    expectedAlertCount:0;
    alertDt:2020.01.13;
    threshold:0.05;

    res:generateAlert[mockDataHyflux;daysToLookBack;threshold;alertDt];
    assetEquals[count res; expectedAlertCount; `test_alert_does_not_generate_for_hyflux_single_day_lookback];
    };

test_benchmark_generates_correctly_for_IQU[];
test_alert_generates_correctly_for_IQU[];
test_benchmark_generates_correctly_for_hyflux_single_day_lookback[];
test_alert_does_not_generate_for_hyflux_single_day_lookback[];
