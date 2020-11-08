describe("#candle Candlestick", function()
    local Candle = require "Candlestick"

    it("add() series() #candle1", function()
        -- data for the test is taken from here http://investexcell.net
        assert.are.same({
            open = 51.41,
            high = 51.52,
            low = 51.139999,
            close = 51.450001,
            volume = 2957200
        }, Candle():open(51.41):high(51.52):low(51.139999):close(51.450001):volume(2957200))

        local candle = Candle():open(51.139999):high(51.82):low(50.299999):close(50.470001):volume(4639400)
        local expected = {
            open = 51.139999,
            high = 51.82,
            low = 50.299999,
            close = 50.470001,
            volume = 4639400
        }
        assert.are.same(expected, candle)

        assert.are.same({
            open = (52.290001),
            high = (52.900002),
            low = (52),
            close = (52.529999),
            volume = (10640300)
        }, Candle():open(52.290001):high(52.900002):low(52):close(52.529999):volume(10640300))

        assert.are.same("C", tostring(candle))
    end)
end)
