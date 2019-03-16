const reduceInputValue = (acc, val) => parseInt(acc) + parseInt(val)

function initStockView(stockViewId, maxStock) {
  stockView = document.getElementById(stockViewId)
  stockInput = document.getElementById('stock')
  attrStatWrapper = document.getElementsByClassName('attr-stat-wrapper')[0]
  inputs = Array.from(attrStatWrapper.getElementsByTagName('input'))
  inputs = inputs.map( i => i.value )
  console.log(inputs)
  stockUsed = inputs.reduce(reduceInputValue, 0)
  console.log(maxStock, stockUsed)
  stockAvailable = maxStock - stockUsed
  stockView.innerHTML = stockAvailable
  stockInput.value = stockAvailable
}

function incStockView(stockViewId, stockNbr) {
  stockView = document.getElementById(stockViewId)
  stockView.innerHTML = stockNbr.toString()
}

function decStockView(stockViewId) {
  stockView = document.getElementById(stockViewId)
  stock = parseInt(stockView.innerHTML)
  console.log(stock)
  stockView.innerHTML = (--stock).toString()
}
