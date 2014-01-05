# -*- encoding: utf-8 -*-

require "Matrix"
require './MyArray'
require './MultivariateUtil'

y = [45,38,41,34,59,47,35,43,54,52] # 配向度
x1 = [17.5,17.0,18.5,16.0,19.0,19.5,16.0,18.0,19.0,19.5] # 温度
x2 = [30,25,20,30,45,35,25,35,35,40] # 圧力

puts "y: ",y.mean
puts "x1: ",x1.mean
puts "x2: ",x2.mean

puts "偏差平方和"

devsq_y = y.devsq
devsq_x1 = x1.devsq
devsq_x2 = x2.devsq

puts "y:",devsq_y
puts "x1:",devsq_x1
puts "x2:",devsq_x2

puts "偏差積和"
c_y_x1 = y.devmulOf(x1)
c_y_x2 = y.devmulOf(x2)
c_x1_x2 = x1.devmulOf(x2)

puts "y_x1:",c_y_x1
puts "y_x2:",c_y_x2
puts "x1_x2:",c_x1_x2

puts "\t配向度\t温度\t圧力"
puts "配向度\t#{devsq_y}\t#{c_y_x1}\t#{c_y_x2}"
puts "温度\t#{c_y_x1}\t#{devsq_x1}\t#{c_x1_x2}"
puts "圧力\t#{c_y_x2}\t#{c_x1_x2}\t#{devsq_x2}"

puts

puts "連立方程式"
puts "#{c_y_x1} = #{devsq_x1}b1 + #{c_x1_x2}b2"
puts "#{c_y_x2} = #{c_x1_x2}b1 + #{devsq_x2}b2"
puts "b0 = #{y.mean} - #{x1.mean}b1 - #{x2.mean}b2"

b2 = (c_x1_x2 * c_y_x1 - devsq_x1 * c_y_x2) / (c_x1_x2  * c_x1_x2 - devsq_x1 * devsq_x2)
b1 = (c_y_x1 - c_x1_x2 * b2) / devsq_x1
b0 = y.mean - x1.mean * b1 - x2.mean * b2

print "b0:",b0,"\n"
print "b1:",b1,"\n"
print "b2:",b2,"\n"

puts
puts "行列を使った方法"
left = Matrix[
  [devsq_x1, c_x1_x2],
  [c_x1_x2, devsq_x2]
]
right = Matrix[
  [c_y_x1],
  [c_y_x2]
]

bm = left.inverse * right
ym = y.mean - bm[0, 0] * x1.mean - bm[1, 0] * x2.mean
p bm
p ym

puts
puts "クラス化した方法"
multi = MultivariateUtil.new(y, [x1, x2])
p multi.modulus