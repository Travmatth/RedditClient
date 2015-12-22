//
//  RedditPostTest.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/16/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import XCTest

class RedditPostTest: XCTestCase {
    
    var bundle: NSBundle!
    var testData: NSData!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        bundle =  NSBundle(forClass: self.dynamicType)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testComment() {
        //When
        let sampleJson: String! = bundle.pathForResource("SampleRedditPost", ofType: nil)
        
        do {
            testData = try NSData(contentsOfFile: sampleJson, options: NSDataReadingOptions.DataReadingMappedIfSafe )
            if testData == nil { fatalError("testData null") }
        }
        catch let error {
            print("\(error)")
        }
        
        let mut = RedditPost(dataFromNetworking: testData)
        
        //Then (test commentData)
        
        let comment_author = "sammyboi55"
        let comment_body = "Exercise and 5htp supplements work well. "
        let comment_name = "t1_cy13djf"
        let comment_edited = true
        let comment_score = 1
        let comment_ups = 1
        let comment_downs = 10
        let comment_created = 1450310525
        let comment_saved = true
        let comment_subreddit = "leaves"
        let comment_subreddit_id = "t5_2s9i3"
        let comment_id = "cy13djf"
        let comment_link_id = "t3_3x2jpk"
        let comment_parent_id = "t3_3x2jpk"
        let comment_score_hidden = true
        let comment_body_html = "&lt;div class=\"md\"&gt;&lt;p&gt;Exercise and 5htp supplements work well. &lt;/p&gt;\n&lt;/div&gt;"
        let comment_author_flair_css_class = "test"
        let comment_author_flair_text = "test"
        
        /*
        */
        //EXPECT
        let comment = mut?.comments?.tree?.children[0].value
        let test = mut?.comments?.tree?.children[0]
        print("\n test: \(test!.value) \n")
        
        XCTAssertEqual(comment?.author, comment_author, " should be correct")
        XCTAssertEqual(comment?.body, comment_body, " should be correct")
        XCTAssertEqual(comment?.name, comment_name, " should be correct")
        XCTAssertEqual(comment?.edited, comment_edited, " should be correct")
        XCTAssertEqual(comment?.score, comment_score, " should be correct")
        XCTAssertEqual(comment?.ups, comment_ups, " should be correct")
        XCTAssertEqual(comment?.downs, comment_downs, " should be correct")
        XCTAssertEqual(comment?.created, comment_created, " should be correct")
        XCTAssertEqual(comment?.saved, comment_saved, " should be correct")
        XCTAssertEqual(comment?.subreddit, comment_subreddit, " should be correct")
        XCTAssertEqual(comment?.subredditId, comment_subreddit_id, " should be correct")
        XCTAssertEqual(comment?.id, comment_id, " should be correct")
        XCTAssertEqual(comment?.linkId, comment_link_id, " should be correct")
        XCTAssertEqual(comment?.parentId, comment_parent_id, " should be correct")
        XCTAssertEqual(comment?.scoreHidden, comment_score_hidden, " should be correct")
        XCTAssertEqual(comment?.bodyHtml, comment_body_html, " should be correct")
        XCTAssertEqual(comment?.authorFlairText, comment_author_flair_text, " should be correct")
        XCTAssertEqual(comment?.authorFlairCssClass, comment_author_flair_css_class, " should be correct")
   
        //Then (test postData)
        let post_domain = "self.leaves"
        let post_subreddit = "leaves"
        let post_selftext_html = "&lt;!-- SC_OFF --&gt;&lt;div class=\"md\"&gt;&lt;p&gt;I decided to stop smoking for I don&amp;#39;t know how long three days ago.&lt;/p&gt;\n\n&lt;p&gt;The reason I decided to stop was because I felt that everything in my life revolved around the plant. &lt;/p&gt;\n\n&lt;p&gt;I&amp;#39;m at school while im typing this, I would need to work on my classes but there&amp;#39;s no motivation to do anything.. \nYesterday night was horrible, as I didn&amp;#39;t get much sleep. Falling asleep is very hard for me. &lt;/p&gt;\n\n&lt;p&gt;Consider this a shitpost or whatever, I just needed to vent a little bit. &lt;/p&gt;\n&lt;/div&gt;&lt;!-- SC_ON --&gt;"
        let post_selftext = "I decided to stop smoking for I don't know how long three days ago.\n \nThe reason I decided to stop was because I felt that everything in my life revolved around the plant. \n\nI'm at school while im typing this, I would need to work on my classes but there's no motivation to do anything.. \nYesterday night was horrible, as I didn't get much sleep. Falling asleep is very hard for me. \n\nConsider this a shitpost or whatever, I just needed to vent a little bit. \n"
        let post_likes = 10
        let post_suggested_sort = "new"
        let post_link_flair_text = "Website"
        let post_id = "3x2jpk"
        let post_archived = true
        let post_clicked = true
        let post_author = "willekrona"
        //let post_media = "test"
        let post_post_name = "t3_3x2jpk"
        let post_score = 7
        let post_over_18 = true
        let post_hidden = true
        let post_thumbnail = "self"
        let post_subreddit_id = "t5_2s9i3"
        let post_edited = true
        let post_link_flair_css_class = "tutorial"
        let post_author_flair_css_class = "test"
        let post_downs = 10
        let post_saved = true
        let post_stickied = true
        //let post_from = "test"
        let post_is_self = true
        let post_from_id = "test"
        let post_permalink = "/r/leaves/comments/3x2jpk/day_3_this_is_hell/"
        //let post_locked = true
        let post_hide_score = true
        let post_created = 1450296216
        let post_url = "https://www.reddit.com/r/leaves/comments/3x2jpk/day_3_this_is_hell/"
        let post_author_flair_text = "test"
        let post_title = "Day 3, this is hell."
        let post_created_utc = 1450267416
        let post_ups = 7
        let post_upvote_ratio: NSDecimalNumber = 0.89
        let post_num_comments = 12
        let post_visited = true
        
        /*
        */
        
        //Expect (test postData)
        let post = mut?.post
        XCTAssertEqual(post?.domain, post_domain, "Domain should be correct")
        XCTAssertEqual(post?.subreddit, post_subreddit, "Subreddit should be correct")
        XCTAssertEqual(post?.selfTextHtml, post_selftext_html, "selftext_html should be correct")
        XCTAssertEqual(post?.selfText, post_selftext, "selftext should be correct")
        XCTAssertEqual(post?.likes, post_likes, "likes should be correct")
        XCTAssertEqual(post?.sort.rawValue, post_suggested_sort, "suggested_sort should be correct")
        XCTAssertEqual(post?.linkFlairText, post_link_flair_text, "link_flair_text should be correct")
        XCTAssertEqual(post?.id, post_id, "ID should be correct")
        XCTAssertEqual(post?.fromId, post_from_id, "from_kind should be correct")
        XCTAssertEqual(post?.archived, post_archived, "archived should be correct")
        XCTAssertEqual(post?.clicked, post_clicked, "clicked should be correct")
        XCTAssertEqual(post?.author, post_author, "author should be correct")
        XCTAssertEqual(post?.author, post_author, "author should be correct")
        XCTAssertEqual(post?.name, post_post_name, "name should be correct")
        XCTAssertEqual(post?.score, post_score, "score should be correct")
        XCTAssertEqual(post?.nsfw, post_over_18, "nsfw should be correct")
        XCTAssertEqual(post?.hidden, post_hidden, "hidden should be correct")
        XCTAssertEqual(post?.thumbnail, post_thumbnail, "thumbnail should be correct")
        XCTAssertEqual(post?.thumbnail, post_thumbnail, "thumbnail should be correct")
        XCTAssertEqual(post?.subredditId, post_subreddit_id, "subreddit_id should be correct")
        XCTAssertEqual(post?.edited, post_edited, "edited should be correct")
        XCTAssertEqual(post?.linkFlairCssClass, post_link_flair_css_class, "link_flair_css_class should be correct")
        XCTAssertEqual(post?.authorFlairCssClass, post_author_flair_css_class, "author_flair_css_class should be correct")
        XCTAssertEqual(post?.downs, post_downs, "downs should be correct")
        XCTAssertEqual(post?.saved, post_saved, "saved should be correct")
        XCTAssertEqual(post?.stickied, post_stickied, "stickied should be correct")
        XCTAssertEqual(post?.isSelf, post_is_self, "is_self should be correct")
        XCTAssertEqual(post?.isSelf, post_is_self, "is_self should be correct")
        XCTAssertEqual(post?.permalink, post_permalink, "permalink should be correct")
        XCTAssertEqual(post?.hideScore, post_hide_score, "hideScore should be correct")
        XCTAssertEqual(post?.created, post_created, "created should be correct")
        XCTAssertEqual(post?.url, post_url, "url should be correct")
        XCTAssertEqual(post?.authorFlairText, post_author_flair_text, "author_flair_text should be correct")
        XCTAssertEqual(post?.title, post_title, "title should be correct")
        XCTAssertEqual(post?.createdUtc, post_created_utc, "created_utc should be correct")
        XCTAssertEqual(post?.ups, post_ups, "ups should be correct")
        XCTAssertEqual(post?.upvoteRatio, post_upvote_ratio, "upvote_ratio should be correct")
        XCTAssertEqual(post?.numComments, post_num_comments, "num_comments should be correct")
        XCTAssertEqual(post?.visited, post_visited, "visited should be correct")
    }
}
