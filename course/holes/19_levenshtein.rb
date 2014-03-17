#
# Levenshtein distance algorithm implementation for Ruby, with UTF-8 support.
#
# The Levenshtein distance is a measure of how similar two strings s and t are,
# calculated as the number of deletions/insertions/substitutions needed to
# transform s into t. The greater the distance, the more the strings differ.
#
# The Levenshtein distance is also sometimes referred to as the
# easier-to-pronounce-and-spell 'edit distance'.
#

module Text # :nodoc:
module Levenshtein

  # Calculate the Levenshtein distance between two strings +str1+ and +str2+.
  #
  # The optional argument max_distance can reduce the number of iterations by
  # stopping if the Levenshtein distance exceeds this value. This increases
  # performance where it is only necessary to compare the distance with a
  # reference value instead of calculating the exact distance.
  #
  # The distance is calculated in terms of Unicode codepoints. Be aware that
  # this algorithm does not perform normalisation: if there is a possibility
  # of different normalised forms being used, normalisation should be performed
  # beforehand.
  #
  def distance(str1, str2, max_distance = nil)
    if max_distance
      distance_with_maximum(str1, str2, max_distance)
    else
      distance_without_maximum(str1, str2)
    end
  end

private
  def distance_with_maximum(str1, str2, max_distance) # :nodoc:
    s, t = [str1, str2].sort_by(&:length).
                        map{ |str| str.encode(Encoding::UTF_8).unpack("U*") }
    n = s.length
    m = t.length
    big_int = n * m
    return m if n.zero?
    return n if m.zero?
    return 0 if s == t

    # If the length difference is already greater than the max_distance, then
    # there is nothing else to check
    if (n - m).abs >= max_distance
      return max_distance
    end

    # The values necessary for our threshold are written; the ones after must
    # be filled with large integers since the tailing member of the threshold
    # window in the bottom array will run min across them
    d = (m + 1).times.map { |i|
      if i < m || i < max_distance + 1
        i
      else
        big_int
      end
    }
    x = nil
    e = nil

    n.times do |i|
      # Since we're reusing arrays, we need to be sure to wipe the value left
      # of the starting index; we don't have to worry about the value above the
      # ending index as the arrays were initially filled with large integers
      # and we progress to the right
      if e.nil?
        e = i + 1
      else
        e = big_int
      end

      diag_index = t.length - s.length + i

      # If max_distance was specified, we can reduce second loop. So we set
      # up our threshold window.
      # See:
      # Gusfield, Dan (1997). Algorithms on strings, trees, and sequences:
      # computer science and computational biology.
      # Cambridge, UK: Cambridge University Press. ISBN 0-521-58519-8.
      # pp. 263–264.
      min = [0, i - max_distance - 1].max
      max = [m - 1, i + max_distance].min

      (min .. max).each do |j|
        # If the diagonal value is already greater than the max_distance
        # then we can safety return: the diagonal will never go lower again.
        # See: http://www.levenshtein.net/
        if j == diag_index && d[j] >= max_distance
          return max_distance
        end

        cost = s[i] == t[j] ? 0 : 1
        x = [
          d[j+1] + 1, # insertion
          e + 1,      # deletion
          d[j] + cost # substitution
        ].min

        d[j] = e
        e = x
      end
      d[m] = x
    end

    if x > max_distance
      return max_distance
    else
      return x
    end
  end

  def distance_without_maximum(str1, str2) # :nodoc:
    first, second = [str1, str2].map{ |str| str.encode(Encoding::UTF_8).unpack("U*") }
    n = first.length
    m = second.length
    return m if n.zero?
    return n if m.zero?

    matrix = [(0..first.length).to_a]
    (1..second.length).each do |j|
      matrix << [j] + [0] * (first.length)
    end
 
    (1..second.length).each do |i|
      (1..first.length).each do |j|
        if first[j-1] == second[i-1]
          matrix[i][j] = matrix[i-1][j-1]
        else
          matrix[i][j] = [
            matrix[i-1][j],
            matrix[i][j-1],
            matrix[i-1][j-1],
          ].min + 1
        end
      end
    end
    return matrix.last.last
  end

  extend self
end
end

while line = gets do
  word1, word2 = line.split
  puts Text::Levenshtein.distance word1.to_s, word2.to_s
end
