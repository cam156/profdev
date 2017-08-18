
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
    mult = Array.new

    j = 1
    k = 1
    prime_numbers[1] = 2
    ord = 2
    square = 9

    while k < NUMBER_OF_PRIME do
      begin
        j += 2
        if j == square
          ord = ord + 1
          square = prime_numbers[ord] * prime_numbers[ord]
          mult[ord - 1] = j
        end
        n = 2
        jprime = true
        while (n < ord) && jprime do
          while (mult[n] < j) do
            mult[n] = mult[n] + prime_numbers[n] + prime_numbers[n]
          end
          if mult[n] == j
            jprime = false
          end
          n += 1
        end
      end while (!jprime)
      k += 1
      prime_numbers[k] = j
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