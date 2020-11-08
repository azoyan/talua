require "spec.approx"

describe("#truerange True Range", function()
    local TrueRange = require "TrueRange"
    local Bar = require "Candlestick"

    it("add() series() #tr", function()
        local tr = TrueRange()

        local input = tr:add{Bar():high(67.27):low(65.75):close(65.98), Bar():high(65.7):low(65.04):close(65.11),
                             Bar():high(65.05):low(64.26):close(64.97), Bar():high(65.16):low(64.09):close(64.29),
                             Bar():high(62.73):low(61.85):close(62.44), Bar():high(62.02):low(61.29):close(61.47),
                             Bar():high(62.75):low(61.55):close(61.59), Bar():high(64.78):low(62.22):close(64.64),
                             Bar():high(64.5):low(63.03):close(63.28), Bar():high(63.7):low(62.7):close(63.59),
                             Bar():high(64.45):low(63.26):close(63.61), Bar():high(64.56):low(63.81):close(64.52),
                             Bar():high(64.84):low(63.66):close(63.91), Bar():high(65.3):low(64.5):close(65.22),
                             Bar():high(65.36):low(64.46):close(65.06), Bar():high(64.54):low(63.56):close(63.65),
                             Bar():high(64.03):low(63.33):close(63.73), Bar():high(63.4):low(62.8):close(62.83),
                             Bar():high(63.75):low(62.96):close(63.6), Bar():high(63.64):low(62.51):close(63.51),
                             Bar():high(64.03):low(63.53):close(63.76), Bar():high(63.77):low(63.01):close(63.65),
                             Bar():high(63.95):low(63.58):close(63.79), Bar():high(63.47):low(62.92):close(63.25),
                             Bar():high(63.96):low(63.21):close(63.48), Bar():high(63.63):low(62.55):close(63.5),
                             Bar():high(63.25):low(62.82):close(62.9), Bar():high(62.34):low(62.05):close(62.18),
                             Bar():high(62.86):low(61.94):close(62.81), Bar():high(63.06):low(62.44):close(62.83),
                             Bar():high(63.16):low(62.66):close(63.09), Bar():high(62.89):low(62.43):close(62.66),
                             Bar():high(62.39):low(61.9):close(62.25), Bar():high(61.69):low(60.97):close(61.5),
                             Bar():high(61.87):low(61.18):close(61.79), Bar():high(63.41):low(62.72):close(63.16),
                             Bar():high(64.4):low(63.65):close(63.89), Bar():high(63.45):low(61.6):close(61.87),
                             Bar():high(62.35):low(61.3):close(61.54), Bar():high(61.49):low(60.33):close(61.06),
                             Bar():high(60.78):low(59.84):close(60.09), Bar():high(59.62):low(58.62):close(58.8),
                             Bar():high(59.6):low(58.89):close(59.53), Bar():high(60.96):low(59.42):close(60.68),
                             Bar():high(61.12):low(60.65):close(60.73), Bar():high(61.19):low(60.62):close(61.19),
                             Bar():high(61.07):low(60.54):close(60.97), Bar():high(61.05):low(59.65):close(59.75),
                             Bar():high(60):low(58.99):close(59.93), Bar():high(60.12):low(59.26):close(59.73),
                             Bar():high(60.11):low(59.35):close(59.57), Bar():high(60.4):low(59.6):close(60.1),
                             Bar():high(60.31):low(59.76):close(60.28), Bar():high(61.68):low(60.5):close(61.5),
                             Bar():high(62.72):low(61.64):close(62.26), Bar():high(64.08):low(63.1):close(63.7),
                             Bar():high(64.6):low(63.99):close(64.39), Bar():high(64.45):low(63.92):close(64.25),
                             Bar():high(65.4):low(64.66):close(64.7), Bar():high(65.86):low(65.32):close(65.75),
                             Bar():high(65.22):low(64.63):close(64.75), Bar():high(65.39):low(64.76):close(65.04),
                             Bar():high(65.3):low(64.78):close(65.18), Bar():high(65.09):low(64.42):close(65.09),
                             Bar():high(65.64):low(65.2):close(65.25), Bar():high(65.59):low(64.74):close(64.84),
                             Bar():high(65.84):low(65.42):close(65.82), Bar():high(66.75):low(65.85):close(66),
                             Bar():high(67.41):low(66.17):close(67.41), Bar():high(68.61):low(68.06):close(68.41),
                             Bar():high(68.91):low(68.42):close(68.76), Bar():high(69.58):low(68.86):close(69.01),
                             Bar():high(69.14):low(68.74):close(68.94), Bar():high(68.73):low(68.06):close(68.65),
                             Bar():high(68.79):low(68.19):close(68.67), Bar():high(69.75):low(68.68):close(68.74),
                             Bar():high(68.82):low(67.71):close(67.76)}

        local expected = {1.52, 0.939999999999998, 0.849999999999994, 1.06999999999999, 2.44, 1.15, 1.28, 3.19, 1.61, 1,
                          1.19, 0.950000000000003, 1.18000000000001, 1.39, 0.900000000000006, 1.5, 0.700000000000003,
                          0.93, 0.920000000000002, 1.13, 0.520000000000003, 0.760000000000005, 0.370000000000005,
                          0.869999999999997, 0.75, 1.08000000000001, 0.68, 0.850000000000001, 0.920000000000002,
                          0.620000000000005, 0.5, 0.660000000000004, 0.759999999999998, 1.28, 0.689999999999998, 1.62,
                          1.24000000000001, 2.29, 1.05, 1.21, 1.22, 1.47000000000001, 0.800000000000004, 1.54,
                          0.469999999999999, 0.57, 0.649999999999999, 1.4, 1.01, 0.859999999999999, 0.759999999999998,
                          0.829999999999998, 0.550000000000004, 1.4, 1.22, 1.82, 0.899999999999992, 0.530000000000001,
                          1.15000000000001, 1.16, 1.12, 0.640000000000001, 0.519999999999996, 0.760000000000005,
                          0.549999999999997, 0.850000000000009, 1, 0.930000000000007, 1.41, 1.2, 0.5, 0.819999999999993,
                          0.400000000000006, 0.879999999999995, 0.600000000000009, 1.08, 1.11}

        local series = input:series()
        assert.are.approx_same_series(expected, series, 0.1)
    end)

    it("#tr2", function()
        local tr = TrueRange(14)

        local input = {Bar():open(11577):high(11711):low(11577):close(11671),
                       Bar():open(11671):high(11698):low(11636):close(11691),
                       Bar():open(11689):high(11743):low(11653):close(11723),
                       Bar():open(11717):high(11737):low(11667):close(11697),
                       Bar():open(11697):high(11727):low(11600):close(11675),
                       Bar():open(11672):high(11677):low(11574):close(11637),
                       Bar():open(11639):high(11704):low(11635):close(11672),
                       Bar():open(11674):high(11782):low(11674):close(11755),
                       Bar():open(11754):high(11757):low(11701):close(11732),
                       Bar():open(11732):high(11794):low(11699):close(11787),
                       Bar():open(11784):high(11859):low(11778):close(11838),
                       Bar():open(11834):high(11861):low(11798):close(11825),
                       Bar():open(11824):high(11845):low(11745):close(11823),
                       Bar():open(11823):high(11905):low(11823):close(11872),
                       Bar():open(11873):high(11983):low(11868):close(11981),
                       Bar():open(11981):high(11986):low(11899):close(11977),
                       Bar():open(11979):high(12021):low(11962):close(11985),
                       Bar():open(11985):high(12020):low(11972):close(11990),
                       Bar():open(11824):high(11892):low(11818):close(11892),
                       Bar():open(11893):high(12051):low(11893):close(12040)}

        tr:add(input)

        local expected = {134, 62.4799999999996, 89.7900000000009, 69.2800000000007, 127.26, 103.459999999999,
                          68.6400000000012, 110.35, 56.7199999999994, 95.3199999999997, 80.7900000000009,
                          62.7800000000007, 100.389999999999, 82.6800000000003, 114.960000000001, 87.2299999999996,
                          58.6900000000005, 47.6000000000004, 171.950000000001, 158.82}

        local series = tr:series()
        assert.are.approx_same_series(expected, series)
        tr:reset()
        series = tr:reset()
        assert.are.same(0, #tr:series())
        assert.falsy(tr.prev_close)
        assert.are.approx_same_series(expected, tr:add(input):series())
    end)
end)
