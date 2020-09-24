relevantStatus:`new`replaced; / z

// Benchmark logic
generateBenchmark:{[x;y;a;b]
    select bm:sum(qty)*(1+a)%y by sym, trader from x where date<b, date>=b-y, status in relevantStatus // Assume that lookback includes wkend and hols
    };

// Alert logic
generateAlert:{[x;y;a;b]
    benchmark: generateBenchmark[x;y;a;b];
    transactions: select sum(qty) by sym, trader from x where date=b, status in relevantStatus ; // All transactions on alert date
    alerts: select from (transactions lj benchmark) where qty > bm, not null bm; // Excluding nulls since there are no historical activities
    join:({$[0<type x;x,/:y;0<type y;x,\:y;x,'y]}/); // String concatenation function
    update alertMsg:join ("Warning! Trader "; ($:)trader;" breached the threshold for sym "; ($:)sym;". Benchmark qty is "; ($:)bm; " against actual qty of "; ($:)qty) from alerts
    };
