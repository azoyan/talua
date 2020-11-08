describe("#sma SimpleMovingAverage", function()
    local SimpleMovingAverage = require "SimpleMovingAverage"
    local Bar = require "Candlestick"

    it("new() ", function()
        local sma = SimpleMovingAverage(3)
        assert.are.same(3, sma.period)
        assert.are.same(0, #sma:series())
        assert.are.same(0, #sma.prices)
    end)

    it("new() error", function()
        assert.has_error(function()
            SimpleMovingAverage(0)
        end, "Period must be greater than zero")
    end)

    it("add() and last() with error", function()
        local sma = SimpleMovingAverage(3)
        assert.are.same(nil, sma:add(4.0):last())
    end)

    it("add() basic usage", function()
        local sma = SimpleMovingAverage(3)
        sma:add(10.0)
        sma:add(11.0)
        sma:add(12.0)
        assert.are.same(12.0, sma:add(13.0):last())
    end)

    it("add() basic usage 2", function()
        local sma = SimpleMovingAverage(3)
        sma:add(4.0)
        sma:add(4.0)
        sma:add(7.0)
        assert.are.same(4.0, sma:add(1.0):last())
    end)

    it("add(), last() and series() #sma1", function()
        local expected = {23.07, 23.15, 23.31, 23.51, 23.65, 23.75, 23.78, 23.83, 23.81, 23.79, 23.75, 23.55, 23.35}

        local input = {22.81, 23.09, 22.91, 23.23, 22.83, 23.05, 23.02, 23.29, 23.41, 23.49, 24.60, 24.63, 24.51, 23.73,
                       23.31, 23.53, 23.06, 23.25, 23.12, 22.80, 22.84}

        local sma = SimpleMovingAverage(9)
        local series = sma:add(input):series()
        assert.are.approx_same_series(expected, series)
        assert.are.approx_same(expected[#expected], sma:last())
        assert.are.approx_same(series[#series], sma:last())
    end)

    it("add(), last() and series() #sma2", function()
        local expected = {22.22, 22.21, 22.23, 22.26, 22.31, 22.42, 22.61, 22.77, 22.91, 23.08, 23.21, 23.38, 23.53,
                          23.65, 23.71, 23.69, 23.61, 23.51, 23.43, 23.28, 23.13}

        local input = {22.27, 22.19, 22.08, 22.17, 22.18, 22.13, 22.23, 22.43, 22.24, 22.29, 22.15, 22.39, 22.38, 22.61,
                       23.36, 24.05, 23.75, 23.83, 23.95, 23.63, 23.82, 23.87, 23.65, 23.19, 23.10, 23.33, 22.68, 23.10,
                       22.40, 22.17}

        local sma = SimpleMovingAverage(10)
        local series = sma:add(input):series()
        assert(#expected, #series)
        assert.are.approx_same_series(expected, series)
        assert.are.approx_same(expected[#expected], sma:last())
        assert.are.approx_same(series[#series], sma:last())
    end)

    it("add(), last() and series() with table #sma3", function()
        local input = {81.59, 81.06, 82.87, 83.00, 83.61, 83.15, 82.84, 83.99, 84.55, 84.36, 85.53, 86.54, 86.89, 87.77,
                       87.29}

        local expected = {82.43, 82.74, 83.09, 83.32, 83.63, 83.78, 84.25, 84.99, 85.57, 86.22, 86.80}
        local sma = SimpleMovingAverage(5)
        local series = sma:add(input):series()
        assert(#expected, #series)
        assert.are.approx_same_series(expected, series)
        assert.are.approx_same(expected[#expected], sma:last())
        assert.are.approx_same(series[#series], sma:last())
    end)

    it("add() basic usage 2", function()
        local sma = SimpleMovingAverage(4)
        sma:add(4.0)
        sma:add(5.0)
        sma:add(6.0)
        sma:add(6.0)
        assert.are.same(5.75, sma:add(6.0):last())
        assert.are.same(6.0, sma:add(6.0):last())
        assert.are.same(5.0, sma:add(2.0):last())
    end)

    it("add(), last() with table", function()
        local sma = SimpleMovingAverage(4)
        assert.are.same(5.0, sma:add{4.0, 5.0, 6.0, 6.0, 6.0, 6.0, 2.0}:last())
    end)

    it("add(), last() with table 2", function()
        local sma = SimpleMovingAverage(4)
        assert.are.same(5.0, sma:add{{4.0, {5.0, {6.0, {6.0, {6.0, {6.0, {2.0}}}}}}}}:last())
    end)

    it("add() basic usage with Bar", function()
        local sma = SimpleMovingAverage(3)
        local bar1 = Bar():close(4.0)
        local bar2 = Bar():close(4.0)
        local bar3 = Bar():close(7.0)
        local bar4 = Bar():close(1.0)
        sma:add(bar1)
        sma:add(bar2)
        sma:add(bar3)
        assert.are.same(4.0, sma:add(bar4):last())
    end)

    it("add() basic usage with Bar", function()
        local sma = SimpleMovingAverage(3)
        local bar1 = Bar():close(4.0)
        local bar2 = Bar():close(4.0)
        local bar3 = Bar():close(7.0)
        local bar4 = Bar():close(1.0)
        assert.are.same(4.0, sma:add(bar1, {bar2, bar3}, bar4):last())
    end)

    it("add() with mixed varargs types, such as numbers and Bars", function()
        local sma = SimpleMovingAverage(3)
        local bar1 = Bar():close(4.0)
        local bar2 = Bar():close(4.0)
        assert.are.same(4.0, sma:add{bar1, {bar2}, {7, 1}}:last())
    end)

    it("add() with mixed varargs types, such as numbers and Bars 2", function()
        local sma = SimpleMovingAverage(3)
        local bar1 = Bar():close(4.0)
        local bar2 = Bar():close(4.0)
        assert.are.same(4.0, sma:add(bar1, {bar2}, {7, 1}):last())
    end)

    it("reset() #smareset", function()
        local sma = SimpleMovingAverage(5)
        sma:add(4.0)
        sma:add(5.0)
        sma:add(6.0)
        assert.are.same(nil, sma:add(4.0):last())
        assert.are.approx_same(5.0, sma:add(5.0):last())

        assert.are.same(5, #sma.prices)
        assert.are.same(1, #sma:series())
        assert.are.same(5, sma.period)

        sma:reset()
        -- sma.reset()
        assert.are.same(0, #sma.prices)
        assert.are.same(0, #sma:series())
        assert.are.same(5, sma.period)
    end)
end)
