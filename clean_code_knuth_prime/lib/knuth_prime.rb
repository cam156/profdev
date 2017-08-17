
class PrintPrimes
  M = 1000
  RR = 50
  CC = 4
  WW = 10
  ORDMAX = 30

  def self.main(*args)
    p = Array.new(M+1)
    mult = Array.new(ORDMAX + 1)

    j = 1
    k = 1
    p[0] = 1
    p[1] = 2
    ord = 2
    square = 9
    while k < M do
      begin
        j += 2
        if j == square
          ord = ord + 1
          square = p[ord] * p[ord]
          mult[ord - 1] = j
        end
        n = 2
        jprime = true
        while (n < ord) && jprime do
          while (mult[n] < j) do
            mult[n] = mult[n] + p[n] + p[n]
          end
          if mult[n] == j
            jprime = false
          end
          n += 1
        end
      end while (!jprime)
      k += 1
      p[k] = j
    end
    pagenumber = 1
    pageoffset = 1
    while pageoffset <= M do
      puts("the first #{M} prime numbers --- page #{pagenumber}\n" )
      rowoffset = pageoffset
      while rowoffset < (pageoffset + RR ) do
        c = 0
        outstring = ''
        while c < CC do
          if (rowoffset + c * RR) <= M
            if outstring.size > 0
              outstring = outstring.concat ", "
            end
            outstring.concat p[rowoffset + c * RR].to_s
          end
          c+=1
        end
        rowoffset+=1
        puts outstring
      end
      pagenumber += 1
      pageoffset += (RR * CC)
    end

    p.slice(1,1000)
  end
end