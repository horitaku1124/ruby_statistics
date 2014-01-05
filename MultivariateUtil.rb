class MultivariateUtil

  def initialize(y, xArray)
    @y = y
    @xArray = xArray

    left = []
    right = []
    num = xArray.length

    num.times do |i|
      left[i] = []
      right[i] = []
      num.times do |j|
        if i == j
          left[i] << xArray[i].devsq
        else
          left[i] << xArray[i].devmulOf(xArray[j])
        end
      end
      right[i] = [y.devmulOf(xArray[i])]
    end
    leftMatrix = Matrix.rows(left)
    rightMatrix = Matrix.rows(right)


    @num = num
    @leftMatrix = leftMatrix
    @rightMatrix = rightMatrix
  end

  def modulus
    im = @leftMatrix.inverse * @rightMatrix
    yl = @y.mean
    xa = []
    @num.times do |i|
      yl -= @xArray[i].mean * im[i, 0]
      xa << im[i, 0]
    end
    [yl, xa]
  end
end