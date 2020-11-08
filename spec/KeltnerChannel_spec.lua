require "spec.approx"
describe("#kc KeltnerChannel", function()
    local KeltnerChannel = require "KeltnerChannel"
    local Candle = require "Candlestick"

    -- it("add() and series() varargs #kc5", function()
    --     -- test data from https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwjb08Wgm4_tAhXxCRAIHYW1AlAQFjADegQIARAC&url=https%3A%2F%2Fchartpatterns.files.wordpress.com%2F2011%2F11%2Fexcel-indicators1.xls&usg=AOvVaw3JuSJzJ70Pzaba5E-ZrCsZ
    --     local input = {Candle():open(11577):high(11711):low(11577):close(11671),
    --                    Candle():open(11671):high(11698):low(11636):close(11691),
    --                    Candle():open(11689):high(11743):low(11653):close(11723),
    --                    Candle():open(11717):high(11737):low(11667):close(11697),
    --                    Candle():open(11697):high(11727):low(11600):close(11675),
    --                    Candle():open(11672):high(11677):low(11574):close(11637),
    --                    Candle():open(11639):high(11704):low(11635):close(11672),
    --                    Candle():open(11674):high(11782):low(11674):close(11755),
    --                    Candle():open(11754):high(11757):low(11701):close(11732),
    --                    Candle():open(11732):high(11794):low(11699):close(11787),
    --                    Candle():open(11784):high(11859):low(11778):close(11838),
    --                    Candle():open(11834):high(11861):low(11798):close(11825),
    --                    Candle():open(11824):high(11845):low(11745):close(11823),
    --                    Candle():open(11823):high(11905):low(11823):close(11872),
    --                    Candle():open(11873):high(11983):low(11868):close(11981),
    --                    Candle():open(11981):high(11986):low(11899):close(11977),
    --                    Candle():open(11979):high(12021):low(11962):close(11985),
    --                    Candle():open(11985):high(12020):low(11972):close(11990),
    --                    Candle():open(11824):high(11892):low(11818):close(11892),
    --                    Candle():open(11893):high(12051):low(11893):close(12040),
    --                    Candle():open(12038):high(12058):low(12019):close(12042),
    --                    Candle():open(12041):high(12081):low(11981):close(12062),
    --                    Candle():open(12062):high(12092):low(12026):close(12092),
    --                    Candle():open(12092):high(12189):low(12092):close(12162)}

    --     local expected = {{
    --         average = 11869.25,
    --         upper = 12057.39,
    --         lower = 11681.11
    --     }, {
    --         average = 11892.28,
    --         upper = 12072.61,
    --         lower = 11711.95
    --     }, {
    --         average = 11914.95,
    --         upper = 12096.61,
    --         lower = 11733.28
    --     }, {
    --         average = 11938.57,
    --         upper = 12116.78,
    --         lower = 11760.36
    --     }, {
    --         average = 11968.31,
    --         upper = 12147.59,
    --         lower = 11789.03
    --     }}

    --     local kc = KeltnerChannel(14, 2)
    --     assert.are.approx_same_series(expected, kc:add(input):series())
    --     kc:reset()
    --     assert.falsy(kc:last())
    --     assert.same(0, #kc:series())
    --     assert.same(0, #kc.prices)
    -- end)

    it("#kc6", function()
        local input = {Candle():open(303):high(332):low(294):close(329),
                       Candle():open(328):high(335):low(304):close(317),
                       Candle():open(316):high(318):low(295):close(298),
                       Candle():open(300):high(301):low(263):close(263),
                       Candle():open(262):high(288):low(256):close(288),
                       Candle():open(284):high(300):low(279):close(287),
                       Candle():open(286):high(289):low(269):close(269),
                       Candle():open(265):high(268):low(228):close(234),
                       Candle():open(233):high(254):low(225):close(225),
                       Candle():open(224):high(229):low(206):close(212),
                       Candle():open(215):high(227):low(203):close(221),
                       Candle():open(218):high(218):low(177):close(177),
                       Candle():open(177):high(205):low(177):close(179),
                       Candle():open(176):high(202):low(172):close(187),
                       Candle():open(191):high(197):low(163):close(180),
                       Candle():open(178):high(210):low(166):close(210),
                       Candle():open(206):high(244):low(206):close(240),
                       Candle():open(242):high(263):low(241):close(242),
                       Candle():open(238):high(238):low(218):close(230),
                       Candle():open(228):high(229):low(194):close(194)}
        local kc = KeltnerChannel(20, 1)
        kc:add(input)
        assert.are.approx_same_series(
            {average=241.083333333333, upper = 271.633333333333,lower = 210.533333333333}, kc:last())
            kc:reset()
            assert.falsy(kc:last())
            assert.same(0, #kc:series())
            assert.same(0, #kc.prices)
    end)
end)
