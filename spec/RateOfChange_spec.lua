require "spec.approx"

describe("#roc Rate of Change", function()
    local RateOfChange = require "RateOfChange"
    local Candlestick = require "Candlestick"

    it("add() series() #roc1", function()
        local roc = RateOfChange(13)
        -- data for the test is taken from here 
        local input = {Candlestick():open(298):high(308):low(298):close(304),
                       Candlestick():open(302):high(309):low(280):close(280),
                       Candlestick():open(282):high(288):low(263):close(266),
                       Candlestick():open(266):high(269):low(248):close(248),
                       Candlestick():open(245):high(246):low(234):close(238),
                       Candlestick():open(239):high(259):low(239):close(259),
                       Candlestick():open(256):high(258):low(231):close(231),
                       Candlestick():open(234):high(239):low(227):close(227),
                       Candlestick():open(224):high(232):low(213):close(213),
                       Candlestick():open(210):high(213):low(190):close(190),
                       Candlestick():open(190):high(191):low(178):close(185),
                       Candlestick():open(183):high(186):low(165):close(165)}

        local input2 = {Candlestick():open(168):high(181):low(165):close(176),
                        Candlestick():open(175):high(185):low(173):close(184),
                        Candlestick():open(184):high(184):low(173):close(180),
                        Candlestick():open(180):high(193):low(177):close(191),
                        Candlestick():open(190):high(200):low(190):close(198),
                        Candlestick():open(197):high(215):low(189):close(215),
                        Candlestick():open(216):high(228):low(215):close(217),
                        Candlestick():open(214):high(214):low(192):close(192),
                        Candlestick():open(191):high(206):low(191):close(206),
                        Candlestick():open(206):high(212):low(199):close(202),
                        Candlestick():open(200):high(218):low(199):close(213)}

        local expected = {-42.1052631578947, -34.2857142857143, -32.3308270676692, -22.9838709677419, -16.8067226890756,
                          -16.988416988417, -6.06060606060606, -15.4185022026432, -3.28638497652582, 6.31578947368421,
                          15.1351351351351}
        roc:add{input, input2}

        local series = roc:series()
        assert.truthy(series)
        assert.are.approx_same_series(expected, series, 0.1)
        local input3 = {227, 221, 232, 230, 215, 204, 223, 221, 201, 199, 174, 178, 174, 181, 168, 175, 170, 180, 207,
                        207, 213, 221, 240, 239, 233, 223, 221, 239, 243, 252, 261, 238, 245, 278, 282, 280, 281, 270,
                        260, 250, 240, 242, 252, 252, 257, 253, 264, 258, 264, 253, 244, 238, 241, 235, 229, 238, 232,
                        222, 230, 216, 221, 206, 194, 192, 212, 230, 246, 238, 214, 213, 216, 217, 206, 213, 202, 207,
                        217}
        roc:add(input3)
        assert.are.approx_same(2.35849056603774, roc:last(), 0.1)
        roc:reset()
        assert.are.same(0, roc.count)
        assert("roc", tostring(roc))
    end)
end)
