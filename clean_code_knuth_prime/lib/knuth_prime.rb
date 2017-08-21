require 'byebug'

class PrintPrimes
  NUMBER_OF_PRIME = 1000
  ROW_PER_PAGE = 50
  COLUMN_COUNT = 4

  def self.main(*args)
    prime_numbers = generate_prime_numbers

    output_prime_number_table(prime_numbers)
  end


  def self.generate_prime_numbers
    prime_numbers = Array.new
    multiples_of_found_primes = Array.new(1)
    @@prime_multiple_hash = {}


    candidate_prime = 1
    prime_numbers[0] = 2

    while prime_numbers.count < NUMBER_OF_PRIME do

      candidate_is_prime = false
      while (!candidate_is_prime)
        # skips even numbers
        candidate_prime += 2

        # Loop until you find a prime number
        candidate_is_prime = true
        n = 1
        while (n < prime_numbers.size) && candidate_is_prime do
          if is_multiple_of_prime?(candidate_prime, prime_numbers[n])
            candidate_is_prime = false
          end
          n += 1
        end
      end

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

  def self.is_multiple_of_prime?(candidate_prime, prime_number)
    prime_multiple = advance_prime_multiple(candidate_prime, prime_number)

    prime_multiple == candidate_prime
  end

  def self.advance_prime_multiple( candidate_prime, prime_number)
    current_prime_multiple = @@prime_multiple_hash[prime_number]
    while (current_prime_multiple < candidate_prime) do
      # we can advance the number by twice it's value since we are not checking for mutiples of two
      current_prime_multiple += (2*prime_number)
    end
    @@prime_multiple_hash[prime_number] = current_prime_multiple
    current_prime_multiple
  end
end