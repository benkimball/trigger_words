class TokenAnalyzer

  attr_reader :contexts

  def initialize(stream)
    @contexts = stream.readlines

    # precompute log(N) for performance
    @log_n = Math.log(@contexts.length)
  end

  def word_frequency
    @word_frequency ||= begin
      # use a hash to collect words, in order to get de-duplication for free
      freq = Hash.new(0)
      contexts.each do |context|
        context.split.each { |word| freq[word.downcase] += 1 }
      end
      freq
    end
  end

  def ordered_words
    # we may sort by incidence rather than computing IDF because
    # f(x) = C - log(x) is strictly decreasing
    @ordered_words ||= begin
      word_frequency.to_a.sort_by do |(word, ct)|
        "%10d%s" % [ct, word]
      end
    end
  end

  def top_n(n)
    # delay computing IDF until the very last second before output
    ordered_words.take(n).map do |(word, ct)|
      [word, idf(word, ct)]
    end
  end

  private
    def idf(token, incidence)
      # log(x/y) = log(x) - log(y)
      # since x does not change, precompute it (in @log_n) for performance
      (@log_n - Math.log(incidence))
    end

end
