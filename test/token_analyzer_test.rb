require 'token_analyzer'

class TokenAnalyzerTest < Test::Unit::TestCase

  def setup
    @file = File.open('test/contexts.txt', 'r')
    @file_lines = @file.readlines.length
    @file.rewind
    @ta = TokenAnalyzer.new(@file)
    @expected_ordered_words = [["across", 1], ["birch", 1], ["blue", 1],
      ["came", 1], ["canoe", 1], ["dark", 1], ["faced", 1], ["from", 1],
      ["juice", 1], ["lemons", 1], ["makes", 1], ["rose", 1], ["steady", 1],
      ["sun", 1], ["us", 1], ["work", 1], ["a", 2], ["and", 2],
      ["background", 2], ["flame", 2], ["heat", 2], ["in", 2], ["large", 2],
      ["of", 2], ["size", 2], ["there", 2], ["when", 2], ["the", 3],
      ["-title-", 10]]
  end

  def teardown
    @file.close
  end

  def test_ingestion
    assert_equal @file_lines, @ta.contexts.length
  end

  def test_word_frequency
    expected = {
      "-title-"    => 10, "the"        => 3, "birch"      => 1,
      "canoe"      => 1,  "dark"       => 1, "blue"       => 1,
      "background" => 2,  "juice"      => 1, "of"         => 2,
      "lemons"     => 1,  "makes"      => 1, "steady"     => 1,
      "work"       => 1,  "faced"      => 1, "us"         => 1,
      "a"          => 2,  "large"      => 2, "size"       => 2,
      "in"         => 2,  "there"      => 2, "when"       => 2,
      "sun"        => 1,  "rose"       => 1, "flame"      => 2,
      "and"        => 2,  "heat"       => 2, "came"       => 1,
      "across"     => 1,  "from"       => 1
    }
    freq = @ta.word_frequency
    assert_equal(expected, @ta.word_frequency)
  end

  def test_ordered_words
    assert_equal(@expected_ordered_words, @ta.ordered_words)
  end

  def test_top_n
    expected = @expected_ordered_words
    actual = @ta.top_n(@expected_ordered_words.length)
    assert_equal(expected.map(&:first), actual.map(&:first))
    expected.each_with_index do |word, i|
      expected_idf = Math.log(@file_lines.to_f / word.last)
      actual_idf = actual[i].last
      assert_in_delta(expected_idf, actual_idf, 0.00000001)
    end
  end

  private
    # cribbed from MiniTest
    def assert_in_delta exp, act, delta = 0.001, msg = nil
      n = (exp - act).abs
      assert delta >= n, "Expected #{exp} - #{act} (#{n}) to be < #{delta}."
    end
end
