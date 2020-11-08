require "spec.approx"
describe("#er EfficiencyRatio", function()
    local EfficiencyRatio = require "EfficiencyRatio"

    -- Test Data download from 
    -- https://www.elitetrader.com/et/attachments/kaufman-er-xls.71686/
    it(" last()", function()
        local er = EfficiencyRatio(5)
        local input = {28.26, 28.34, 28.14, 28.39, 27.87, 27.17}
        assert.are.approx_same(-0.668571428571429, er:add(input):last(), 0.1)
    end)

    it("series() #er2", function()
        local er = EfficiencyRatio(5)
        local input = {28.26, 28.34, 28.14, 28.39, 27.87, 27.17, 25.53, 25.74, 26.45, 27.14, 27.25, 26.86, 27.54, 27.83,
                       27.65, 27.91, 28, 27.44, 26.68, 26.59, 26.56, 26.62, 26.43, 26.39, 26.36, 26.82, 27.27, 27.63,
                       27.31, 27.28, 26.56}
        local expected = {-0.371428571428573, -0.668571428571429, -0.788519637462236, -0.798192771084339,
                          -0.375661375661376, -0.007594936708861, 0.511904761904762, 0.530805687203792,
                          0.422480620155038, 0.319444444444443, 0.242424242424242, 0.583333333333334, 0.306666666666667,
                          -0.282608695652172, -0.524324324324323, -0.749999999999999, -0.941176470588235,
                          -0.546666666666666, -0.221238938053096, -0.487804878048774, -0.571428571428561,
                          0.256410256410254, 0.717948717948717, 0.925373134328357, 0.586419753086419, 0.283950617283952,
                          -0.377659574468086}
        assert.are.approx_same_series(expected, er:add(input):series(), 0.1)
    end)

    it("series(), reset(), last()", function()
        local input = {28.26, 28.34, 28.14, 28.39, 27.87, 27.17, 25.53, 25.74, 26.45, 27.14, 27.25, 26.86, 27.54, 27.83,
                       27.65, 27.91, 28, 27.44, 26.68, 26.59, 26.56, 26.62, 26.43, 26.39, 26.36, 26.82, 27.27, 27.63,
                       27.31, 27.28, 26.56, 26.26, 26.04, 26.22, 26.01, 25.81, 26.88, 27.17, 26.99, 27.65, 27.57, 27.34,
                       27.27, 27.05, 27.45, 27.19, 26.82, 27.28}

        local expected = {-0.371428571428573, -0.668571428571429, -0.788519637462236, -0.798192771084339,
                          -0.375661375661376, -0.007594936708861, 0.511904761904762, 0.530805687203792,
                          0.422480620155038, 0.319444444444443, 0.242424242424242, 0.583333333333334, 0.306666666666667,
                          -0.282608695652172, -0.524324324324323, -0.749999999999999, -0.941176470588235,
                          -0.546666666666666, -0.221238938053096, -0.487804878048774, -0.571428571428561,
                          0.256410256410254, 0.717948717948717, 0.925373134328357, 0.586419753086419, 0.283950617283952,
                          -0.377659574468086, -0.791907514450867, -0.79874213836478, -0.731034482758623,
                          -0.337423312883434, -0.405405405405408, 0.446808510638297, 0.487179487179488,
                          0.502564102564099, 0.766666666666664, 0.302631578947368, 0.118055555555554, 0.229508196721312,
                          -0.476190476190475, -0.120000000000001, -0.127118644067796, -0.340909090909091,
                          0.134502923976609}

        local er = EfficiencyRatio(5)
        assert.are.approx_same_series(expected, er:add(input):series(), 0.1)
        er:reset()
        assert.are.approx_same_series({}, er:series())

        local input = {28.26, 28.34, 28.14, 28.39, 27.87, 27.17}
        assert.are.approx_same(-0.668571428571429, er:add(input):last(), 0.1)
    end)

    it("with candlestick", function()
        local Candlestick = require "Candlestick"
        input = {Candlestick():close(28.26), Candlestick():close(28.34), Candlestick():close(28.14),
                 Candlestick():close(28.39), Candlestick():close(27.87), Candlestick():close(27.17)}

        local er = EfficiencyRatio(5)
        assert.are.approx_same(-0.668571428571429, er:add(input):last(), 0.1)
    end)

    it("expected assert error", function()
        assert.has_error(function()
            return EfficiencyRatio(0)
        end, "Period must be greater than zero")
    end)

    it("check type", function()
        local er = EfficiencyRatio(5)
        assert.are.same("er", tostring(er))
    end)
end)
