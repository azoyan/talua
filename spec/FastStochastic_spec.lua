require "spec.approx"

describe("#fast Fast Stochastic oscillator", function()
    local FastStochastic = require "FastStochastic"
    local Candle = require "Candlestick"

    it("add() series() #fast1", function()
        -- data for the test is taken from here http://investexcell.net
        local input = {Candle():open(11577):high(11711):low(11577):close(11671),
                       Candle():open(11671):high(11698):low(11636):close(11691),
                       Candle():open(11689):high(11743):low(11653):close(11723),
                       Candle():open(11717):high(11737):low(11667):close(11697),
                       Candle():open(11697):high(11727):low(11600):close(11675),
                       Candle():open(11672):high(11677):low(11574):close(11637),
                       Candle():open(11639):high(11704):low(11635):close(11672),
                       Candle():open(11674):high(11782):low(11674):close(11755),
                       Candle():open(11754):high(11757):low(11701):close(11732),
                       Candle():open(11732):high(11794):low(11699):close(11787),
                       Candle():open(11784):high(11859):low(11778):close(11838),
                       Candle():open(11834):high(11861):low(11798):close(11825),
                       Candle():open(11824):high(11845):low(11745):close(11823),
                       Candle():open(11823):high(11905):low(11823):close(11872),
                       Candle():open(11873):high(11983):low(11868):close(11981),
                       Candle():open(11981):high(11986):low(11899):close(11977),
                       Candle():open(11979):high(12021):low(11962):close(11985),
                       Candle():open(11985):high(12020):low(11972):close(11990),
                       Candle():open(11824):high(11892):low(11818):close(11892),
                       Candle():open(11893):high(12051):low(11893):close(12040),
                       Candle():open(12038):high(12058):low(12019):close(12042),
                       Candle():open(12041):high(12081):low(11981):close(12062),
                       Candle():open(12062):high(12092):low(12026):close(12092),
                       Candle():open(12092):high(12189):low(12092):close(12162),
                       Candle():open(12153):high(12239):low(12150):close(12233),
                       Candle():open(12229):high(12254):low(12188):close(12240),
                       Candle():open(12240):high(12240):low(12157):close(12229),
                       Candle():open(12228):high(12286):low(12180):close(12273),
                       Candle():open(12267):high(12276):low(12236):close(12268),
                       Candle():open(12267):high(12268):low(12193):close(12227),
                       Candle():open(12220):high(12303):low(12220):close(12288),
                       Candle():open(12288):high(12331):low(12253):close(12318),
                       Candle():open(12390):high(12390):low(12176):close(12213),
                       Candle():open(12212):high(12221):low(12063):close(12106),
                       Candle():open(12105):high(12130):low(11983):close(12069),
                       Candle():open(12061):high(12151):low(12061):close(12130),
                       Candle():open(12130):high(12235):low(12130):close(12226),
                       Candle():open(12226):high(12261):low(12055):close(12058),
                       Candle():open(12057):high(12115):low(12019):close(12067),
                       Candle():open(12068):high(12283):low(12068):close(12258),
                       Candle():open(12171):high(12243):low(12042):close(12090),
                       Candle():open(12086):high(12251):low(12072):close(12214),
                       Candle():open(12211):high(12258):low(12157):close(12213),
                       Candle():open(12211):high(12211):low(11974):close(12024),
                       Candle():open(11977):high(12087):low(11936):close(12044),
                       Candle():open(12042):high(12042):low(11897):close(11993),
                       Candle():open(11989):high(11989):low(11696):close(11891),
                       Candle():open(11854):high(11857):low(11555):close(11613),
                       Candle():open(11615):high(11801):low(11615):close(11775),
                       Candle():open(11777):high(11927):low(11777):close(11859),
                       Candle():open(11860):high(12078):low(11860):close(12037),
                       Candle():open(12036):high(12051):low(12003):close(12019),
                       Candle():open(12018):high(12116):low(11973):close(12086),
                       Candle():open(12088):high(12191):low(12088):close(12171),
                       Candle():open(12171):high(12260):low(12171):close(12221),
                       Candle():open(12221):high(12273):low(12198):close(12198),
                       Candle():open(12194):high(12285):low(12174):close(12279),
                       Candle():open(12280):high(12383):low(12280):close(12351),
                       Candle():open(12351):high(12382):low(12319):close(12320),
                       Candle():open(12321):high(12420):low(12321):close(12377),
                       Candle():open(12375):high(12407):low(12369):close(12400),
                       Candle():open(12402):high(12438):low(12353):close(12394),
                       Candle():open(12387):high(12451):low(12387):close(12427),
                       Candle():open(12426):high(12441):low(12328):close(12409),
                       Candle():open(11945):high(12012):low(11918):close(11953),
                       Candle():open(11951):high(12121):low(11951):close(12076),
                       Candle():open(12075):high(12075):low(11863):close(11897),
                       Candle():open(11896):high(11990):low(11876):close(11962),
                       Candle():open(11963):high(12073):low(11963):close(12004),
                       Candle():open(12081):high(12217):low(12081):close(12190),
                       Candle():open(12190):high(12208):low(12106):close(12110),
                       Candle():open(12108):high(12109):low(11875):close(12050),
                       Candle():open(12049):high(12057):low(11925):close(11935),
                       Candle():open(11935):high(12099):low(11934):close(12044),
                       Candle():open(12042):high(12190):low(12042):close(12189),
                       Candle():open(12188):high(12284):low(12176):close(12261),
                       Candle():open(12262):high(12427):low(12262):close(12414),
                       Candle():open(12412):high(12596):low(12404):close(12583),
                       Candle():open(12583):high(12602):low(12541):close(12570),
                       Candle():open(12562):high(12643):low(12539):close(12626),
                       Candle():open(12627):high(12754):low(12627):close(12719),
                       Candle():open(12718):high(12718):low(12567):close(12657),
                       Candle():open(12656):high(12656):low(12470):close(12506),
                       Candle():open(12506):high(12571):low(12447):close(12447),
                       Candle():open(12447):high(12611):low(12447):close(12492),
                       Candle():open(12492):high(12582):low(12414):close(12437),
                       Candle():open(12437):high(12505):low(12406):close(12480),
                       Candle():open(12475):high(12475):low(12296):close(12385),
                       Candle():open(12386):high(12608):low(12386):close(12587),
                       Candle():open(12584):high(12604):low(12547):close(12572),
                       Candle():open(12567):high(12751):low(12567):close(12724),
                       Candle():open(12725):high(12741):low(12644):close(12681),
                       Candle():open(12680):high(12680):low(12536):close(12593),
                       Candle():open(12592):high(12593):low(12489):close(12501),
                       Candle():open(12498):high(12499):low(12290):close(12303),
                       Candle():open(12302):high(12385):low(12227):close(12240),
                       Candle():open(12239):high(12243):low(12083):close(12143),
                       Candle():open(12144):high(12282):low(11998):close(12132),
                       Candle():open(12130):high(12130):low(11866):close(11867),
                       Candle():open(11864):high(11905):low(11700):close(11896),
                       Candle():open(11894):high(11894):low(11372):close(11384),
                       Candle():open(11384):high(11555):low(11139):close(11445),
                       Candle():open(11434):high(11434):low(10810):close(10810),
                       Candle():open(10811):high(11244):low(10604):close(11240),
                       Candle():open(11228):high(11228):low(10686):close(10720),
                       Candle():open(10730):high(11279):low(10730):close(11143),
                       Candle():open(11143):high(11347):low(11142):close(11269),
                       Candle():open(11270):high(11485):low(11270):close(11483),
                       Candle():open(11480):high(11488):low(11293):close(11406),
                       Candle():open(11392):high(11530):low(11322):close(11410),
                       Candle():open(11406):high(11407):low(10882):close(10991),
                       Candle():open(10990):high(11086):low(10801):close(10818),
                       Candle():open(10820):high(11021):low(10820):close(10855),
                       Candle():open(10855):high(11177):low(10854):close(11177),
                       Candle():open(11176):high(11332):low(11113):close(11321),
                       Candle():open(11321):high(11406):low(11107):close(11150),
                       Candle():open(11145):high(11326):low(10929):close(11285),
                       Candle():open(11287):high(11542):low(11287):close(11539),
                       Candle():open(11532):high(11630):low(11429):close(11560),
                       Candle():open(11560):high(11713):low(11528):close(11614),
                       Candle():open(11613):high(11717):low(11488):close(11494),
                       Candle():open(11492):high(11492):low(11211):close(11240),
                       Candle():open(11237):high(11237):low(10933):close(11139),
                       Candle():open(11138):high(11415):low(11138):close(11415),
                       Candle():open(11415):high(11477):low(11284):close(11296),
                       Candle():open(11295):high(11295):low(10936):close(10992),
                       Candle():open(10990):high(11062):low(10825):close(11061),
                       Candle():open(11055):high(11141):low(10987):close(11106),
                       Candle():open(11107):high(11387):low(10994):close(11247),
                       Candle():open(11248):high(11433):low(11247):close(11433),
                       Candle():open(11434):high(11532):low(11407):close(11509),
                       Candle():open(11507):high(11507):low(11255):close(11401),
                       Candle():open(11401):high(11550):low(11374):close(11409),
                       Candle():open(11409):high(11448):low(11117):close(11125),
                       Candle():open(11122):high(11122):low(10597):close(10734),
                       Candle():open(10733):high(10808):low(10639):close(10771),
                       Candle():open(10772):high(11057):low(10772):close(11044),
                       Candle():open(11045):high(11369):low(11045):close(11191),
                       Candle():open(11189):high(11317):low(10997):close(11011),
                       Candle():open(11013):high(11271):low(10965):close(11154),
                       Candle():open(11152):high(11152):low(10910):close(10913),
                       Candle():open(10912):high(10979):low(10653):close(10655),
                       Candle():open(10651):high(10825):low(10404):close(10809),
                       Candle():open(10800):high(10951):low(10738):close(10940),
                       Candle():open(10940):high(11133):low(10859):close(11123),
                       Candle():open(11123):high(11232):low(11051):close(11103),
                       Candle():open(11105):high(11433):low(11105):close(11433),
                       Candle():open(11433):high(11448):low(11366):close(11416),
                       Candle():open(11417):high(11625):low(11417):close(11519),
                       Candle():open(11518):high(11518):low(11378):close(11478),
                       Candle():open(11479):high(11647):low(11479):close(11644),
                       Candle():open(11643):high(11643):low(11378):close(11397),
                       Candle():open(11396):high(11653):low(11296):close(11577),
                       Candle():open(11578):high(11634):low(11469):close(11505),
                       Candle():open(11502):high(11581):low(11391):close(11542),
                       Candle():open(11543):high(11812):low(11543):close(11809),
                       Candle():open(11808):high(11941):low(11806):close(11914),
                       Candle():open(11913):high(11913):low(11683):close(11707),
                       Candle():open(11708):high(11891):low(11694):close(11869),
                       Candle():open(11872):high(12284):low(11872):close(12209),
                       Candle():open(12207):high(12252):low(12164):close(12231),
                       Candle():open(12229):high(12229):low(11954):close(11955),
                       Candle():open(11952):high(11952):low(11630):close(11658),
                       Candle():open(11658):high(11877):low(11658):close(11836),
                       Candle():open(11836):high(12066):low(11835):close(12044),
                       Candle():open(12043):high(12043):low(11850):close(11983),
                       Candle():open(11983):high(12074):low(11881):close(12068),
                       Candle():open(12056):high(12188):low(12002):close(12170),
                       Candle():open(12166):high(12166):low(11737):close(11781),
                       Candle():open(11780):high(11961):low(11780):close(11894),
                       Candle():open(11896):high(12180):low(11896):close(12154),
                       Candle():open(12153):high(12171):low(12027):close(12079),
                       Candle():open(12078):high(12165):low(12001):close(12096),
                       Candle():open(12085):high(12109):low(11891):close(11906)}

        local expected = {58.92, 37.66, 58.06, 87.14, 75.84, 96.93, 90.66, 80.84, 76.33, 83.72, 98.98, 96.36, 87.28,
                          84.48, 36.54, 95.45, 93.36, 93.04, 99.90, 90.84, 97.81, 94.75, 89.08, 93.45, 86.94, 54.03,
                          89.75, 91.27, 17.09, 12.98, 20.98, 36.22, 59.80, 26.90, 30.06, 90.58, 27.00, 74.02, 73.53,
                          16.03, 33.62, 26.59, 34.72, 8.81, 41.22, 62.27, 92.01, 88.59, 93.99, 95.02, 90.19, 75.01,
                          97.95, 88.90, 70.04, 82.54, 92.01, 72.01, 81.67, 68.10, 6.60, 29.70, 5.90, 17.13, 54.92,
                          92.30, 69.66, 51.13, 17.42, 49.25, 94.21, 94.39, 97.46, 97.98, 94.29, 96.32, 93.01, 72.36,
                          12.50, 0.00, 14.57, 7.48, 29.49, 28.25, 92.50, 88.55, 94.06, 84.56, 56.60, 4.67, 2.79, 2.58,
                          10.02, 22.58, 0.17, 28.65, 1.27, 26.73, 0.00, 48.87, 8.98, 56.68, 80.11, 99.81, 89.76, 85.06,
                          16.82, 2.23, 7.31, 51.54, 85.82, 57.59, 79.21, 99.63, 90.00, 87.35, 71.65, 5.72, 26.36, 61.50,
                          46.32, 10.65, 36.22, 43.08, 64.67, 99.96, 96.70, 75.89, 74.56, 1.75, 14.34, 18.29, 46.87,
                          69.77, 53.58, 70.53, 23.70, 0.27, 44.29, 61.79, 96.11, 84.42, 99.99, 95.55, 86.11, 74.37,
                          99.57, 11.14, 78.78, 58.47, 68.89, 99.29, 95.79, 57.40, 86.95, 89.78, 91.16, 45.28, 4.27,
                          31.49, 66.64, 58.94, 98.64, 96.72, 9.77, 34.81, 92.49, 75.91, 81.13, 31.44}
        local faststochastic = FastStochastic(5):add(input)
        assert.are.approx_same_series(expected, faststochastic:series())
    end)

    it("add() series() #fast2", function()
        local faststochastic = FastStochastic(5)
        faststochastic:add(Candle():open(11577):high(11711):low(11577):close(11671),
            Candle():open(11671):high(11698):low(11636):close(11691),
            Candle():open(11689):high(11743):low(11653):close(11723),
            Candle():open(11717):high(11737):low(11667):close(11697),
            Candle():open(11697):high(11727):low(11600):close(11675),
            Candle():open(11672):high(11677):low(11574):close(11637),
            Candle():open(11639):high(11704):low(11635):close(11672),
            Candle():open(11674):high(11782):low(11674):close(11755),
            Candle():open(11754):high(11757):low(11701):close(11732),
            Candle():open(11732):high(11794):low(11699):close(11787),
            Candle():open(11784):high(11859):low(11778):close(11838),
            Candle():open(11834):high(11861):low(11798):close(11825))

        local expected = {58.92, 37.66, 58.06, 87.14, 75.84, 96.93, 90.66, 80.84}
        assert.are.approx_same_series(expected, faststochastic:series())
    end)

    it("#fast3 and reset()", function()
        -- test data from https://www.tradingcampus.in/wp-content/uploads/2019/04/Stochastic-Oscillator.xlsx

        local input = {Candle():open(1555.25):high(1565.55):low(1548.19):close(1562.5),
                       Candle():open(1562.5):high(1579.58):low(1562.5):close(1578.78),
                       Candle():open(1578.78):high(1583):low(1575.8):close(1578.79),
                       Candle():open(1578.93):high(1592.64):low(1578.93):close(1585.16),
                       Candle():open(1585.16):high(1585.78):low(1577.56):close(1582.24),
                       Candle():open(1582.34):high(1596.65):low(1582.34):close(1593.61),
                       Candle():open(1593.58):high(1597.57):low(1586.5):close(1597.57),
                       Candle():open(1597.55):high(1597.55):low(1581.28):close(1582.7),
                       Candle():open(1582.77):high(1598.6):low(1582.77):close(1597.59),
                       Candle():open(1597.6):high(1618.46):low(1597.6):close(1614.42),
                       Candle():open(1614.4):high(1619.77):low(1614.21):close(1617.5),
                       Candle():open(1617.55):high(1626.03):low(1616.64):close(1625.96),
                       Candle():open(1625.95):high(1632.78):low(1622.7):close(1632.69),
                       Candle():open(1632.69):high(1635.01):low(1623.09):close(1626.67),
                       Candle():open(1626.69):high(1633.7):low(1623.71):close(1633.7),
                       Candle():open(1632.1):high(1636):low(1626.74):close(1633.77),
                       Candle():open(1633.75):high(1651.1):low(1633.75):close(1650.34),
                       Candle():open(1649.13):high(1661.49):low(1646.68):close(1658.78),
                       Candle():open(1658.07):high(1660.51):low(1648.6):close(1650.47),
                       Candle():open(1652.45):high(1667.47):low(1652.45):close(1667.47),
                       Candle():open(1665.71):high(1672.84):low(1663.52):close(1666.29),
                       Candle():open(1666.2):high(1674.93):low(1662.67):close(1669.16),
                       Candle():open(1669.39):high(1687.18):low(1648.86):close(1655.35),
                       Candle():open(1651.62):high(1655.5):low(1635.53):close(1650.51),
                       Candle():open(1646.67):high(1649.78):low(1636.88):close(1649.6),
                       Candle():open(1652.63):high(1674.21):low(1652.63):close(1660.06),
                       Candle():open(1656.57):high(1656.57):low(1640.05):close(1648.36),
                       Candle():open(1649.14):high(1661.91):low(1648.61):close(1654.41),
                       Candle():open(1652.13):high(1658.99):low(1630.74):close(1630.74),
                       Candle():open(1631.71):high(1640.42):low(1622.72):close(1640.42),
                       Candle():open(1640.73):high(1646.53):low(1623.62):close(1631.38),
                       Candle():open(1629.05):high(1629.31):low(1607.09):close(1608.9),
                       Candle():open(1609.29):high(1622.56):low(1598.23):close(1622.56),
                       Candle():open(1625.27):high(1644.4):low(1625.27):close(1643.38),
                       Candle():open(1644.67):high(1648.69):low(1639.26):close(1642.81),
                       Candle():open(1638.64):high(1640.13):low(1622.92):close(1626.13),
                       Candle():open(1629.94):high(1637.71):low(1610.92):close(1612.52),
                       Candle():open(1612.15):high(1639.25):low(1608.07):close(1636.36),
                       Candle():open(1635.52):high(1640.8):low(1623.96):close(1626.73),
                       Candle():open(1630.64):high(1646.5):low(1630.34):close(1639.04),
                       Candle():open(1639.77):high(1654.19):low(1639.77):close(1651.81),
                       Candle():open(1651.83):high(1652.45):low(1628.91):close(1628.93),
                       Candle():open(1624.62):high(1624.62):low(1584.32):close(1588.19),
                       Candle():open(1588.62):high(1599.19):low(1577.7):close(1592.43),
                       Candle():open(1588.77):high(1588.77):low(1560.33):close(1573.09),
                       Candle():open(1577.52):high(1593.79):low(1577.09):close(1588.03),
                       Candle():open(1592.27):high(1606.83):low(1592.27):close(1603.26),
                       Candle():open(1606.44):high(1620.07):low(1606.44):close(1613.2),
                       Candle():open(1611.12):high(1615.94):low(1601.06):close(1606.28),
                       Candle():open(1609.78):high(1626.61):low(1609.78):close(1614.96),
                       Candle():open(1614.29):high(1624.26):low(1606.77):close(1614.08),
                       Candle():open(1611.48):high(1618.97):low(1604.57):close(1615.41),
                       Candle():open(1618.65):high(1632.07):low(1614.71):close(1631.89),
                       Candle():open(1634.2):high(1644.68):low(1634.2):close(1640.46),
                       Candle():open(1642.89):high(1654.18):low(1642.89):close(1652.32),
                       Candle():open(1651.56):high(1657.92):low(1647.66):close(1652.62),
                       Candle():open(1657.41):high(1676.63):low(1657.41):close(1675.02),
                       Candle():open(1675.26):high(1680.19):low(1672.33):close(1680.19),
                       Candle():open(1679.59):high(1684.51):low(1677.89):close(1682.5),
                       Candle():open(1682.7):high(1683.73):low(1671.84):close(1676.26),
                       Candle():open(1677.91):high(1684.75):low(1677.91):close(1680.91),
                       Candle():open(1681.05):high(1693.12):low(1681.05):close(1689.37),
                       Candle():open(1686.15):high(1692.09):low(1684.08):close(1692.09),
                       Candle():open(1694.41):high(1697.61):low(1690.67):close(1695.53),
                       Candle():open(1696.63):high(1698.78):low(1691.13):close(1692.39),
                       Candle():open(1696.06):high(1698.38):low(1682.57):close(1685.94),
                       Candle():open(1685.21):high(1690.94):low(1680.07):close(1690.25),
                       Candle():open(1687.31):high(1691.85):low(1676.03):close(1691.65),
                       Candle():open(1690.32):high(1690.92):low(1681.86):close(1685.33),
                       Candle():open(1687.92):high(1693.19):low(1682.42):close(1685.96),
                       Candle():open(1687.76):high(1698.43):low(1684.94):close(1685.73),
                       Candle():open(1689.42):high(1707.85):low(1689.42):close(1706.87),
                       Candle():open(1706.1):high(1709.67):low(1700.68):close(1709.67),
                       Candle():open(1708.01):high(1709.24):low(1703.55):close(1707.14),
                       Candle():open(1705.79):high(1705.79):low(1693.29):close(1697.37),
                       Candle():open(1695.3):high(1695.3):low(1684.91):close(1690.91),
                       Candle():open(1693.35):high(1700.18):low(1688.38):close(1697.48),
                       Candle():open(1696.1):high(1699.42):low(1686.02):close(1691.42),
                       Candle():open(1688.37):high(1691.49):low(1683.35):close(1689.47),
                       Candle():open(1690.65):high(1696.81):low(1682.62):close(1694.16),
                       Candle():open(1693.88):high(1695.52):low(1684.83):close(1685.39),
                       Candle():open(1679.61):high(1679.61):low(1658.59):close(1661.32),
                       Candle():open(1661.22):high(1663.6):low(1652.61):close(1655.83),
                       Candle():open(1655.25):high(1659.18):low(1645.84):close(1646.06),
                       Candle():open(1646.81):high(1658.92):low(1646.08):close(1652.35),
                       Candle():open(1650.66):high(1656.99):low(1639.43):close(1642.8),
                       Candle():open(1645.03):high(1659.55):low(1645.03):close(1656.96),
                       Candle():open(1659.92):high(1664.85):low(1654.81):close(1663.5),
                       Candle():open(1664.29):high(1669.51):low(1656.02):close(1656.78),
                       Candle():open(1652.54):high(1652.54):low(1629.05):close(1630.48),
                       Candle():open(1630.25):high(1641.18):low(1627.47):close(1634.96),
                       Candle():open(1633.5):high(1646.41):low(1630.88):close(1638.17),
                       Candle():open(1638.89):high(1640.08):low(1628.05):close(1632.97),
                       Candle():open(1635.95):high(1651.35):low(1633.41):close(1639.77),
                       Candle():open(1640.72):high(1655.72):low(1637.41):close(1653.08),
                       Candle():open(1653.28):high(1659.17):low(1653.07):close(1655.08),
                       Candle():open(1657.44):high(1664.83):low(1640.62):close(1655.17),
                       Candle():open(1656.85):high(1672.4):low(1656.85):close(1671.71),
                       Candle():open(1675.11):high(1684.09):low(1675.11):close(1683.99),
                       Candle():open(1681.04):high(1689.13):low(1678.7):close(1689.13),
                       Candle():open(1689.21):high(1689.97):low(1681.96):close(1683.42),
                       Candle():open(1685.04):high(1688.73):low(1682.22):close(1687.99),
                       Candle():open(1691.7):high(1704.95):low(1691.7):close(1697.6),
                       Candle():open(1697.73):high(1705.52):low(1697.73):close(1704.76),
                       Candle():open(1705.74):high(1729.44):low(1700.35):close(1725.52),
                       Candle():open(1727.34):high(1729.86):low(1720.2):close(1722.34),
                       Candle():open(1722.44):high(1725.23):low(1708.89):close(1709.91)}

        local expected = {90.3939184519697, 98.1933526410151, 96.2956810631229, 98.9665488169704, 96.7711187894674,
                          86.261064705149, 100, 92.8462210572303, 93.7391493055556, 64.4675150703281, 49.7464711525284,
                          46.7252622625458, 57.9404466501239, 39.4289280699016, 48.3693083346463, 6.61813368630046,
                          27.4588892336333, 13.4346881787156, 2.25995754775898, 27.3524451939291, 50.7588532883643,
                          50.1180438448566, 31.3659359190557, 18.8075809423532, 50.1842590155302, 37.5098710186891,
                          64.0860552763818, 84.1394472361807, 50.5266622778144, 5.53885787891815, 19.2574192704929,
                          13.5947155337737, 29.5120392073301, 45.7383336884722, 56.3285744726188, 48.9558917536757,
                          58.2037076496911, 57.2661410611548, 58.683145109738, 76.2412103132326, 85.3718303856808,
                          98.0181140117207, 94.5691156880826, 98.6156491831469, 100, 98.1288400670266, 91.0559410234172,
                          95.4116381885531, 95.9265696285032, 98.8368153585545, 97.7644024075667, 93.2172805434669,
                          84.7270132032831, 86.791576339424, 87.2427983539096, 73.6893583724568, 69.0113608895336,
                          51.5590200445437, 97.2785337406276, 100, 92.4791914387635, 63.4363852556476, 44.2330558858504,
                          63.7633769322235, 45.7491082045186, 39.9524375743163, 53.8941736028539, 27.8240190249706,
                          5.34455755677371, 5.64318261479148, 0.344665517781649, 10.1989660034466, 4.79783599088823,
                          25.1110156138089, 36.2718505123568, 28.5596707818929, 2.01040348657397, 10.4100069492703,
                          15.4312085376407, 7.93192962215173, 18.0749448934606, 49.1177598772535, 65.6755470980017,
                          65.8896289248337, 98.4642777654127, 99.823383963264, 100, 89.5200000000001, 96.832,
                          90.5136809499224, 99.026265214606, 96.1337410000986, 92.6136921716924, 79.3157076205289}

        local faststochastic = FastStochastic()
        faststochastic:add(input)
        assert.are.approx_same_series(expected, faststochastic:series())

        faststochastic:reset()
        assert.are.same(0, #faststochastic:series())
        assert.are.same(0, #faststochastic.lows)
        assert.are.same(0, #faststochastic.highs)

        assert.are.same(14, faststochastic.period)
        assert.falsy(faststochastic:last())

        faststochastic.period = 5 -- hack 
        faststochastic:add(Candle():open(11577):high(11711):low(11577):close(11671),
            Candle():open(11671):high(11698):low(11636):close(11691),
            Candle():open(11689):high(11743):low(11653):close(11723),
            Candle():open(11717):high(11737):low(11667):close(11697),
            Candle():open(11697):high(11727):low(11600):close(11675),
            Candle():open(11672):high(11677):low(11574):close(11637),
            Candle():open(11639):high(11704):low(11635):close(11672),
            Candle():open(11674):high(11782):low(11674):close(11755),
            Candle():open(11754):high(11757):low(11701):close(11732),
            Candle():open(11732):high(11794):low(11699):close(11787),
            Candle():open(11784):high(11859):low(11778):close(11838),
            Candle():open(11834):high(11861):low(11798):close(11825))

        expected = {58.92, 37.66, 58.06, 87.14, 75.84, 96.93, 90.66, 80.84}
        assert.are.approx_same_series(expected, faststochastic:series())
    end)
end)