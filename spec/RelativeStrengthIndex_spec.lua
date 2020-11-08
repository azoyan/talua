describe("#rsi RelativeStrengthIndex", function()
    local RelativeStrengthIndex = require "RelativeStrengthIndex"
    local Bar = require "Candlestick"
    require "spec.approx"

    it("new()", function()
        local rsi = RelativeStrengthIndex(3)
        assert.are.same(3, rsi.period)
    end)

    it("new() error", function()
        assert.has_error(function()
            RelativeStrengthIndex(0)
        end, "Period must be greater than zero")
    end)

    it("add and last() 2 #rs", function()
        local input = {45.15, 46.26, 46.5, 46.23, 46.08, 46.03, 46.83, 47.69, 47.54, 49.25, 49.23, 48.2, 47.57, 47.61,
                       48.08, 47.21, 46.76, 46.68, 46.21, 47.47, 47.98, 47.13, 46.58, 46.03, 46.54, 46.79, 45.83, 45.93,
                       45.8, 46.69, 47.05, 47.3, 48.1, 47.93, 47.03, 47.58, 47.38, 48.1, 48.47, 47.6, 47.74, 48.21,
                       48.56, 48.15, 47.81, 47.41, 45.66, 45.75, 45.07, 43.77, 43.25, 44.68, 45.11, 45.8, 45.74, 46.23,
                       46.81, 46.87, 46.04, 44.78, 44.58, 44.14, 45.66, 45.89, 46.73, 46.86, 46.95, 46.74, 46.67, 45.3,
                       45.4, 45.54, 44.96, 44.47, 44.68, 45.91, 46.03, 45.98, 46.32, 46.53, 46.28, 46.14, 45.92, 44.8,
                       44.38, 43.48, 44.28, 44.87, 44.98, 43.96, 43.58, 42.93, 42.46, 42.8, 43.27, 43.89, 45, 44.03,
                       44.37, 44.71, 45.38, 45.54}

        local expected = {69.46, 61.77, 58.18, 57.54, 53.80, 61.10, 63.61, 57.01, 53.17, 49.57, 52.77, 54.29, 47.89,
                          48.57, 47.70, 53.81, 56.05, 57.59, 62.15, 60.66, 53.35, 56.78, 55.19, 59.57, 61.65, 54.55,
                          55.44, 58.38, 60.48, 56.87, 53.99, 50.74, 39.53, 40.26, 36.65, 30.95, 29.00, 40.14, 43.04,
                          47.43, 47.09, 50.23, 53.73, 54.09, 48.48, 41.45, 40.44, 38.25, 48.61, 49.98, 54.72, 55.43,
                          55.94, 54.37, 53.83, 44.50, 45.25, 46.33, 42.56, 39.63, 41.49, 51.02, 51.84, 51.45, 53.98,
                          55.52, 53.24, 51.95, 49.90, 41.05, 38.31, 33.19, 40.77, 45.66, 46.55, 40.02, 37.89, 34.51,
                          32.27, 35.53, 39.85, 45.07, 52.95, 46.65, 48.95, 51.21, 55.39, 56.36}

        local rsi = RelativeStrengthIndex(14)
        local series = rsi:add(input):series()
        assert.are.same(#expected, #series)
        assert.are.approx_same_series(expected, series)
    end)

    it("add and last() 2 #rs2", function()
        local rsi = RelativeStrengthIndex(14)
        local input = {44.34, 44.09, 44.15, 43.61, 44.33, 44.83, 45.10, 45.42, 45.84, 46.08, 45.89, 46.03, 45.61, 46.28,
                       46.28, 46.00, 46.03, 46.41, 46.22, 45.64, 46.21, 46.25, 45.71, 46.45, 45.78, 45.35, 44.03, 44.18,
                       44.22, 44.57, 43.42, 42.66, 43.13}
        local series = rsi:add(input):series()

        local expected_rsi = {70.53, 66.32, 66.55, 69.41, 66.36, 57.97, 62.93, 63.26, 56.06, 62.38, 54.71, 50.42, 39.99,
                              41.46, 41.87, 45.46, 37.30, 33.08, 37.77}

        assert.are.approx_same_series(expected_rsi, series)
    end)

    it("add and last() 3", function()
        local rsi = RelativeStrengthIndex(14)
        local series = rsi:add{283.46, 280.69, 285.48, 294.08, 293.90, 299.92, 301.15, 284.45, 294.09, 302.77, 301.97,
                               306.85, 305.02, 301.06, 291.97}:series()

        assert.approx_same(55.37, series[1])
    end)

    it("add and last() 4", function()
        local input = {283.46, 280.69, 285.48, 294.08, 293.90, 299.92, 301.15, 284.45, 294.09, 302.77, 301.97, 306.85,
                       305.02, 301.06, 291.97, 284.18, 286.48, 284.54, 276.82, 284.49, 275.01, 279.07, 277.85, 278.85,
                       283.76, 291.72, 284.73, 291.82, 296.74, 291.13}
        local expected = {55.37, 50.07, 51.55, 50.20, 45.14, 50.48, 44.69, 47.47, 46.71, 47.45, 51.05, 56.29, 51.12,
                          55.58, 58.41, 54.17}

        local rsi = RelativeStrengthIndex(14)
        local series = rsi:add(input):series()

        assert.are.same(#expected, #series)
        assert.are.approx_same_series(expected, series)
    end)

    it("add() and last() with Bar", function()
        local rsi = RelativeStrengthIndex(14)
        local b1 = Bar():close(283.46)
        local b2 = Bar():close(280.69)
        local b3 = Bar():close(285.48)
        local b4 = Bar():close(294.08)
        local b5 = Bar():close(293.90)
        local b6 = Bar():close(299.92)
        local b7 = Bar():close(301.15)
        local b8 = Bar():close(284.45)
        local b9 = Bar():close(294.09)
        local b10 = Bar():close(302.77)
        local b11 = Bar():close(301.97)
        local b12 = Bar():close(306.85)
        local b13 = Bar():close(305.02)
        local b14 = Bar():close(301.06)
        local b15 = Bar():close(291.97)
        assert.are.same(tostring(b1), "C")
        local series = rsi:add(b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15)
        local series = rsi:series()
        assert.are.approx_same(55.37, series[1])
    end)

    it("add() and series() #2", function()
        local expected = {42.5005926536937, 43.1493029203699, 42.5179179330503, 43.7428880282025, 41.6908062815221,
                          39.3491114641621, 38.3228784573702, 43.6482707530234, 41.311264465689, 37.8265056442966,
                          43.5117944288356, 42.5060875015588, 35.2202880292762, 35.2202880292762, 35.2202880292762,
                          34.4879819055269, 29.9572728199923, 26.5478313074734, 20.8708913371213, 31.4463244115823,
                          33.040973482592, 33.5116575911927, 31.2292755834173, 31.2292755834173, 35.7767013574707,
                          40.9875756878415, 48.0058775803465, 45.5941655689142, 41.0298379295101, 40.3289770680518,
                          38.2536267871332, 37.5832753560584, 37.1204374289492, 33.2579718945787, 41.0646242443953,
                          43.1043047894955, 48.9360468113803, 51.5158511098101, 56.8524438967875, 59.7830735701197,
                          51.7280341868072, 57.014721290917, 51.1591749689041, 55.4374222419226, 54.0945400404125,
                          54.0945400404125, 56.3819214797057, 56.3639002786295, 50.0325989027965, 55.6071155780557,
                          55.5546901064256, 47.1469152615986, 45.773757752334, 44.4234604008364, 39.4741137820041,
                          44.0016616077304, 41.9471061360969, 40.4097715040515, 51.5370742616975, 62.6686708834088,
                          63.9105563639115, 61.3617876852676, 62.9051498288336, 57.0759950583751, 60.4639491845098,
                          60.2048226315176}

        local rsi = RelativeStrengthIndex(14)
        local series = rsi:add(1181.75, 1154.59998, 1133.19995, 1132.15002, 1167.40002, 1122.90002, 1099.40002,
                           1097.59998, 1097.34998, 1094.90002, 1111.94995, 1125.94995, 1138.40002, 1138.40002,
                           1149.90002, 1152.15002, 1149.40002, 1153.19995, 1145.05005, 1135.44995, 1131.19995, 1145.5,
                           1136.80005, 1122.90002, 1138.30005, 1134.59998, 1103.84998, 1103.84998, 1103.84998,
                           1100.80005, 1080.19995, 1061.5, 1020, 1047.80005, 1052.40002, 1053.69995, 1041.15002,
                           1041.15002, 1052.40002, 1066.34998, 1087.90002, 1079, 1060.69995, 1057.75, 1049.05005,
                           1046.25, 1044.40002, 1028.19995, 1047.34998, 1052.80005, 1069.5, 1077.55005, 1095.84998,
                           1107.09998, 1083.15002, 1103.44995, 1083.75, 1100.84998, 1096.34998, 1096.34998, 1104.75,
                           1104.69995, 1086.30005, 1105.40002, 1105.25, 1078.90002, 1074.05005, 1069.34998, 1050.80005,
                           1063.30005, 1055.69995, 1049.94995, 1083.40002, 1133, 1139.90002, 1131.90002, 1139.65002,
                           1121.25, 1137.05005, 1136.25):series()

        assert.are.approx_same_series(expected, series)
    end)

    it("reset() ", function()
        local rsi = RelativeStrengthIndex(5)
        assert.are.same(5, rsi.period)

        assert.are.same(nil, rsi:add(4.0):last())
        assert.are.same(0, #rsi.gains)
        assert.are.same(nil, rsi:add(5.0):last())
        assert.are.same(1, rsi.gains[1])
        assert.are.same(nil, rsi:add(6.0):last())
        assert.are.same(1, rsi.gains[2])
        assert.are.same(nil, rsi:add(4.0):last())
        assert.are.same(2, rsi.losses[3])

        assert.are.same(4, #rsi.prices)
        assert.are.same(#rsi.gains, #rsi.losses)
        assert.are.same(#rsi.gains, #rsi.prices - 1)

        rsi:reset()
        assert.are.same(0, #rsi.prices)
        assert.are.same(0, #rsi.losses)
        assert.are.same(0, #rsi.gains)
    end)

    it("#rsi4", function()
        local input = {Bar():open(11577):high(11711):low(11577):close(11671),
                       Bar():open(11671):high(11698):low(11636):close(11691),
                       Bar():open(11689):high(11743):low(11653):close(11723),
                       Bar():open(11717):high(11737):low(11667):close(11697),
                       Bar():open(11697):high(11727):low(11600):close(11675),
                       Bar():open(11672):high(11677):low(11574):close(11637),
                       Bar():open(11639):high(11704):low(11635):close(11672),
                       Bar():open(11674):high(11782):low(11674):close(11755),
                       Bar():open(11754):high(11757):low(11701):close(11732),
                       Bar():open(11732):high(11794):low(11699):close(11787),
                       Bar():open(11784):high(11859):low(11778):close(11838),
                       Bar():open(11834):high(11861):low(11798):close(11825),
                       Bar():open(11824):high(11845):low(11745):close(11823),
                       Bar():open(11823):high(11905):low(11823):close(11872),
                       Bar():open(11873):high(11983):low(11868):close(11981),
                       Bar():open(11981):high(11986):low(11899):close(11977),
                       Bar():open(11979):high(12021):low(11962):close(11985),
                       Bar():open(11985):high(12020):low(11972):close(11990),
                       Bar():open(11824):high(11892):low(11818):close(11892),
                       Bar():open(11893):high(12051):low(11893):close(12040),
                       Bar():open(12038):high(12058):low(12019):close(12042),
                       Bar():open(12041):high(12081):low(11981):close(12062),
                       Bar():open(12062):high(12092):low(12026):close(12092),
                       Bar():open(12092):high(12189):low(12092):close(12162),
                       Bar():open(12153):high(12239):low(12150):close(12233),
                       Bar():open(12229):high(12254):low(12188):close(12240),
                       Bar():open(12240):high(12240):low(12157):close(12229),
                       Bar():open(12228):high(12286):low(12180):close(12273),
                       Bar():open(12267):high(12276):low(12236):close(12268),
                       Bar():open(12267):high(12268):low(12193):close(12227),
                       Bar():open(12220):high(12303):low(12220):close(12288),
                       Bar():open(12288):high(12331):low(12253):close(12318),
                       Bar():open(12390):high(12390):low(12176):close(12213),
                       Bar():open(12212):high(12221):low(12063):close(12106),
                       Bar():open(12105):high(12130):low(11983):close(12069),
                       Bar():open(12061):high(12151):low(12061):close(12130),
                       Bar():open(12130):high(12235):low(12130):close(12226),
                       Bar():open(12226):high(12261):low(12055):close(12058),
                       Bar():open(12057):high(12115):low(12019):close(12067),
                       Bar():open(12068):high(12283):low(12068):close(12258),
                       Bar():open(12171):high(12243):low(12042):close(12090),
                       Bar():open(12086):high(12251):low(12072):close(12214),
                       Bar():open(12211):high(12258):low(12157):close(12213),
                       Bar():open(12211):high(12211):low(11974):close(12024),
                       Bar():open(11977):high(12087):low(11936):close(12044),
                       Bar():open(12042):high(12042):low(11897):close(11993),
                       Bar():open(11989):high(11989):low(11696):close(11891),
                       Bar():open(11854):high(11857):low(11555):close(11613),
                       Bar():open(11615):high(11801):low(11615):close(11775),
                       Bar():open(11777):high(11927):low(11777):close(11859),
                       Bar():open(11860):high(12078):low(11860):close(12037),
                       Bar():open(12036):high(12051):low(12003):close(12019),
                       Bar():open(12018):high(12116):low(11973):close(12086),
                       Bar():open(12088):high(12191):low(12088):close(12171),
                       Bar():open(12171):high(12260):low(12171):close(12221),
                       Bar():open(12221):high(12273):low(12198):close(12198),
                       Bar():open(12194):high(12285):low(12174):close(12279),
                       Bar():open(12280):high(12383):low(12280):close(12351),
                       Bar():open(12351):high(12382):low(12319):close(12320),
                       Bar():open(12321):high(12420):low(12321):close(12377),
                       Bar():open(12375):high(12407):low(12369):close(12400),
                       Bar():open(12402):high(12438):low(12353):close(12394),
                       Bar():open(12387):high(12451):low(12387):close(12427),
                       Bar():open(12426):high(12441):low(12328):close(12409),
                       Bar():open(11945):high(12012):low(11918):close(11953),
                       Bar():open(11951):high(12121):low(11951):close(12076),
                       Bar():open(12075):high(12075):low(11863):close(11897),
                       Bar():open(11896):high(11990):low(11876):close(11962),
                       Bar():open(11963):high(12073):low(11963):close(12004),
                       Bar():open(12081):high(12217):low(12081):close(12190),
                       Bar():open(12190):high(12208):low(12106):close(12110),
                       Bar():open(12108):high(12109):low(11875):close(12050),
                       Bar():open(12049):high(12057):low(11925):close(11935),
                       Bar():open(11935):high(12099):low(11934):close(12044),
                       Bar():open(12042):high(12190):low(12042):close(12189),
                       Bar():open(12188):high(12284):low(12176):close(12261),
                       Bar():open(12262):high(12427):low(12262):close(12414),
                       Bar():open(12412):high(12596):low(12404):close(12583),
                       Bar():open(12583):high(12602):low(12541):close(12570),
                       Bar():open(12562):high(12643):low(12539):close(12626),
                       Bar():open(12627):high(12754):low(12627):close(12719),
                       Bar():open(12718):high(12718):low(12567):close(12657),
                       Bar():open(12656):high(12656):low(12470):close(12506),
                       Bar():open(12506):high(12571):low(12447):close(12447),
                       Bar():open(12447):high(12611):low(12447):close(12492),
                       Bar():open(12492):high(12582):low(12414):close(12437),
                       Bar():open(12437):high(12505):low(12406):close(12480),
                       Bar():open(12475):high(12475):low(12296):close(12385),
                       Bar():open(12386):high(12608):low(12386):close(12587),
                       Bar():open(12584):high(12604):low(12547):close(12572),
                       Bar():open(12567):high(12751):low(12567):close(12724),
                       Bar():open(12725):high(12741):low(12644):close(12681),
                       Bar():open(12680):high(12680):low(12536):close(12593),
                       Bar():open(12592):high(12593):low(12489):close(12501),
                       Bar():open(12498):high(12499):low(12290):close(12303),
                       Bar():open(12302):high(12385):low(12227):close(12240),
                       Bar():open(12239):high(12243):low(12083):close(12143),
                       Bar():open(12144):high(12282):low(11998):close(12132),
                       Bar():open(12130):high(12130):low(11866):close(11867),
                       Bar():open(11864):high(11905):low(11700):close(11896),
                       Bar():open(11894):high(11894):low(11372):close(11384),
                       Bar():open(11384):high(11555):low(11139):close(11445),
                       Bar():open(11434):high(11434):low(10810):close(10810),
                       Bar():open(10811):high(11244):low(10604):close(11240),
                       Bar():open(11228):high(11228):low(10686):close(10720),
                       Bar():open(10730):high(11279):low(10730):close(11143),
                       Bar():open(11143):high(11347):low(11142):close(11269),
                       Bar():open(11270):high(11485):low(11270):close(11483),
                       Bar():open(11480):high(11488):low(11293):close(11406),
                       Bar():open(11392):high(11530):low(11322):close(11410),
                       Bar():open(11406):high(11407):low(10882):close(10991),
                       Bar():open(10990):high(11086):low(10801):close(10818),
                       Bar():open(10820):high(11021):low(10820):close(10855),
                       Bar():open(10855):high(11177):low(10854):close(11177),
                       Bar():open(11176):high(11332):low(11113):close(11321),
                       Bar():open(11321):high(11406):low(11107):close(11150),
                       Bar():open(11145):high(11326):low(10929):close(11285),
                       Bar():open(11287):high(11542):low(11287):close(11539),
                       Bar():open(11532):high(11630):low(11429):close(11560),
                       Bar():open(11560):high(11713):low(11528):close(11614),
                       Bar():open(11613):high(11717):low(11488):close(11494),
                       Bar():open(11492):high(11492):low(11211):close(11240),
                       Bar():open(11237):high(11237):low(10933):close(11139),
                       Bar():open(11138):high(11415):low(11138):close(11415),
                       Bar():open(11415):high(11477):low(11284):close(11296),
                       Bar():open(11295):high(11295):low(10936):close(10992),
                       Bar():open(10990):high(11062):low(10825):close(11061),
                       Bar():open(11055):high(11141):low(10987):close(11106),
                       Bar():open(11107):high(11387):low(10994):close(11247),
                       Bar():open(11248):high(11433):low(11247):close(11433),
                       Bar():open(11434):high(11532):low(11407):close(11509),
                       Bar():open(11507):high(11507):low(11255):close(11401),
                       Bar():open(11401):high(11550):low(11374):close(11409),
                       Bar():open(11409):high(11448):low(11117):close(11125),
                       Bar():open(11122):high(11122):low(10597):close(10734),
                       Bar():open(10733):high(10808):low(10639):close(10771),
                       Bar():open(10772):high(11057):low(10772):close(11044),
                       Bar():open(11045):high(11369):low(11045):close(11191),
                       Bar():open(11189):high(11317):low(10997):close(11011),
                       Bar():open(11013):high(11271):low(10965):close(11154),
                       Bar():open(11152):high(11152):low(10910):close(10913),
                       Bar():open(10912):high(10979):low(10653):close(10655),
                       Bar():open(10651):high(10825):low(10404):close(10809),
                       Bar():open(10800):high(10951):low(10738):close(10940),
                       Bar():open(10940):high(11133):low(10859):close(11123),
                       Bar():open(11123):high(11232):low(11051):close(11103),
                       Bar():open(11105):high(11433):low(11105):close(11433),
                       Bar():open(11433):high(11448):low(11366):close(11416),
                       Bar():open(11417):high(11625):low(11417):close(11519),
                       Bar():open(11518):high(11518):low(11378):close(11478),
                       Bar():open(11479):high(11647):low(11479):close(11644),
                       Bar():open(11643):high(11643):low(11378):close(11397),
                       Bar():open(11396):high(11653):low(11296):close(11577),
                       Bar():open(11578):high(11634):low(11469):close(11505),
                       Bar():open(11502):high(11581):low(11391):close(11542),
                       Bar():open(11543):high(11812):low(11543):close(11809),
                       Bar():open(11808):high(11941):low(11806):close(11914),
                       Bar():open(11913):high(11913):low(11683):close(11707),
                       Bar():open(11708):high(11891):low(11694):close(11869),
                       Bar():open(11872):high(12284):low(11872):close(12209),
                       Bar():open(12207):high(12252):low(12164):close(12231),
                       Bar():open(12229):high(12229):low(11954):close(11955),
                       Bar():open(11952):high(11952):low(11630):close(11658),
                       Bar():open(11658):high(11877):low(11658):close(11836),
                       Bar():open(11836):high(12066):low(11835):close(12044),
                       Bar():open(12043):high(12043):low(11850):close(11983),
                       Bar():open(11983):high(12074):low(11881):close(12068),
                       Bar():open(12056):high(12188):low(12002):close(12170),
                       Bar():open(12166):high(12166):low(11737):close(11781),
                       Bar():open(11780):high(11961):low(11780):close(11894),
                       Bar():open(11896):high(12180):low(11896):close(12154),
                       Bar():open(12153):high(12171):low(12027):close(12079),
                       Bar():open(12078):high(12165):low(12001):close(12096),
                       Bar():open(12085):high(12109):low(11891):close(11906)}

        local expected = {78, 76, 75, 79, 69, 80, 78, 76, 80, 81, 81, 83, 82, 82, 78, 72, 75, 76, 75, 55, 52, 55, 59,
                          44, 39, 51, 44, 48, 48, 42, 41, 38, 38, 34, 41, 42, 45, 49, 51, 47, 55, 49, 52, 63, 61, 65,
                          71, 92, 90, 87, 46, 53, 42, 41, 41, 50, 44, 39, 37, 39, 43, 46, 50, 54, 70, 69, 80, 76, 67,
                          60, 65, 65, 72, 64, 66, 63, 63, 55, 51, 45, 34, 34, 35, 37, 28, 31, 21, 24, 11, 25, 17, 28,
                          31, 36, 37, 38, 35, 33, 36, 41, 49, 46, 57, 55, 67, 61, 55, 44, 44, 50, 57, 54, 54, 48, 48,
                          57, 56, 46, 46, 38, 34, 39, 48, 45, 44, 54, 47, 41, 41, 40, 42, 44, 50, 56, 68, 66, 64, 55,
                          63, 58, 66, 80, 79, 69, 69, 74, 70, 62, 53, 57, 58, 62, 61, 64, 54, 52, 54, 57, 55, 43}

        local rsi = RelativeStrengthIndex(14)
        rsi:add(input)
        assert.are.approx_same(expected[1], rsi:series()[1])
    end)
end)
