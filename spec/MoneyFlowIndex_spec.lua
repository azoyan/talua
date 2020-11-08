require "spec.approx"

describe("#mfi Money Flow Index", function()
    local MoneyFlowIndex = require "MoneyFlowIndex"
    local Bar = require "Candlestick"

    it("add() series() #mfi1", function()
        -- data for the test is taken from here http://investexcell.net
        -- https://school.stockcharts.com/doku.php?id=technical_indicators:money_flow_index_mfi
        local input = {Bar():open(44.27):high(45.57):low(43.919998):close(45.57):volume(41839000),
                       Bar():open(45.75):high(46.889999):low(45.700001):close(46.630001):volume(34369300),
                       Bar():open(46.330002):high(47.18):low(46.220001):close(46.75):volume(27017200),
                       Bar():open(47.099998):high(47.349998):low(45.950001):close(46.799999):volume(27711500),
                       Bar():open(46.560001):high(47.52):low(46.5):close(47.450001):volume(33772700),
                       Bar():open(47.450001):high(47.540001):low(46.919998):close(47.110001):volume(28600600),
                       Bar():open(46.98):high(47.07):low(46.5):close(47):volume(19769100),
                       Bar():open(46.560001):high(47.130001):low(46.560001):close(46.889999):volume(19987800),
                       Bar():open(46.650002):high(47.099998):low(46.529999):close(46.68):volume(24697800),
                       Bar():open(47.009998):high(47.029999):low(46.529999):close(47.009998):volume(27189400),
                       Bar():open(47.02):high(47.540001):low(46.900002):close(47.509998):volume(26450300),
                       Bar():open(47.419998):high(47.880001):low(47.02):close(47.619999):volume(29387600),
                       Bar():open(47.439999):high(47.810001):low(47.02):close(47.77):volume(30574000),
                       Bar():open(47.919998):high(47.990002):low(47.110001):close(47.200001):volume(25144300),
                       Bar():open(47.529999):high(48.950001):low(47.09):close(48.029999):volume(56637100),
                       Bar():open(52.299999):high(54.07):low(52.25):close(52.869999):volume(135227100),
                       Bar():open(52.529999):high(54.32):low(52.5):close(54.25):volume(64633300),
                       Bar():open(53.990002):high(54.369999):low(53.580002):close(53.689999):volume(50999900),
                       Bar():open(53.540001):high(53.98):low(52.860001):close(53.98):volume(47000800),
                       Bar():open(53.540001):high(53.830002):low(53.220001):close(53.360001):volume(30036300),
                       Bar():open(53.32):high(53.990002):low(52.619999):close(52.639999):volume(46619800),
                       Bar():open(52.849998):high(53.360001):low(52.619999):close(53.240002):volume(30285000),
                       Bar():open(52.93):high(54.389999):low(52.900002):close(54.150002):volume(36596900),
                       Bar():open(54.18):high(54.880001):low(54.060001):close(54.400002):volume(37020400),
                       Bar():open(54.490002):high(54.700001):low(54):close(54.380001):volume(31468500),
                       Bar():open(54.09):high(54.98):low(53.959999):close(54.919998):volume(32851200),
                       Bar():open(54.549999):high(54.869999):low(53.560001):close(54.16):volume(32513100),
                       Bar():open(54.07):high(54.130001):low(53.27):close(53.509998):volume(55283700),
                       Bar():open(53.700001):high(54.200001):low(53.459999):close(53.650002):volume(36516300),
                       Bar():open(53.48):high(53.98):low(53.189999):close(53.32):volume(35361100),
                       Bar():open(53.07):high(53.290001):low(52.529999):close(52.84):volume(36848200),
                       Bar():open(53.080002):high(53.889999):low(52.849998):close(53.77):volume(32165200),
                       Bar():open(53.169998):high(53.529999):low(52.849998):close(52.970001):volume(31551300),
                       Bar():open(53):high(53.98):low(52.98):close(53.849998):volume(29710000),
                       Bar():open(53.990002):high(54.66):low(53.779999):close(53.939999):volume(28149200),
                       Bar():open(54.25):high(54.299999):low(53.27):close(54.189999):volume(37147600),
                       Bar():open(54.25):high(54.459999):low(53.75):close(54.189999):volume(28235900),
                       Bar():open(53.919998):high(54.439999):low(53.580002):close(54.25):volume(24600000),
                       Bar():open(54.09):high(54.23):low(53.689999):close(53.689999):volume(21005100)}

        local expected = {72.6111648331733, 76.4512911665512, 81.7122284344707, 83.1974405368076, 88.5686494512412,
                          80.4059113259745, 75.1894288419721, 71.4784676959796, 67.0594316171176, 71.3912139914839,
                          72.0226816238743, 67.3772416212932, 67.754266834373, 62.9722316591469, 59.9173259189831,
                          59.0699926933261, 45.776092997738, 36.2038510047921, 33.859866397182, 34.9137230220142,
                          40.809260240199, 48.122358775937, 47.4048521101369, 46.5162593765388, 39.8381916074612,
                          40.7672077257474}

        local mfi = MoneyFlowIndex():add(input)
        assert.are.approx_same_series(expected, mfi:series())
        assert.are.approx_same(40.7672077257474, mfi:last())
        mfi:reset()
        assert.falsy(mfi:last())
        assert.are.same(0, #mfi:series())
        mfi:add(input)
        assert.are.approx_same(40.7672077257474, mfi:last())
        assert.are.approx_same_series(expected, mfi:series())
    end)

    -- it("add() series() #mfi2", function()
    --[[data for the test is taken from here
        https://school.stockcharts.com/doku.php?id=technical_indicators:money_flow_index_mfi]]--

    -- end)
end)

