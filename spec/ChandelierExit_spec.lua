require "spec.approx"

describe("#сe Chandelier Exit", function()
    local ChandelierExit = require "ChandelierExit"
    local Bar = require "Candlestick"

    it("add() series() #ce1", function()
        local ce = ChandelierExit(14)
        -- data for the test is taken from here 
        -- https://school.stockcharts.com/doku.php?id=technical_indicators:chandelier_exit
        local input = {Bar():high(67.27):low(65.75):close(65.98), Bar():high(65.7):low(65.04):close(65.11),
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

        local expected = {1.411, 1.375, 1.384, 1.335, 1.306, 1.278, 1.268, 1.214, 1.182, 1.124, 1.106, 1.080, 1.080,
                          1.052, 1.037, 1.029, 1.000, 0.964, 0.942, 0.929, 0.954, 0.936, 0.984, 1.003, 1.095, 1.091,
                          1.100, 1.108, 1.134, 1.110, 1.141, 1.093, 1.056, 1.027, 1.053, 1.050, 1.037, 1.017, 1.004,
                          0.971, 1.002, 1.017, 1.075, 1.062, 1.024, 1.033, 1.042, 1.048, 1.019, 0.983, 0.967, 0.937,
                          0.931, 0.936, 0.936, 0.969, 0.986, 0.951, 0.942, 0.903, 0.902, 0.880, 0.894, 0.910}
        for i = 1, #expected do
            expected[i] = expected[i] * ce.multiplier
        end
        ce:add(input)
        local series = ce:series()
        assert.are.approx_same_series(expected, series, 0.5)
        assert.approx_same(0.910, ce:last())
        ce:reset()
        assert.falsy(ce:last())
    end)
end)
