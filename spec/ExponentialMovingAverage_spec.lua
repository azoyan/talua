require "spec.approx"
describe("#ema ExponentialMovingAverage", function()
    local ExponentialMovingAverage = require "ExponentialMovingAverage"
    local Bar = require "Candlestick"
    it("new() ", function()
        local ema = ExponentialMovingAverage(3)
        assert.are.same(3, ema.period)
        assert.are.same(0, #ema.prices)
    end)

    it("new() error", function()
        assert.has_error(function()
            ExponentialMovingAverage(0)
        end, "Period must be greater than zero")
    end)

    -- it("add() basic usage", function()
    --     local ema = ExponentialMovingAverage(3)
    --     ema:add(2.0)
    --     ema:add(5.0)
    --     ema:add(1.0)
    --     assert.are.same(4.25, ema:add(6.25):last())
    -- end)

    -- it("add() with varargs", function()
    --     local ema = ExponentialMovingAverage(3)
    --     assert.are.same(4.25, ema:add(2, 5, 1, 6.25):last())
    -- end)

    it("add(), last(), series() with varargs #ema1", function()
        local expected = {22.22, 22.21, 22.24, 22.27, 22.33, 22.52, 22.80, 22.97, 23.13, 23.28, 23.34, 23.43, 23.51,
                          23.54, 23.47, 23.40, 23.39, 23.26, 23.23, 23.08, 22.92}

        local ema = ExponentialMovingAverage(10)
        local input = {22.27, 22.19, 22.08, 22.17, 22.18, 22.13, 22.23, 22.43, 22.24, 22.29, 22.15, 22.39, 22.38, 22.61,
                       23.36, 24.05, 23.75, 23.83, 23.95, 23.63, 23.82, 23.87, 23.65, 23.19, 23.10, 23.33, 22.68, 23.10,
                       22.40, 22.17}
        assert.are.approx_same_series(expected, ema:add(input):series())
    end)

    it("add() and series() varargs", function()
        local input = {22.27, 22.19, 22.08, 22.17, 22.18, 22.13, 22.23, 22.43, 22.24, 22.29, 22.15, 22.39, 22.38, 22.61,
                       23.36, 24.05, 23.75, 23.83, 23.95, 23.63, 23.82, 23.87, 23.65, 23.19, 23.10, 23.33, 22.68, 23.10,
                       22.40, 22.17}
        local expected = {22.22, 22.21, 22.24, 22.27, 22.33, 22.52, 22.80, 22.97, 23.13, 23.28, 23.34, 23.43, 23.51,
                          23.54, 23.47, 23.40, 23.39, 23.26, 23.23, 23.08, 22.92}
        local ema = ExponentialMovingAverage(10)
        local series = ema:add(input):series()
        assert.are.approx_same_series(expected, series)
    end)

    it("add() and series() varargs #ema5", function()
        local input = {7104, 7058.4, 7269.1, 7398.3, 7489.45, 7505.45, 7496.25, 7579.55, 7540.1, 7569.45, 7598.35,
                       7545.8, 7587.35, 7576.8, 7658.95, 7763.7, 7782.8, 7801.2, 7718.65, 7699.45, 7814.9, 7811.55,
                       7776.2, 7820.7, 7657.7, 7667.75, 7599.3, 7611.85, 7735.3, 7764.6, 7902.55, 7955.8, 7969.9,
                       7951.75, 7952.1, 7901.5, 8017.2, 8029.95, 7895.3, 7894.8, 7840.1, 7783.8, 7732.75, 7773.1,
                       7760.25, 7904.3, 7919.75, 7865.85, 7928.2, 7830.55, 7887.2, 7907.6}
        local expected = {7401.005, 7436.88590909091, 7456.68847107438, 7480.44511269722, 7497.96418311591,
                          7527.23433164029, 7570.22808952387, 7608.87752779226, 7643.84525001185, 7657.44611364606,
                          7665.08318389223, 7692.32260500273, 7714.00031318405, 7725.30934715059, 7742.65310221412,
                          7727.20708362973, 7716.39670478796, 7695.10639482652, 7679.96886849442, 7690.02907422271,
                          7703.58742436403, 7739.76243811603, 7779.04199482221, 7813.74345030908, 7838.83555025288,
                          7859.42908657054, 7867.07834355771, 7894.37319018358, 7919.02351924111, 7914.71015210637,
                          7911.09012445066, 7898.182829096, 7877.38595107854, 7851.0885054279, 7836.90877716828,
                          7822.97081768314, 7837.75794174075, 7852.66558869698, 7855.06275438844, 7868.36043540872,
                          7861.48581078895, 7866.16111791824, 7873.69546011492}

        local ema = ExponentialMovingAverage(10)
        assert.are.approx_same_series(expected, ema:add(input):series())
    end)

    -- it("add() with table and number args #ema6", function()
    --     local ema = ExponentialMovingAverage(3)
    --     assert.are.same(4.45, ema:add{{{2.0, {5.0}}, 1}, 6.25}:last())
    -- end)

    -- it("add() basic usage with Bar and number", function()
    --     local ema = ExponentialMovingAverage(3)
    --     local bar1 = Bar():close(2)
    --     assert.are.same("Candlestick", bar1.type)
    --     local bar2 = Bar():close(5)
    --     ema:add(bar1)
    --     ema:add(bar2)
    --     ema:add(1)
    --     ema:add(6.25)
    --     assert.are.same(4.25, ema:last())
    -- end)

    -- it("add() varags Bar", function()
    --     local ema = ExponentialMovingAverage(3)
    --     local bar1 = Bar():close(2)
    --     local bar2 = Bar():close(5)
    --     ema:add(bar1, bar2)
    --     ema:add(1, 6.25)
    --     assert.are.same(4.45, ema:last())
    -- end)

    it("add() with mixed varargs types, such as numbers and Bars", function()
        local ema = ExponentialMovingAverage(3)
        assert.are.approx_same(60.96, ema:add(37.66, Bar():close(58.06), 87.14):last())
    end)

    it("add() with mixed varargs types, such as numbers and Bars 2", function()
        local ema = ExponentialMovingAverage(3)
        local bar1 = Bar():close(2)
        local bar2 = Bar():close(5)
        assert.are.approx_same(4.45, ema:add(bar1, {bar2, 1}, 6.25):last(), 0.1)
    end)

    it("add() with mixed varargs types, such as numbers and Bars 3", function()
        local ema = ExponentialMovingAverage(3)
        local bar1 = Bar():close(2)
        local bar2 = Bar():close(5)
        assert.are.approx_same(4.45, ema:add(bar1, {bar2, {1}, 6.25}):last(), 0.1)
    end)

    it("reset() ", function()
        local ema = ExponentialMovingAverage(3)
        ema:add(2.0)
        ema:add(5.0)
        ema:add(1.0)
        assert.are.approx_same(4.45, ema:add(6.25):last())
        assert.are.approx_same(4.45, ema:last())
        assert.are.not_equal(4.0, ema:add(4.0):last())

        assert.are.approx_same(3, ema.period)

        ema:reset()

        assert.are.falsy(ema:last())
        assert.are.approx_same(3, ema.period)
        assert.are.falsy(ema:add(4.0):last())
        assert.are.falsy(ema:add(5.0):last())
        assert.are.truthy(ema:add(5.0):last())
    end)
end)
