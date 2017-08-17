gem 'minitest', '~> 5.4'
require 'minitest/autorun'
require 'prime'
require_relative '../lib/knuth_prime'


class KnuthTest < Minitest::Test

  PRIMES= "the first 1000 prime numbers --- page 1\n\
2, 233, 547, 877\n\
3, 239, 557, 881\n\
5, 241, 563, 883\n\
7, 251, 569, 887\n\
11, 257, 571, 907\n\
13, 263, 577, 911\n\
17, 269, 587, 919\n\
19, 271, 593, 929\n\
23, 277, 599, 937\n\
29, 281, 601, 941\n\
31, 283, 607, 947\n\
37, 293, 613, 953\n\
41, 307, 617, 967\n\
43, 311, 619, 971\n\
47, 313, 631, 977\n\
53, 317, 641, 983\n\
59, 331, 643, 991\n\
61, 337, 647, 997\n\
67, 347, 653, 1009\n\
71, 349, 659, 1013\n\
73, 353, 661, 1019\n\
79, 359, 673, 1021\n\
83, 367, 677, 1031\n\
89, 373, 683, 1033\n\
97, 379, 691, 1039\n\
101, 383, 701, 1049\n\
103, 389, 709, 1051\n\
107, 397, 719, 1061\n\
109, 401, 727, 1063\n\
113, 409, 733, 1069\n\
127, 419, 739, 1087\n\
131, 421, 743, 1091\n\
137, 431, 751, 1093\n\
139, 433, 757, 1097\n\
149, 439, 761, 1103\n\
151, 443, 769, 1109\n\
157, 449, 773, 1117\n\
163, 457, 787, 1123\n\
167, 461, 797, 1129\n\
173, 463, 809, 1151\n\
179, 467, 811, 1153\n\
181, 479, 821, 1163\n\
191, 487, 823, 1171\n\
193, 491, 827, 1181\n\
197, 499, 829, 1187\n\
199, 503, 839, 1193\n\
211, 509, 853, 1201\n\
223, 521, 857, 1213\n\
227, 523, 859, 1217\n\
229, 541, 863, 1223\n\
the first 1000 prime numbers --- page 2\n\
1229, 1597, 1993, 2371\n\
1231, 1601, 1997, 2377\n\
1237, 1607, 1999, 2381\n\
1249, 1609, 2003, 2383\n\
1259, 1613, 2011, 2389\n\
1277, 1619, 2017, 2393\n\
1279, 1621, 2027, 2399\n\
1283, 1627, 2029, 2411\n\
1289, 1637, 2039, 2417\n\
1291, 1657, 2053, 2423\n\
1297, 1663, 2063, 2437\n\
1301, 1667, 2069, 2441\n\
1303, 1669, 2081, 2447\n\
1307, 1693, 2083, 2459\n\
1319, 1697, 2087, 2467\n\
1321, 1699, 2089, 2473\n\
1327, 1709, 2099, 2477\n\
1361, 1721, 2111, 2503\n\
1367, 1723, 2113, 2521\n\
1373, 1733, 2129, 2531\n\
1381, 1741, 2131, 2539\n\
1399, 1747, 2137, 2543\n\
1409, 1753, 2141, 2549\n\
1423, 1759, 2143, 2551\n\
1427, 1777, 2153, 2557\n\
1429, 1783, 2161, 2579\n\
1433, 1787, 2179, 2591\n\
1439, 1789, 2203, 2593\n\
1447, 1801, 2207, 2609\n\
1451, 1811, 2213, 2617\n\
1453, 1823, 2221, 2621\n\
1459, 1831, 2237, 2633\n\
1471, 1847, 2239, 2647\n\
1481, 1861, 2243, 2657\n\
1483, 1867, 2251, 2659\n\
1487, 1871, 2267, 2663\n\
1489, 1873, 2269, 2671\n\
1493, 1877, 2273, 2677\n\
1499, 1879, 2281, 2683\n\
1511, 1889, 2287, 2687\n\
1523, 1901, 2293, 2689\n\
1531, 1907, 2297, 2693\n\
1543, 1913, 2309, 2699\n\
1549, 1931, 2311, 2707\n\
1553, 1933, 2333, 2711\n\
1559, 1949, 2339, 2713\n\
1567, 1951, 2341, 2719\n\
1571, 1973, 2347, 2729\n\
1579, 1979, 2351, 2731\n\
1583, 1987, 2357, 2741\n\
the first 1000 prime numbers --- page 3\n\
2749, 3187, 3581, 4001\n\
2753, 3191, 3583, 4003\n\
2767, 3203, 3593, 4007\n\
2777, 3209, 3607, 4013\n\
2789, 3217, 3613, 4019\n\
2791, 3221, 3617, 4021\n\
2797, 3229, 3623, 4027\n\
2801, 3251, 3631, 4049\n\
2803, 3253, 3637, 4051\n\
2819, 3257, 3643, 4057\n\
2833, 3259, 3659, 4073\n\
2837, 3271, 3671, 4079\n\
2843, 3299, 3673, 4091\n\
2851, 3301, 3677, 4093\n\
2857, 3307, 3691, 4099\n\
2861, 3313, 3697, 4111\n\
2879, 3319, 3701, 4127\n\
2887, 3323, 3709, 4129\n\
2897, 3329, 3719, 4133\n\
2903, 3331, 3727, 4139\n\
2909, 3343, 3733, 4153\n\
2917, 3347, 3739, 4157\n\
2927, 3359, 3761, 4159\n\
2939, 3361, 3767, 4177\n\
2953, 3371, 3769, 4201\n\
2957, 3373, 3779, 4211\n\
2963, 3389, 3793, 4217\n\
2969, 3391, 3797, 4219\n\
2971, 3407, 3803, 4229\n\
2999, 3413, 3821, 4231\n\
3001, 3433, 3823, 4241\n\
3011, 3449, 3833, 4243\n\
3019, 3457, 3847, 4253\n\
3023, 3461, 3851, 4259\n\
3037, 3463, 3853, 4261\n\
3041, 3467, 3863, 4271\n\
3049, 3469, 3877, 4273\n\
3061, 3491, 3881, 4283\n\
3067, 3499, 3889, 4289\n\
3079, 3511, 3907, 4297\n\
3083, 3517, 3911, 4327\n\
3089, 3527, 3917, 4337\n\
3109, 3529, 3919, 4339\n\
3119, 3533, 3923, 4349\n\
3121, 3539, 3929, 4357\n\
3137, 3541, 3931, 4363\n\
3163, 3547, 3943, 4373\n\
3167, 3557, 3947, 4391\n\
3169, 3559, 3967, 4397\n\
3181, 3571, 3989, 4409\n\
the first 1000 prime numbers --- page 4\n\
4421, 4861, 5281, 5701\n\
4423, 4871, 5297, 5711\n\
4441, 4877, 5303, 5717\n\
4447, 4889, 5309, 5737\n\
4451, 4903, 5323, 5741\n\
4457, 4909, 5333, 5743\n\
4463, 4919, 5347, 5749\n\
4481, 4931, 5351, 5779\n\
4483, 4933, 5381, 5783\n\
4493, 4937, 5387, 5791\n\
4507, 4943, 5393, 5801\n\
4513, 4951, 5399, 5807\n\
4517, 4957, 5407, 5813\n\
4519, 4967, 5413, 5821\n\
4523, 4969, 5417, 5827\n\
4547, 4973, 5419, 5839\n\
4549, 4987, 5431, 5843\n\
4561, 4993, 5437, 5849\n\
4567, 4999, 5441, 5851\n\
4583, 5003, 5443, 5857\n\
4591, 5009, 5449, 5861\n\
4597, 5011, 5471, 5867\n\
4603, 5021, 5477, 5869\n\
4621, 5023, 5479, 5879\n\
4637, 5039, 5483, 5881\n\
4639, 5051, 5501, 5897\n\
4643, 5059, 5503, 5903\n\
4649, 5077, 5507, 5923\n\
4651, 5081, 5519, 5927\n\
4657, 5087, 5521, 5939\n\
4663, 5099, 5527, 5953\n\
4673, 5101, 5531, 5981\n\
4679, 5107, 5557, 5987\n\
4691, 5113, 5563, 6007\n\
4703, 5119, 5569, 6011\n\
4721, 5147, 5573, 6029\n\
4723, 5153, 5581, 6037\n\
4729, 5167, 5591, 6043\n\
4733, 5171, 5623, 6047\n\
4751, 5179, 5639, 6053\n\
4759, 5189, 5641, 6067\n\
4783, 5197, 5647, 6073\n\
4787, 5209, 5651, 6079\n\
4789, 5227, 5653, 6089\n\
4793, 5231, 5657, 6091\n\
4799, 5233, 5659, 6101\n\
4801, 5237, 5669, 6113\n\
4813, 5261, 5683, 6121\n\
4817, 5273, 5689, 6131\n\
4831, 5279, 5693, 6133\n\
the first 1000 prime numbers --- page 5\n\
6143, 6577, 7001, 7507\n\
6151, 6581, 7013, 7517\n\
6163, 6599, 7019, 7523\n\
6173, 6607, 7027, 7529\n\
6197, 6619, 7039, 7537\n\
6199, 6637, 7043, 7541\n\
6203, 6653, 7057, 7547\n\
6211, 6659, 7069, 7549\n\
6217, 6661, 7079, 7559\n\
6221, 6673, 7103, 7561\n\
6229, 6679, 7109, 7573\n\
6247, 6689, 7121, 7577\n\
6257, 6691, 7127, 7583\n\
6263, 6701, 7129, 7589\n\
6269, 6703, 7151, 7591\n\
6271, 6709, 7159, 7603\n\
6277, 6719, 7177, 7607\n\
6287, 6733, 7187, 7621\n\
6299, 6737, 7193, 7639\n\
6301, 6761, 7207, 7643\n\
6311, 6763, 7211, 7649\n\
6317, 6779, 7213, 7669\n\
6323, 6781, 7219, 7673\n\
6329, 6791, 7229, 7681\n\
6337, 6793, 7237, 7687\n\
6343, 6803, 7243, 7691\n\
6353, 6823, 7247, 7699\n\
6359, 6827, 7253, 7703\n\
6361, 6829, 7283, 7717\n\
6367, 6833, 7297, 7723\n\
6373, 6841, 7307, 7727\n\
6379, 6857, 7309, 7741\n\
6389, 6863, 7321, 7753\n\
6397, 6869, 7331, 7757\n\
6421, 6871, 7333, 7759\n\
6427, 6883, 7349, 7789\n\
6449, 6899, 7351, 7793\n\
6451, 6907, 7369, 7817\n\
6469, 6911, 7393, 7823\n\
6473, 6917, 7411, 7829\n\
6481, 6947, 7417, 7841\n\
6491, 6949, 7433, 7853\n\
6521, 6959, 7451, 7867\n\
6529, 6961, 7457, 7873\n\
6547, 6967, 7459, 7877\n\
6551, 6971, 7477, 7879\n\
6553, 6977, 7481, 7883\n\
6563, 6983, 7487, 7901\n\
6569, 6991, 7489, 7907\n\
6571, 6997, 7499, 7919\n"

  def test_output
    out, err = capture_io do
      PrintPrimes.main
    end
    assert_equal out, PRIMES
  end

  def test_primes
    assert_equal PrintPrimes.main, Prime.first(1000)
  end
end
