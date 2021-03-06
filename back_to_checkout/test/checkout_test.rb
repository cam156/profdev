gem 'minitest', '~> 5.4'
require 'minitest/autorun'
require_relative '../lib/register'

class RegisterTest < Minitest::Test
  def RULES
    {
      A: { price_per_item: 50, special: { number: 3, price: 130 } },
      B: { price_per_item: 30, special: { number: 2, price: 45 } },
      C: { price_per_item: 20 },
      D: { price_per_item: 15 }
    }
  end

  def test_price
    assert_equal(0, Register.new(self.RULES).checkout(""))
    assert_equal( 50,Register.new(self.RULES).checkout("A"))
    assert_equal( 80,Register.new(self.RULES).checkout("B"))
    assert_equal( 80,Register.new(self.RULES).checkout("AA"))
    assert_equal( 80,Register.new(self.RULES).checkout("AB"))
    assert_equal(115,Register.new(self.RULES).checkout("CDBA"))
    #
    assert_equal(100,Register.new(self.RULES).checkout("AA"))
    assert_equal(130,Register.new(self.RULES).checkout("AAA"))
    assert_equal(180,Register.new(self.RULES).checkout("AAAA"))
    assert_equal(230,Register.new(self.RULES).checkout("AAAAA"))
    assert_equal(260,Register.new(self.RULES).checkout("AAAAAA"))
    #
    assert_equal(160,Register.new(self.RULES).checkout("AAAB"))
    assert_equal(175,Register.new(self.RULES).checkout("AAABB"))
    assert_equal(190,Register.new(self.RULES).checkout("AAABBD"))
    assert_equal(190,Register.new(self.RULES).checkout("DABABA"))
  end

  def test_incremental
    register = Register.new(self.RULES)
    assert_equal(0, register.total)
    register.scan('A');  assert_equal(50, register.total)
    register.scan('B');  assert_equal(80, register.total)
    register.scan('A');  assert_equal(130, register.total)
    register.scan('A');  assert_equal(160, register.total)
    register.scan('B');  assert_equal(175, register.total)
  end
end
