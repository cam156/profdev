require 'byebug'

class PrintPrimes
  NUMBER_OF_PRIME = 1000
  ROW_PER_PAGE = 50
  COLUMN_COUNT = 4
  INITIAL_PRIME = 2

  def self.main(*_args)
    prime_numbers = generate_prime_numbers

    output_prime_number_table(prime_numbers)
  end

  def self.generate_prime_numbers
    prime_numbers = [INITIAL_PRIME]
    @prime_multiple_hash = {}
    actual_prime = 1

    while prime_numbers.count < NUMBER_OF_PRIME
      prime_numbers_after_2 = prime_numbers[1..-1]
      candidate_prime = next_candidate(actual_prime)

      actual_prime = find_next_prime(candidate_prime, prime_numbers_after_2)

      prime_numbers << actual_prime
    end

    prime_numbers
  end

  def self.output_prime_number_table(prime_numbers)
    prime_numbers.unshift(nil)
    pagenumber = 1
    pageoffset = 1
    while pageoffset <= NUMBER_OF_PRIME
      puts("the first #{NUMBER_OF_PRIME} prime numbers --- page #{pagenumber}\n")
      rowoffset = pageoffset
      while rowoffset < (pageoffset + ROW_PER_PAGE)
        c = 0
        outstring = ''
        while c < COLUMN_COUNT
          if (rowoffset + c * ROW_PER_PAGE) <= NUMBER_OF_PRIME
            outstring = outstring.concat ', ' unless outstring.empty?
            outstring.concat prime_numbers[rowoffset + c * ROW_PER_PAGE].to_s
          end
          c += 1
        end
        rowoffset += 1
        puts outstring
      end
      pagenumber += 1
      pageoffset += (ROW_PER_PAGE * COLUMN_COUNT)
    end
  end

  def self.next_candidate(candidate_prime)
    # check the next number skipping the even numbers
    candidate_prime + 2
  end

  def self.find_next_prime(candidate_prime, prime_numbers_found_after_two)
    candidate_is_not_prime = true
    while candidate_is_not_prime
      if candidate_is_prime?(candidate_prime, prime_numbers_found_after_two)
        candidate_is_not_prime = false
      else
        candidate_prime = next_candidate(candidate_prime)
      end
    end
    @prime_multiple_hash[candidate_prime] = candidate_prime
    candidate_prime
  end

  def self.candidate_is_prime?(candidate_prime, prime_numbers_found_after_two)
    # assume the candidate is prime
    #  until we discover a multiple of another prime we already found
    candidate_is_prime = true

    prime_numbers_found_after_two.each do |current_prime|
      candidate_is_prime = !multiple_of_prime?(candidate_prime, current_prime)
      break unless candidate_is_prime
    end

    candidate_is_prime
  end

  def self.multiple_of_prime?(candidate_prime, prime_number)
    candidate_prime == advance_prime_multiple(candidate_prime, prime_number)
  end

  def self.advance_prime_multiple(candidate_prime, prime_number)
    while @prime_multiple_hash[prime_number] < candidate_prime
      # we can advance the number by twice it's value
      #   since we are not checking for mutiples of two
      @prime_multiple_hash[prime_number] += (2 * prime_number)
    end
    @prime_multiple_hash[prime_number]
  end
end
