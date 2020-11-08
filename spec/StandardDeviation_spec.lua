require "spec.approx"

describe("#sd Standard Deviation", function()
    local StandardDeviation = require "StandardDeviation"

    it("add() series() #sd1", function()
        local sd = StandardDeviation(10)
        -- data for the test is taken from here
        -- https://school.stockcharts.com/lib/exe/fetch.php?media=technical_indicators:standard_deviation_volatility:cs-stddev.xls

        sd:add(52.22, 52.78, 53.02, 53.67, 53.67, 53.74, 53.45, 53.72, 53.39, 52.51, 52.32, 51.45, 51.60, 52.43, 52.47,
            52.91, 52.07, 53.12, 52.77, 52.73, 52.09, 53.19, 53.73, 53.87, 53.85, 53.88, 54.08, 54.14, 54.50, 54.30,
            54.40, 54.16)

        assert.approx_same(0.24, sd:last())
        local expected = {0.51, 0.73, 0.86, 0.83, 0.79, 0.72, 0.68, 0.58, 0.51, 0.52, 0.53, 0.48, 0.49, 0.58, 0.62,
                          0.67, 0.62, 0.66, 0.69, 0.65, 0.36, 0.24}

        assert.are.approx_same_series(expected, sd:series())
        sd:reset()
        assert.falsy(sd:last())

        local Candlestick = require "Candlestick"
        local input = {Candlestick():close(52.22), Candlestick():close(52.78), Candlestick():close(53.02),
                       Candlestick():close(53.67), Candlestick():close(53.67), Candlestick():close(53.74),
                       Candlestick():close(53.45), Candlestick():close(53.72), Candlestick():close(53.39),
                       Candlestick():close(52.51), Candlestick():close(52.32), Candlestick():close(51.45),
                       Candlestick():close(51.60), Candlestick():close(52.43), Candlestick():close(52.47),
                       Candlestick():close(52.91), Candlestick():close(52.07), Candlestick():close(53.12),
                       Candlestick():close(52.77), Candlestick():close(52.73), Candlestick():close(52.09),
                       Candlestick():close(53.19), Candlestick():close(53.73), Candlestick():close(53.87),
                       Candlestick():close(53.85), Candlestick():close(53.88), Candlestick():close(54.08),
                       Candlestick():close(54.14), Candlestick():close(54.50), Candlestick():close(54.30),
                       Candlestick():close(54.40), Candlestick():close(54.16)}
        sd:add(input)
        assert.are.approx_same_series(expected, sd:series())
        assert.are.approx_same(53.1947, sd:mean())
        assert.are.same("sd", tostring(sd))
    end)
end)
