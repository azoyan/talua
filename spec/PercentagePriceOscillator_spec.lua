describe("#ppo Percentage price oscillator", function()
    it("#ppo1", function()
        local PercentagePriceOscillator = require "PercentagePriceOscillator"

        local Candle = require "Candlestick"

        local input = {Candle():open(297):high(310):low(294):close(308),
                       Candle():open(311):high(311):low(298):close(306),
                       Candle():open(308):high(313):low(306):close(309),
                       Candle():open(311):high(312):low(294):close(300),
                       Candle():open(302):high(306):low(296):close(306),
                       Candle():open(303):high(307):low(295):close(295),
                       Candle():open(298):high(316):low(290):close(316),
                       Candle():open(314):high(316):low(302):close(311),
                       Candle():open(313):high(328):low(312):close(317),
                       Candle():open(318):high(327):low(313):close(327),
                       Candle():open(326):high(331):low(320):close(330),
                       Candle():open(332):high(332):low(309):close(316),
                       Candle():open(317):high(317):low(309):close(315),
                       Candle():open(312):high(313):low(298):close(302),
                       Candle():open(304):high(310):low(295):close(300),
                       Candle():open(302):high(307):low(286):close(286),
                       Candle():open(285):high(293):low(282):close(288),
                       Candle():open(290):high(305):low(289):close(298),
                       Candle():open(296):high(302):low(292):close(294),
                       Candle():open(296):high(303):low(287):close(300),
                       Candle():open(302):high(302):low(282):close(292),
                       Candle():open(290):high(309):low(290):close(309),
                       Candle():open(306):high(326):low(306):close(321),
                       Candle():open(319):high(337):low(318):close(333),
                       Candle():open(331):high(341):low(328):close(332),
                       Candle():open(334):high(341):low(328):close(338),
                       Candle():open(335):high(337):low(317):close(325),
                       Candle():open(328):high(332):low(322):close(323),
                       Candle():open(325):high(325):low(300):close(300),
                       Candle():open(297):high(319):low(297):close(311),
                       Candle():open(310):high(325):low(308):close(316),
                       Candle():open(315):high(329):low(312):close(329),
                       Candle():open(326):high(339):low(322):close(335),
                       Candle():open(335):high(343):low(332):close(334),
                       Candle():open(335):high(338):low(328):close(336),
                       Candle():open(335):high(348):low(329):close(341),
                       Candle():open(340):high(343):low(330):close(331),
                       Candle():open(332):high(359):low(330):close(359),
                       Candle():open(356):high(361):low(346):close(346),
                       Candle():open(348):high(356):low(346):close(346),
                       Candle():open(346):high(357):low(346):close(350),
                       }

        local expected_ppo = {1.54547806344913, 1.64821683855511, 1.65861889103637, 1.06875927305745, 0.871598914431851,
                              0.833945966128287, 1.12303456800201, 1.48438983126392, 1.72211319193037, 1.93546051157446,
                              2.20028580732425, 2.13574853790193, 2.73768244340098, 2.85744484025551, 2.91586340059201,
                              3.02069879612195, 2.94794238541939}
        local ppo_histogram = {0.354221282276888, 0.454054881536783, 0.575104141829259, 0.408453497925551,
                               0.808309922739681, 0.74245785567537, 0.640701132809495, 0.59642922267155,
                               0.41893824957519}
        local ppo_signal = {1.36789190965348, 1.48140563003767, 1.62518166549499, 1.72729503997638, 1.9293725206613,
                            2.11498698458014, 2.27516226778251, 2.4242695734504, 2.5290041358442}

        local ppo = PercentagePriceOscillator(12, 26, 9)
        assert.truthy(ppo)
        ppo:add(input, 345)
        local series, signals, histogram = ppo:series()
        assert.truthy(series)
        assert.truthy(signals)
        assert.are.same("ppo", tostring(ppo))
        assert.are.approx_same_series(expected_ppo, series)
        assert.are.approx_same_series(ppo_signal, signals)
        assert.are.approx_same_series(ppo_histogram, histogram)

        assert.are.approx_same(2.94794238541939, ppo:last())

        ppo:reset()
        series, signals, histogram = ppo:series()
        assert.are.same(0, #series)
        assert.are.same(0, #histogram)
        assert.are.same(0, #signals)
    end)
end)
