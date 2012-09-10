require 'test/unit'
require './youtube.rb'

class YoutubeTest < Test::Unit::TestCase
  def setup
    @keyword = "Swirling"
    @results1 = ["http://youtube.com/watch?v=rmSV2l6JFt0"]
    @results3 = ["http://youtube.com/watch?v=rmSV2l6JFt0", "http://youtube.com/watch?v=e8JcW1mO5Tc", "http://youtube.com/watch?v=1cY4LXZqX-w"]
    @results4 = ["http://youtube.com/watch?v=rmSV2l6JFt0", "http://youtube.com/watch?v=e8JcW1mO5Tc", "http://youtube.com/watch?v=1cY4LXZqX-w", "http://youtube.com/watch?v=tCCVzkhWvy0"]
    @yt = Youtube.new
  end

  def test_search_with_1_result
    @yt.search(@keyword, 1)
    assert_equal @results1, @yt.list
  end
  
  def test_search
    @yt.search(@keyword)
    assert_equal @results3, @yt.list
  end

  def test_search_with_4_results
    @yt.search(@keyword, 4)
    assert_equal @results4, @yt.list
  end
end