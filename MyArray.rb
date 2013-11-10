class Array

  # 総和
  def sum
    s = 0.0
    self.each do |n|
      s += n.to_f
    end
    s
  end

  # 相加平均
  def mean
    self.sum / self.length
  end

  alias average mean

  # 偏差平方和
  def devsq
    s = self.mean
    d = 0.0
    self.each do |n|
      d += ((n - s) ** 2)
    end
    d
  end

  # 分散(標本分散)
  def varp
    self.devsq / self.length
  end

  # 分散(不偏分散)
  def var
    self.devsq / (self.length - 1)
  end

  # 標準偏差(標本標準偏差)
  def stdev
    Math.sqrt(self.var)
  end

  # 標準偏差
  def stdevp
    Math.sqrt(self.devsq / self.length)
  end

  # 共分散(偏差積和)
  def covarOf array2
    if self.length != array2.length then raise "Different array size." end

    mean1 = self.mean
    mean2 = array2.mean

    mul = 0.0
    self.length.times do |i|
      mul += (self[i] - mean1) * (array2[i] - mean2)
    end
    mul / self.length
  end

  # 相関係数
  def correlOf array2
    if self.length != array2.length then raise "Different array size." end

    self.covarOf(array2) / self.stdevp / array2.stdevp
  end
end