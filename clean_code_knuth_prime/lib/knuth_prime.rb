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
    prime_multiplier_array = Array.new(2)

    candidate_prime = 1
    prime_numbers[1] = 2
    square = 9

    #byebug
    while (prime_numbers.count-1) < NUMBER_OF_PRIME do

      candidate_is_prime = false
      while (!candidate_is_prime)
        # skips even numbers
        candidate_prime += 2

        # Find our search limit
        if candidate_prime == square
          prime_multiplier_array << candidate_prime
          square = prime_numbers[prime_multiplier_array.size] ** 2
        end

        # Loop until you find a prime number
        candidate_is_prime = true
        n = 2
        while (n < prime_multiplier_array.size) && candidate_is_prime do
          while (prime_multiplier_array[n] < candidate_prime) do
            prime_multiplier_array[n] = prime_multiplier_array[n] + prime_numbers[n] + prime_numbers[n]
          end

          if prime_multiplier_array[n] == candidate_prime
            candidate_is_prime = false
          end
          n += 1
        end
      end

      prime_numbers << candidate_prime
    end

    prime_numbers
  end

  def self.output_prime_number_table(prime_numbers)
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
end