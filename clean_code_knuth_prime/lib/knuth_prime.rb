require 'byebug'

class PrintPrimes
  NUMBER_OF_PRIME = 1000
  ROW_PER_PAGE = 50
  COLUMN_COUNT = 4
  INITIAL_PRIME = 2

  def self.main(*args)
    prime_numbers = generate_prime_numbers

    output_prime_number_table(prime_numbers)
  end


  def self.generate_prime_numbers
    prime_numbers = [INITIAL_PRIME]
    @@prime_multiple_hash = {}
    candidate_prime = INITIAL_PRIME+1

    while prime_numbers.count < NUMBER_OF_PRIME do

      candidate_prime = find_next_prime(candidate_prime, prime_numbers[1..-1])

      # the candidate is prime assign it to the list and add it
      # to the possible mutiples find in other numbers
      prime_numbers << candidate_prime
      @@prime_multiple_hash[candidate_prime] = candidate_prime
    end

    prime_numbers
  end

  def self.output_prime_number_table(prime_numbers)
    prime_numbers.unshift(nil)
    pagenumber = 1
    pageoffset = 1
    while pageoffset <= NUMBER_OF_PRIME do
      puts("the first #{NUMBER_OF_PRIME} prime numbers --- page #{pagenumber}\n" )
      rowoffset = pageoffset
      while rowoffset < (pageoffset + ROW_PER_PAGE ) do
        c = 0
        outstring = ''
        while c < COLUMN_COUNT do
          if (rowoffset + c * ROW_PER_PAGE) <= NUMBER_OF_PRIME
            if outstring.size > 0
              outstring = outstring.concat ", "
            end
            outstring.concat prime_numbers[rowoffset + c * ROW_PER_PAGE].to_s
          end
          c+=1
        end
        rowoffset+=1
        puts outstring
      end
      pagenumber += 1
      pageoffset += (ROW_PER_PAGE * COLUMN_COUNT)
    end
  end

  def self.find_next_prime(candidate_prime, prime_numbers_after_2)
    candidate_is_not_prime = true
    while (candidate_is_not_prime)
      if candidate_is_prime?(candidate_prime, prime_numbers_after_2)
        candidate_is_not_prime = false
      else
        # check the next number skipping the even numbers
        candidate_prime += 2
      end
    end
    candidate_prime
  end

  def self.candidate_is_prime?(candidate_prime, prime_numbers_after_2)
    # assume the candidate is prime until we discover a multiple or another prime we already found
    candidate_is_prime = true

    # loop through primes we have already found and determine if any of those numbers are a multiple of the canidate
    prime_numbers_after_2.each do |current_prime|
      candidate_is_prime = !is_multiple_of_prime?(candidate_prime, current_prime)
      unless candidate_is_prime
        break
      end
    end
    candidate_is_prime
  end

  def self.is_multiple_of_prime?(candidate_prime, prime_number)
    candidate_prime == advance_prime_multiple(candidate_prime, prime_number)
  end

  def self.advance_prime_multiple( candidate_prime, prime_number)
    while (@@prime_multiple_hash[prime_number] < candidate_prime) do
      # we can advance the number by twice it's value since we are not checking for mutiples of two
      @@prime_multiple_hash[prime_number] += (2*prime_number)
    end
    @@prime_multiple_hash[prime_number]
  end
end