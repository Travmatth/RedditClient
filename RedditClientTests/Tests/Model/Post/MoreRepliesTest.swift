//
//  MoreRepliesTest.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/16/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import XCTest

class MoreRepliesTest: XCTestCase {
    
    
    var testData: NSData!
    var testJsonArray: [AnyObject]!
    var testJsonDictionary: [String: AnyObject]!
    
    var bundle: NSBundle!
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        bundle =  NSBundle(forClass: self.dynamicType)
    }
    
    func testMoreReplies() {
        //WHEN
        let sampleJson: String! = bundle.pathForResource("MoreSample", ofType: nil)
        
        do {
            testData = try NSData(contentsOfFile: sampleJson, options: NSDataReadingOptions.DataReadingMappedIfSafe )
            if testData == nil { fatalError("ParseCommentTestSample could not be read into data") }
            testJsonDictionary = try NSJSONSerialization.JSONObjectWithData(testData, options: NSJSONReadingOptions.MutableContainers) as! [String:AnyObject]
            if testData == nil { fatalError("ParseCommentTestSample could not be read into json") }
        }
        catch let error {
            print("\(error)")
        }
        
        //THEN
        let parentId = "t3_3wn5jz"
        let id = "cxxi1id"
        let count = 1862
        let name = "t1_cxxi1id"
        let children = ["cxxi1id", "cxxiq5u", "cxxhljj", "cxxj1ph", "cxxl3b9", "cxxhu6b", "cxxji7t", "cxxlu16", "cxxle5x", "cxxjgfe", "cxxhbav", "cxxhxpq", "cxxjn5p", "cxxjon6", "cxxio84", "cxxjvs1", "cxxhilf", "cxxn5qu", "cxxk5vc", "cxxk7u0", "cxxnuoi", "cxxi7rm", "cxxhp4x", "cxxiabw", "cxxks8z", "cxxic41", "cxxl45w", "cxxlfu0", "cxxjf7m", "cxxljzz", "cxxigxl", "cxxjgy3", "cxxlxe8", "cxxjmct", "cxxjmdn", "cxxim9l", "cxxma43", "cxxjqqb", "cxxjss5", "cxxjvi3", "cxxmw80", "cxxipwc", "cxxiqh8", "cxxi23y", "cxxi3xy", "cxxk5ip", "cxxk9ij", "cxxj1l6", "cxxizre", "cxxj0m6", "cxxkpeb", "cxxj1i3", "cxxkraz", "cxxks66", "cxxj4ry", "cxxj55o", "cxxguxm", "cxxibun", "cxxkyr7", "cxxl2q6", "cxxic2l", "cxxj919", "cxxqwgg", "cxxr66z", "cxxre87", "cxxrf0z", "cxxjc76", "cxxif0n", "cxxh41l", "cxxrxup", "cxxlgot", "cxxs2fu", "cxxs8o8", "cxxsbly", "cxxjfxs", "cxxloaw", "cxxlq71", "cxxjhku", "cxxiijm", "cxxlt9j", "cxxltjj", "cxxij6d", "cxxluaj", "cxxm0yh", "cxxila5", "cxxm2y0", "cxxhcv9", "cxxm5tt", "cxxm7cs", "cxxm80h", "cxxjojb", "cxxmb9z", "cxxjr4v", "cxxmhiq", "cxxmlkj", "cxxionj", "cxxipah", "cxxn022", "cxxjyxa", "cxxn4bu", "cxxk29r", "cxxngbp", "cxxnitw", "cxxk5qc", "cxxnmat", "cxxit4n", "cxxk9ix", "cxxi4ex", "cxxkcl6", "cxxkgag", "cxxgyxv", "cxxivpn", "cxxkgw1", "cxxi73x", "cxxkhw4", "cxxiw56", "cxxos3b", "cxxiwg2", "cxxixg7", "cxxizqk", "cxxkobw", "cxxhp5a", "cxxkp9s", "cxxpcwt", "cxxkpqa", "cxxkqfz", "cxxkqng", "cxxj2q3", "cxxplkw", "cxxpn90", "cxxj3w0", "cxxksgp", "cxxksti", "cxxj4za", "cxxq724", "cxxkxu6", "cxxh2q9", "cxxkxv8", "cxxqage", "cxxkzo3", "cxxl0el", "cxxl1pt", "cxxj751", "cxxqr37", "cxxqtlt", "cxxqwiv", "cxxl57o", "cxxr0xj", "cxxr2kg", "cxxr58x", "cxxr2k0", "cxxiesn", "cxxl8x8", "cxxhata", "cxxla7p", "cxxjdcc", "cxxjdj8", "cxxrso1", "cxxrurx", "cxxje5y", "cxxje83", "cxxrzxt", "cxxlfvw", "cxxjevj", "cxxs4on", "cxxs5ny", "cxxs807", "cxxjfbi", "cxxjfd9", "cxxlkbz", "cxxll2c", "cxxihhz", "cxxjg6f", "cxxsydg", "cxxt5bu", "cxxloms", "cxxt7pq", "cxxtbih", "cxxlqbl", "cxxlqhq", "cxxlqoe", "cxxlrxd", "cxxjhz0", "cxxlsj5", "cxxiivq", "cxxltmq", "cxxjjaj", "cxxjj9d", "cxxlv79", "cxxlvyb", "cxxjldg", "cxxjlwq", "cxxm1nc", "cxxikz4", "cxxjn6z", "cxxm4sq", "cxxjof7", "cxximgd", "cxxm9li", "cxxmacb", "cxxmazx", "cxximi4", "cxxmknc", "cxxio9l", "cxxmmbf", "cxxmowa", "cxxjuta", "cxxiou9", "cxxiozc", "cxxi1m5", "cxxippw", "cxxjymn", "cxxjynz", "cxxjzm8", "cxxn4zn", "cxxiqim", "cxxn67b", "cxxk09g", "cxxn6zo", "cxxnaf9", "cxxnch0", "cxxk3i5", "cxxk350", "cxxk4qf", "cxxnjs8", "cxxnndv", "cxxhlem", "cxxiul2", "cxxnxmd", "cxxkcux", "cxxkdew", "cxxkf0y", "cxxiviq", "cxxkfkk", "cxxoe8a", "cxxivwe", "cxxofqt", "cxxi6tr", "cxxojf6", "cxxkikp", "cxxiwe3", "cxxkj2v", "cxxfybp", "cxxixyu", "cxxko3g", "cxxknp4", "cxxkoq2", "cxxpbyb", "cxxpfdn", "cxxpfqf", "cxxpg6j", "cxxpgah", "cxxpgqn", "cxxph24", "cxxphcr", "cxxkqpf", "cxxg2t3", "cxxpmrm", "cxxkrk7", "cxxpqmo", "cxxpvea", "cxxpxfm", "cxxpya2", "cxxpzgv", "cxxksxc", "cxxib8a", "cxxq1nl", "cxxj579", "cxxkuky", "cxxq6jp", "cxxj6ko", "cxxqbp6", "cxxqdwy", "cxxj79u", "cxxl1kh", "cxxqesv", "cxxqlj9", "cxxl2ej", "cxxqrf3", "cxxj8dw", "cxxqux0", "cxxl4mx", "cxxl4yc", "cxxqyi7", "cxxjahx", "cxxr4xs", "cxxl5c6", "cxxr369", "cxxr4v7", "cxxr5pu", "cxxl6u8", "cxxr897", "cxxl7gk", "cxxrdwc", "cxxgt80", "cxxjbqp", "cxxrefr", "cxxjc44", "cxxl9bs", "cxxrkz0", "cxxrl25", "cxxlal4", "cxxross", "cxxlc7c", "cxxrpd0", "cxxlcod", "cxxlctp", "cxxje2x", "cxxrv2b", "cxxrv44", "cxxiglz", "cxxs0wh", "cxxs24w", "cxxlh2y", "cxxs4mw", "cxxlhg7", "cxxs5d6", "cxxlhyp", "cxxlim7", "cxxsf0q", "cxxjfgr", "cxxlkud", "cxxjfuc", "cxxsn86", "cxxsr07", "cxxsw3f", "cxxswxd", "cxxszaw", "cxxhx2j", "cxxlo5r", "cxxt4wj", "cxxjgl8", "cxxt76t", "cxxjgm4", "cxxt8gx", "cxxtdcb", "cxxls6b", "cxxtp51", "cxxls6h", "cxxjikq", "cxxu75b", "cxxkuek", "cxxlulk", "cxxij1g", "cxxlwz2", "cxxhzg9", "cxxm17h", "cxxm1sz", "cxxjoa5", "cxxm82r", "cxxi0c9", "cxxmam0", "cxxjqdn", "cxxjq2n", "cxximqh", "cxxmff8", "cxxmcvd", "cxxmfk8", "cxxi10l", "cxxjr7v", "cxxjrwp", "cxxm5am", "cxxmibw", "cxxinbp", "cxxmjmx", "cxxmke8", "cxxmkvz", "cxxjt76", "cxxmmjk", "cxxgycd", "cxxjuo9", "cxxmpos", "cxxmpyj", "cxxmqdg", "cxxmred", "cxxmumv", "cxxjwav", "cxxip6o", "cxxjx7p", "cxxjxbe", "cxxmvlp", "cxxn2gh", "cxxn3ur", "cxxn4xh", "cxxjzxj", "cxxjzv4", "cxxn660", "cxxn66j", "cxxk0mp", "cxxn73n", "cxxk12l", "cxxiqr2", "cxxnd1u", "cxxirwr", "cxxir7f", "cxxnjn8", "cxxit4g", "cxxnmva", "cxxnsb2", "cxxiyu4", "cxxnvge", "cxxiv0a", "cxxnyok", "cxxo1vb", "cxxkfi3", "cxxkg2s", "cxxoat4", "cxxi6s2", "cxxkmne", "cxxix5w", "cxxod5c", "cxxh02p", "cxxkhl5", "cxxoff7", "cxxkhm1", "cxxogyc", "cxxkihc", "cxxiw8r", "cxxok0k", "cxxokpv", "cxxomaf", "cxxoomu", "cxxkj2e", "cxxot10", "cxxot3j", "cxxkk0t", "cxxr3o4", "cxxp0zo", "cxxp1qw", "cxxkmxa", "cxxkmyq", "cxxkno9", "cxxp6nj", "cxxko71", "cxxi96f", "cxxp8bt", "cxxkos3", "cxxkoy8", "cxxp94h", "cxxp95a", "cxxpb51", "cxxia3p", "cxxhqhn", "cxxphcq", "cxxphni", "cxxphxk", "cxxkqxt", "cxxphzp", "cxxpipb", "cxxpiu6", "cxxkrcm", "cxxpjkn", "cxxpknt", "cxxib59", "cxxkrdf", "cxxpq71", "cxxj4a3", "cxxkrlp", "cxxpqep", "cxxps28", "cxxpsaq", "cxxhr0x", "cxxpw34", "cxxpxu7", "cxxibdz", "cxxktit", "cxxq1eb", "cxxq0ir", "cxxq1fz", "cxxkt2y", "cxxku92", "cxxq2fq", "cxxq2wv", "cxxj568", "cxxq3xc", "cxxq44t", "cxxq49s", "cxxq4fx", "cxxq4rp", "cxxq6ym", "cxxq6zj", "cxxky6v", "cxxq9a7", "cxxlxel", "cxxqanr", "cxxqb95", "cxxqbe4", "cxxj6s6", "cxxqc4i", "cxxt0h6", "cxxqe2l", "cxxhsxi", "cxxqec4", "cxxqeeo", "cxxqeqg", "cxxqtpi", "cxxl1s3", "cxxqgfy", "cxxqgry", "cxxqh5k", "cxxl2gs", "cxxqp4e", "cxxqn3x", "cxxqpx5", "cxxj8bs", "cxxl3we", "cxxj9q1", "cxxie5x", "cxxqw9n", "cxxqwe6", "cxxqwed", "cxxj8q6", "cxxhta2", "cxxqwl6", "cxxl5nr", "cxxr168", "cxxl5ry", "cxxiee6", "cxxl6bf", "cxxl6lx", "cxxhtn1", "cxxr7oq", "cxxjbfg", "cxxjw18", "cxxjbiz", "cxxr8r8", "cxxr9jt", "cxxl7i0", "cxxr9nn", "cxxrbnw", "cxxrcxn", "cxxl8l7", "cxxrenb", "cxxrfkz", "cxxkgj7", "cxxrgem", "cxxl9m0", "cxxrkkx", "cxxo0ln", "cxxrl8o", "cxxrlfs", "cxxrme2", "cxxroxd", "cxxrpwc", "cxxrqo2", "cxxrr5z", "cxxld8y", "cxxldcz", "cxxrvdh", "cxxrwco", "cxxlfmm", "cxxrwo0", "cxxrwsm", "cxxrx1q", "cxxlfv9", "cxxry10", "cxxrz1r", "cxxhukn", "cxxlibf", "cxxs8ip", "cxxsbro", "cxxsc65", "cxxsdts", "cxxse6p", "cxxigpn", "cxxlksj", "cxxshlh", "cxxsi7a", "cxxsji2", "cxxsjvb", "cxxslzx", "cxxsosz", "cxxllbu", "cxxsp3l", "cxxspka", "cxxllg1", "cxxsqsn", "cxxllqo", "cxxsr9h", "cxxllyk", "cxxswgp", "cxxntso", "cxxihlj", "cxxsxfw", "cxxlma6", "cxxlme6", "cxxlmga", "cxxt1m0", "cxxt2gw", "cxxjjl5", "cxxt44c", "cxxhx53", "cxxt44p", "cxxt4i9", "cxxlo96", "cxxt6f7", "cxxlods", "cxxihmd", "cxxtb9u", "cxxtbog", "cxxtcz7", "cxxihyt", "cxxte35", "cxxo38e", "cxxte8x", "cxxtjdu", "cxxtf8g", "cxxhc0z", "cxxtnvz", "cxxtoba", "cxxlt4w", "cxxtssy", "cxxtwzr", "cxxtyhl", "cxxtyjw", "cxxtztx", "cxxu0f5", "cxxu0rb", "cxxu16v", "cxxu6qn", "cxxjj5i", "cxxhcev", "cxxlu9i", "cxxlug7", "cxxik6e", "cxxluy8", "cxxpzho", "cxxob97", "cxxly50", "cxxjlw2", "cxxikbc", "cxxlzpd", "cxxu7km", "cxxm09w", "cxxjmad", "cxxm0h5", "cxxmso0", "cxxhzvd", "cxxilla", "cxxm2al", "cxxm2fg", "cxxm2qh", "cxxm3pn", "cxxm3sq", "cxxm4qc", "cxxjn8u", "cxxofab", "cxxm6sz", "cxxgxiy", "cxxm7j4", "cxxm8pv", "cxximcm", "cxxm8qq", "cxxm9l7", "cxxjpg2", "cxxjpch", "cxxhzxz", "cxxmc8c", "cxxjqt3", "cxxi0r3", "cxxmg0a", "cxxmg4t", "cxxp3g8", "cxxmg96", "cxxmh05", "cxxmiz8", "cxxjsng", "cxxmkgl", "cxxhfuv", "cxxmlwr", "cxxjuel", "cxxmmmi", "cxxmnma", "cxxmq7q", "cxxms5u", "cxxjvtj", "cxxmspx", "cxxmssr", "cxxmuqr", "cxxmv2l", "cxxmy05", "cxxmyna", "cxxp90h", "cxxmyqw", "cxxjyhn", "cxxn0ru", "cxxn2fp", "cxxn2n7", "cxxn3ya", "cxxjz0k", "cxxn4f2", "cxxn4le", "cxxi1z0", "cxxn55p", "cxxnlw5", "cxxrkmo", "cxxgrbb", "cxxn6wb", "cxxi22l", "cxxk213", "cxxnars", "cxxnaz6", "cxxnbih", "cxxnbsg", "cxxnc9c", "cxxhj4l", "cxxnf8g", "cxxnfhc", "cxxi7wc", "cxxngws", "cxxnh57", "cxxnib1", "cxxniic", "cxxirzc", "cxxnkv1", "cxxnmdw", "cxxnmmn", "cxxno3t", "cxxno4l", "cxxiu8c", "cxxnqt2", "cxxno9f", "cxxka0s", "cxxnrfs", "cxxnsh0", "cxxkaew", "cxxntla", "cxxkbs4", "cxxiucr", "cxxkc4g", "cxxnwbp", "cxxnx8c", "cxxny8a", "cxxi6pe", "cxxnya9", "cxxiv8f", "cxxo286", "cxxo7d7", "cxxo859", "cxxoads", "cxxoalr", "cxxivor", "cxxocnq", "cxxocqr", "cxxodzd", "cxxoekm", "cxxofnv", "cxxofu4", "cxxkicf", "cxxog69", "cxxog8k", "cxxono3", "cxxoh7t", "cxxkios", "cxxok96", "cxxkiu1", "cxxi7lg", "cxxolm1", "cxxpztb", "cxxkiw2", "cxxp8q9", "cxxkj6c", "cxxopbn", "cxxory6", "cxxov5j", "cxxkjt8", "cxxozf7", "cxxozio", "cxxozjj", "cxxp01h", "cxxkmn0", "cxxp0cw", "cxxh2pt", "cxxp18f", "cxxp23i", "cxxp3a2", "cxxiyf1", "cxxp4ca", "cxxp4cn", "cxxp4xb", "cxxp54x", "cxxp5pv", "cxxp69d", "cxxp7ld", "cxxp7sf", "cxxp7wa", "cxxp8ad", "cxxp8bm", "cxxi9uj"]
        
        let mut = MoreReplies(json: testJsonDictionary)
        
        XCTAssertEqual(mut.parentId, parentId, "parentId should be correct")
        XCTAssertEqual(mut.id, id, "id should be correct")
        XCTAssertEqual(mut.count, count, "count should be correct")
        XCTAssertEqual(mut.name, name, "name should be correct")
        XCTAssertEqual(mut.children, children, "children should be correct")
    }
}