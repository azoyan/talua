require "spec.approx"

describe("#obv OnBalanceVolume", function()
    local OnBalanceVolume = require "OnBalanceVolume"
    local Bar = require "Candlestick"

    it("add() series() #obv1", function()
        -- data for the test is taken from here http://investexcell.net
        local input = {Bar():open(51.41):high(51.52):low(51.139999):close(51.450001):volume(2957200),
                       Bar():open(51.139999):high(51.82):low(50.299999):close(50.470001):volume(4639400),
                       Bar():open(52.290001):high(52.900002):low(52):close(52.529999):volume(10640300),
                       Bar():open(52.700001):high(52.889999):low(52.330002):close(52.799999):volume(5365500),
                       Bar():open(52.470001):high(53.330002):low(52.380001):close(53.189999):volume(5001500),
                       Bar():open(54.040001):high(54.290001):low(53.799999):close(54.16):volume(6251900),
                       Bar():open(54.810001):high(55.27):low(54.48):close(54.950001):volume(5362300),
                       Bar():open(54.720001):high(55.099998):low(54.419998):close(55.040001):volume(3722200),
                       Bar():open(54.830002):high(54.93):low(54.23):close(54.580002):volume(4888700),
                       Bar():open(53.599998):high(54.400002):low(53.57):close(54.290001):volume(4445300),
                       Bar():open(53.84):high(54.23):low(53.619999):close(54.119999):volume(5144800)}

        local expected = {2957200, -1682200, 8958100, 14323600, 19325100, 25577000, 30939300, 34661500, 29772800,
                          25327500, 20182700}

        local obv = OnBalanceVolume():add(input)
        assert.are.approx_same_series(expected, obv:series())
        assert.are.approx_same(20182700, obv:last())
        obv:reset()
        assert.falsy(obv:last())
        assert.are.same(0, #obv:series())
        assert.same(0, obv.prev_close)
    end)

    it("add(), last(), series() #obv2", function()
        local input = {Bar():open(51.41):high(51.52):low(51.139999):close(51.450001):volume(2957200),
                       Bar():open(51.41):high(51.52):low(51.139999):close(51.450001):volume(2957200),
                       Bar():open(51.139999):high(51.82):low(50.299999):close(50.470001):volume(4639400),
                       Bar():open(52.290001):high(52.900002):low(52):close(52.529999):volume(10640300),
                       Bar():open(52.700001):high(52.889999):low(52.330002):close(52.799999):volume(5365500),
                       Bar():open(52.470001):high(53.330002):low(52.380001):close(53.189999):volume(5001500),
                       Bar():open(54.040001):high(54.290001):low(53.799999):close(54.16):volume(6251900),
                       Bar():open(54.810001):high(55.27):low(54.48):close(54.950001):volume(5362300),
                       Bar():open(54.720001):high(55.099998):low(54.419998):close(55.040001):volume(3722200),
                       Bar():open(54.830002):high(54.93):low(54.23):close(54.580002):volume(4888700),
                       Bar():open(53.599998):high(54.400002):low(53.57):close(54.290001):volume(4445300),
                       Bar():open(53.84):high(54.23):low(53.619999):close(54.119999):volume(5144800),
                       Bar():open(54.209999):high(54.779999):low(53.990002):close(54.650002):volume(4614200),
                       Bar():open(54.84):high(55.380001):low(54.68):close(54.799999):volume(4980400),
                       Bar():open(54.650002):high(54.93):low(54.299999):close(54.790001):volume(4165100),
                       Bar():open(53.900002):high(54.66):low(53.810001):close(54.41):volume(3702900),
                       Bar():open(55.470001):high(55.610001):low(55.240002):close(55.389999):volume(4503400),
                       Bar():open(55.560001):high(55.580002):low(54.240002):close(54.240002):volume(5165100),
                       Bar():open(54.18):high(54.259998):low(52.810001):close(53.189999):volume(5975900),
                       Bar():open(52.959999):high(53.59):low(52.68):close(52.919998):volume(5292200),
                       Bar():open(52.509998):high(53.650002):low(52.5):close(53.560001):volume(3632500),
                       Bar():open(53.610001):high(53.810001):low(53.290001):close(53.610001):volume(3773700),
                       Bar():open(53.639999):high(53.73):low(52.740002):close(53.23):volume(5462300),
                       Bar():open(52.91):high(52.98):low(51.75):close(51.779999):volume(6524800),
                       Bar():open(51.279999):high(51.77):low(50.599998):close(50.73):volume(9836100),
                       Bar():open(50.93):high(51.68):low(50.639999):close(51.439999):volume(7268500),
                       Bar():open(52.130001):high(52.970001):low(52.02):close(52.5):volume(5896800),
                       Bar():open(51.799999):high(52.290001):low(51.66):close(52.23):volume(5595600),
                       Bar():open(52.25):high(53.110001):low(52.169998):close(52.759998):volume(4698300),
                       Bar():open(52.080002):high(52.34):low(51.709999):close(52.27):volume(6619200),
                       Bar():open(52.400002):high(52.860001):low(52.380001):close(52.639999):volume(4979600),
                       Bar():open(52.73):high(52.880001):low(52.18):close(52.68):volume(5166200),
                       Bar():open(54.0):high(54.0):low(53.5):close(53.66):volume(4747700),
                       Bar():open(54.459999):high(54.880001):low(54.290001):close(54.759998):volume(5889700),
                       Bar():open(55.09):high(55.27):low(54.860001):close(55.009998):volume(5745500),
                       Bar():open(56.040001):high(56.799999):low(55.639999):close(56.400002):volume(6527800),
                       Bar():open(56.43):high(56.5):low(55.720001):close(56.18):volume(4905500),
                       Bar():open(56.43):high(57.349998):low(56.349998):close(56.419998):volume(5843100),
                       Bar():open(56.279999):high(56.790001):low(55.82):close(56.639999):volume(4002000),
                       Bar():open(56.110001):high(56.189999):low(55.150002):close(55.419998):volume(4625100),
                       Bar():open(56.240002):high(56.779999):low(55.25):close(55.48):volume(5531600),
                       Bar():open(57.93):high(58.689999):low(57.41):close(57.82):volume(12981400),
                       Bar():open(57.700001):high(57.700001):low(56.77):close(56.82):volume(10207900),
                       Bar():open(57.959999):high(58.5):low(57.689999):close(58.299999):volume(6835200),
                       Bar():open(57.990002):high(58.07):low(56.150002):close(56.619999):volume(7111900),
                       Bar():open(57.029999):high(57.849998):low(56.52):close(57.27):volume(5574000),
                       Bar():open(56.360001):high(57.810001):low(56.220001):close(57.549999):volume(5694600),
                       Bar():open(57.73):high(58.189999):low(57.470001):close(57.580002):volume(5012600),
                       Bar():open(58.200001):high(58.91):low(58.07):close(58.529999):volume(4688300),
                       Bar():open(57.529999):high(58.43):low(57.450001):close(58.43):volume(4113700),
                       Bar():open(59.68):high(60.0):low(59.610001):close(59.93):volume(6039100),
                       Bar():open(58.740002):high(59.240002):low(58.610001):close(59.130001):volume(5199500),
                       Bar():open(58.759998):high(58.970001):low(58.02):close(58.330002):volume(4827800),
                       Bar():open(57.939999):high(58.119999):low(57.150002):close(57.27):volume(4380100),
                       Bar():open(57.889999):high(58.41):low(57.549999):close(58.349998):volume(3751100),
                       Bar():open(59.049999):high(59.66):low(58.950001):close(59.259998):volume(4582900),
                       Bar():open(59.259998):high(59.580002):low(59.009998):close(59.5):volume(3780600),
                       Bar():open(59.610001):high(59.630001):low(58.98):close(59.240002):volume(2838200),
                       Bar():open(58.689999):high(58.709999):low(57.759998):close(58.630001):volume(3857900),
                       Bar():open(57.380001):high(57.860001):low(57.330002):close(57.830002):volume(3338000),
                       Bar():open(58.75):high(59.09):low(58.459999):close(58.639999):volume(6127400),
                       Bar():open(58.849998):high(58.939999):low(58.09):close(58.720001):volume(3330200),
                       Bar():open(58.849998):high(59.299999):low(58.639999):close(59.220001):volume(2812300),
                       Bar():open(56.709999):high(58.389999):low(56.599998):close(58.110001):volume(3795700),
                       Bar():open(57.029999):high(57.59):low(56.709999):close(57.18):volume(5784000),
                       Bar():open(58.32):high(58.790001):low(58.220001):close(58.580002):volume(3918700),
                       Bar():open(58.540001):high(59.0):low(58.369999):close(58.639999):volume(3945500),
                       Bar():open(58.169998):high(58.48):low(57.610001):close(57.619999):volume(5370100),
                       Bar():open(58.709999):high(58.82):low(57.509998):close(57.860001):volume(4363700),
                       Bar():open(57.650002):high(58.709999):low(57.599998):close(58.169998):volume(4263700),
                       Bar():open(57.380001):high(57.5):low(56.830002):close(57.040001):volume(5451100),
                       Bar():open(56.360001):high(56.700001):low(55.869999):close(56.700001):volume(6537400)}
        local expected = {2957200,2957200, -1682200, 8958100, 14323600, 19325100, 25577000, 30939300, 34661500, 29772800,
                          25327500, 20182700, 24796900, 29777300, 25612200, 21909300, 26412700, 21247600, 15271700,
                          9979500, 13612000, 17385700, 11923400, 5398600, -4437500, 2831000, 8727800, 3132200, 7830500,
                          1211300, 6190900, 11357100, 16104800, 21994500, 27740000, 34267800, 29362300, 35205400,
                          39207400, 34582300, 40113900, 53095300, 42887400, 49722600, 42610700, 48184700, 53879300,
                          58891900, 63580200, 59466500, 65505600, 60306100, 55478300, 51098200, 54849300, 59432200,
                          63212800, 60374600, 56516700, 53178700, 59306100, 62636300, 65448600, 61652900, 55868900,
                          59787600, 63733100, 58363000, 62726700, 66990400, 61539300, 55001900}

        local obv = OnBalanceVolume():add(input)
        assert.are.approx_same_series(expected, obv:series())
    end)
end)
